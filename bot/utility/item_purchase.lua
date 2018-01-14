local logger = require(
  GetScriptDirectory() .."/utility/logger")

local item_recipe = require(
  GetScriptDirectory() .."/database/item_recipe")

local item_build = require(
  GetScriptDirectory() .."/database/item_build")

local item_sell = require(
  GetScriptDirectory() .."/database/item_sell")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

local function IsTpScrollPresent(npc_bot)
  local tp_scroll = npc_bot:FindItemSlot("item_tpscroll")

  return tp_scroll ~= -1
end

local function PurchaseCourier(npc_bot)
  if GetNumCouriers() > 0 then return end

  local players = GetTeamPlayers(GetTeam())

  -- Buy courier only by a player of 5th position
  if players[5] == npc_bot:GetPlayerID() then

    logger.Print("PurchaseCourier() - " .. npc_bot:GetUnitName() .. " bought courier")

    npc_bot:ActionImmediate_PurchaseItem("item_courier")
  end
end

local function PurchaseTpScroll(npc_bot)
  if IsTpScrollPresent(npc_bot) then return end

  if (npc_bot:GetGold() >= GetItemCost("item_tpscroll")) then

    functions.SetItemToBuy(npc_bot, "item_tpscroll")
  end
end

local function IsRecipeItem(item)
  return item_recipe.ITEM_RECIPE[item] ~= nil
end

local function GetInventoryAndStashItems(npc_bot)
  local _, result = functions.GetItems(
    npc_bot,
    constants.INVENTORY_AND_STASH_MAX_INDEX)

  return result
end

local function IsItemAlreadyBought(inventory, item)
  local index = functions.GetElementIndexInList(inventory, item)

  -- This nil assignment is required to process recipes with several
  -- identical components
  if index ~= -1 then
    inventory[index] = "nil"
    return true
  end
  return false
end

local function FindNextComponentToBuy(npc_bot, item)
  -- Do not buy anything until curier bring some items
  if npc_bot:GetCourierValue() > 0 then return "nil" end

  local component_list = item_recipe.ITEM_RECIPE[item].components

  local inventory = GetInventoryAndStashItems(npc_bot)

  for _, component in functions.spairs(component_list) do
    if component ~= "nil"
      and not IsItemAlreadyBought(inventory, component) then

      if IsRecipeItem(component) then
        return FindNextComponentToBuy(npc_bot, component)
      else
        return component
      end
    end
  end

  return "nil"
end

local function PurchaseItem(bot, item)
  if IsRecipeItem(item) then
    item = FindNextComponentToBuy(bot, item)
  end

  if item == "nil" or (bot:GetGold() < GetItemCost(item)) then
    return
  end

  functions.SetItemToBuy(bot, item)
end

local function FindNextItemToBuy(item_list)
  for i, item in functions.spairs(item_list) do
    if item ~= "nil" then return i, item end
  end

  return -1, "nil"
end

local function PurchaseItemList(npc_bot)
  if functions.GetItemToBuy(npc_bot) ~= nil then return end

  local item_list = item_build.ITEM_BUILD[npc_bot:GetUnitName()].items

  local i, item = FindNextItemToBuy(item_list)

  if i ~= -1
    and item ~= "nil"
    and functions.IsElementInList(
      GetInventoryAndStashItems(
        npc_bot),
        item) then

    item_list[i] = "nil"
    return
  end

  PurchaseItem(npc_bot, item)
end

local function SellItemByIndex(npc_bot, index, condition)
  local item = npc_bot:GetItemInSlot(index);

  -- We should sell an item despite the condition if we want to buy
  -- item and an inventory is full.

  if functions.GetItemToBuy(npc_bot) == nil
     and npc_bot:GetLevel() < condition.level
     and DotaTime() < (condition.time * 60) then

    return
  end

  functions.SetItemToSell(npc_bot, item)
end

local function GetSlotIndex(inventory_index)
  return inventory_index - 1
end

local function SellExtraItem(npc_bot)
  if functions.GetItemToSell(npc_bot) ~= nil then return end

  if not functions.IsInventoryFull(npc_bot) then return end

  local inventory = functions.GetInventoryItems(npc_bot)

  for item, condition in functions.spairs(item_sell.ITEM_SELL) do

    local index = functions.GetElementIndexInList(inventory, item)

    if index ~= -1 then

      SellItemByIndex(
        npc_bot,
        GetSlotIndex(index),
        condition)
      return
    end
  end
