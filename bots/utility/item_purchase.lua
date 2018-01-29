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

local function IsTpScrollPresent(bot)
  local tp_scroll = bot:FindItemSlot("item_tpscroll")

  return tp_scroll ~= -1
end

local function PurchaseCourier(bot)
  if GetNumCouriers() > 0 then
    return end

  local players = GetTeamPlayers(GetTeam())

  -- Buy courier only by a player of 5th position
  if players[5] == bot:GetPlayerID() then

    logger.Print("PurchaseCourier() - " .. bot:GetUnitName() .. " bought courier")

    bot:ActionImmediate_PurchaseItem("item_courier")
  end
end

local function IsRecipeItem(item)
  return item_recipe.ITEM_RECIPE[item] ~= nil
end

local function GetInventoryAndStashItems(bot)
  local _, result = functions.GetItems(
    bot,
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

local function FindNextComponentToBuy(bot, item)
  local component_list = item_recipe.ITEM_RECIPE[item].components

  local inventory = GetInventoryAndStashItems(bot)

  for _, component in functions.spairs(component_list) do
    if component ~= "nil"
      and not IsItemAlreadyBought(inventory, component) then

      if IsRecipeItem(component) then
        return FindNextComponentToBuy(bot, component)
      else
        return component
      end
    end
  end

  return "nil"
end

local function FindNextItemToBuy(item_list)
  for i, item in functions.spairs(item_list) do
    if item ~= "nil" then
      return i, item end
  end

  return -1, "nil"
end

local function IsPurchasePossible(bot)

  -- Do not add anything to the purchase slot until courier bring
  -- something or the stash is not empty. Otherwise, we are not sure
  -- that upgradable items are assembled.

  return bot:GetCourierValue() == 0
         and bot:GetStashValue() == 0
         and functions.GetItemToBuy(bot) == nil
end

local function PurchaseItem(bot, item)
  if not IsPurchasePossible(bot) then
    return end

  if IsRecipeItem(item) then
    item = FindNextComponentToBuy(bot, item)
  end

  if item == "nil" then
    return end

  functions.SetItemToBuy(bot, item)
end

local function PurchaseTpScroll(bot)
  if IsTpScrollPresent(bot) then
    return end

  PurchaseItem(bot, "item_tpscroll")
end

local function PurchaseItemList(bot)
  -- We do this check here because the long algorithm of finding an
  -- item to buy is not make sense if the purchase is not possible.
  if not IsPurchasePossible(bot) then
    return end

  local item_list = item_build.ITEM_BUILD[bot:GetUnitName()].items

  local i, item = FindNextItemToBuy(item_list)

  if i ~= -1
    and item ~= "nil"
    and functions.IsElementInList(
      GetInventoryAndStashItems(
        bot),
        item) then

    item_list[i] = "nil"
    return
  end

  PurchaseItem(bot, item)
end

local function SellItemByIndex(bot, index, condition)
  local item = bot:GetItemInSlot(index);

  -- We should sell an item despite the condition if we want to buy
  -- item and an inventory is full.

  if functions.GetItemToBuy(bot) == nil
     and bot:GetLevel() < condition.level
     and DotaTime() < (condition.time * 60) then

    return
  end

  functions.SetItemToSell(bot, item:GetName())
end

local function GetSlotIndex(inventory_index)
  return inventory_index - 1
end

local function SellExtraItem(bot)
  if functions.GetItemToSell(bot) ~= nil then
    return end

  if not functions.IsInventoryFull(bot) then
    return end

  local inventory = functions.GetInventoryItems(bot)

  for item, condition in functions.spairs(item_sell.ITEM_SELL) do

    local index = functions.GetElementIndexInList(inventory, item)

    if index ~= -1 then

      SellItemByIndex(
        bot,
        GetSlotIndex(index),
        condition)
      return
    end
  end
end

local function PurchaseViaCourier(bot)
  local courier = GetCourier(0)
  local buy_item = functions.GetItemToBuy(bot)

  if courier == nil
     or (IsItemPurchasedFromSecretShop(buy_item)
         and constants.SHOP_USE_RADIUS < courier:DistanceFromSecretShop())
     or constants.SHOP_USE_RADIUS < courier:DistanceFromFountain() then

     return PURCHASE_ITEM_DISALLOWED_ITEM
   end

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
  if PURCHASE_ITEM_SUCCESS == PurchaseViaCourier(bot) then
    return end

  if constants.BASE_SHOP_USE_RADIUS < bot:DistanceFromFountain()
    and constants.SHOP_USE_RADIUS < bot:DistanceFromSideShop()
    and constants.SHOP_USE_RADIUS < bot:DistanceFromSecretShop() then

    return
  end

  local sell_item = functions.GetItemToSell(bot)

  if sell_item ~= nil then

    logger.Print("SellItemByIndex() - " .. bot:GetUnitName() ..
                 " sell " .. sell_item)

    local item_handle = bot:GetItemInSlot(bot:FindItemSlot(sell_item))

    if item_handle ~= nil then
      bot:ActionImmediate_SellItem(item_handle)
    end

    functions.SetItemToSell(bot, nil)
  end

  local buy_item = functions.GetItemToBuy(bot)

  if functions.IsInventoryFull(bot)
     or bot:GetGold() < GetItemCost(buy_item) then
     return end

  if buy_item ~= nil then
    if PURCHASE_ITEM_SUCCESS ==
      bot:ActionImmediate_PurchaseItem(buy_item) then

      logger.Print("PurchaseItemList() - " .. bot:GetUnitName() ..
                   " bought " .. buy_item)

      functions.SetItemToBuy(bot, nil)
    end
  end
end

function M.ItemPurchaseThink()
  local bot = GetBot()

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

return M