end

local function PurchaseViaCourier(bot)
  local courier = GetCourier(0)

  if courier == nil
     or constants.SHOP_USE_RADIUS < courier:DistanceFromSecretShop() then

     return PURCHASE_ITEM_DISALLOWED_ITEM
   end

  local buy_item = functions.GetItemToBuy(bot)

  if buy_item ~= nil then
    if PURCHASE_ITEM_SUCCESS ==
      courier:ActionImmediate_PurchaseItem(buy_item) then

      logger.Print("PurchaseItemList() - " .. bot:GetUnitName() ..
                   " bought " .. buy_item .. " via courier")

      functions.SetItemToBuy(bot, nil)

      return PURCHASE_ITEM_SUCCESS
    end
  end

  return PURCHASE_ITEM_DISALLOWED_ITEM
end

local function PerformPlannedPurchaseAndSell(bot)
  if PURCHASE_ITEM_SUCCESS == PurchaseViaCourier(bot) then return end

  if constants.BASE_SHOP_USE_RADIUS < bot:DistanceFromFountain()
    and constants.SHOP_USE_RADIUS < bot:DistanceFromSideShop()
    and constants.SHOP_USE_RADIUS < bot:DistanceFromSecretShop() then

    return
  end

  local sell_item = functions.GetItemToSell(bot)

  if sell_item ~= nil then

    logger.Print("SellItemByIndex() - " .. bot:GetUnitName() ..
                 " sell " .. sell_item:GetName())

    bot:ActionImmediate_SellItem(sell_item)
    functions.SetItemToSell(bot, nil)
  end

  if functions.IsInventoryFull(bot) then return end

  local buy_item = functions.GetItemToBuy(bot)

  if buy_item ~= nil then
    if PURCHASE_ITEM_SUCCESS ==
      bot:ActionImmediate_PurchaseItem(buy_item) then

      logger.Print("PurchaseItemList() - " .. bot:GetUnitName() ..
                   " bought " .. buy_item)

      functions.SetItemToBuy(bot, nil)
    end
  end
end

local function CancelPlannedPurchase(bot)
  local buy_item = functions.GetItemToBuy(bot)

  if buy_item == nil then return end

  if bot:GetGold() < GetItemCost(buy_item) then

    logger.Print("CancelPlannedPurchase() - " .. bot:GetUnitName() ..
                 " cancel " .. buy_item)

    functions.SetItemToBuy(bot, nil)

    -- We should return the cancelled item to the buy list.
    local item_list = item_build.ITEM_BUILD[bot:GetUnitName()].items
    item_list[1] = buy_item
  end
end

function M.ItemPurchaseThink()
  local bot = GetBot()

  -- This action is required if a bot was killed and lose money
  -- before he buy the planned item
  CancelPlannedPurchase(bot)

  PerformPlannedPurchaseAndSell(bot)

  PurchaseCourier(bot)

  PurchaseTpScroll(bot)

  SellExtraItem(bot)

  PurchaseItemList(bot)
end

-- Provide an access to local functions for unit tests only
M.test_IsTpScrollPresent = IsTpScrollPresent
M.test_PurchaseCourier = PurchaseCourier
M.test_PurchaseTpScroll = PurchaseTpScroll
M.test_IsRecipeItem = IsRecipeItem
M.test_IsItemAlreadyBought = IsItemAlreadyBought
M.test_GetInventoryAndStashItems = GetInventoryAndStashItems
M.test_FindNextComponentToBuy = FindNextComponentToBuy
M.test_PurchaseItem = PurchaseItem
M.test_FindNextItemToBuy = FindNextItemToBuy
M.test_PurchaseItemList = PurchaseItemList
M.test_SellItemByIndex = SellItemByIndex
M.test_SellExtraItem = SellExtraItem
M.test_PurchaseViaCourier = PurchaseViaCourier
M.test_PerformPlannedPurchaseAndSell = PerformPlannedPurchaseAndSell
M.test_CancelPlannedPurchase = CancelPlannedPurchase


return M
