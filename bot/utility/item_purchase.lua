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
  if functions.GetElementInList(players, 5) == npc_bot:GetPlayerID() then

    logger.Print("PurchaseCourier() - " .. npc_bot:GetUnitName() .. " bought courier")

    npc_bot:ActionImmediate_PurchaseItem("item_courier")
  end
end

local function PurchaseTpScroll(npc_bot)
  if IsTpScrollPresent(npc_bot) then return end

  if (npc_bot:GetGold() >= GetItemCost("item_tpscroll")) then

    logger.Print("PurchaseTpScroll() - " .. npc_bot:GetUnitName() .. " bought TpScroll")

    npc_bot:ActionImmediate_PurchaseItem("item_tpscroll")
  end
end

local function IsRecipeItem(item)
  return item_recipe.ITEM_RECIPE[item] ~= nil
end

local function IsItemAlreadyBought(inventory, item)
  local index = functions.GetElementIndexInList(inventory, item)

  if index ~= -1 then
    -- This is safe because we have used GetElementIndexInList
    inventory[index] = "nil"
    return true
  end
  return false
end

local function GetInventoryAndStashItems(npc_bot)
  local _, result = functions.GetItems(
    npc_bot,
    constants.INVENTORY_AND_STASH_SIZE)

  return result
end

local function GetInventoryItems(npc_bot)
  local _, result = functions.GetItems(
    npc_bot,
    constants.INVENTORY_SIZE)

  return result
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

local function OrderSecretShopItem(npc_bot, item, purchase_result)
  if not IsItemPurchasedFromSecretShop(item)
     or purchase_result ~= PURCHASE_ITEM_NOT_AT_SECRET_SHOP then

    return false
  end

  local courier = GetCourier(0)

  if courier ~= nil
     and courier:DistanceFromSecretShop() <= constants.SHOP_USE_RADIUS then
    npc_bot.is_secret_shop_mode = false

    return courier:ActionImmediate_PurchaseItem(item)
            == PURCHASE_ITEM_SUCCESS
  end

  npc_bot.is_secret_shop_mode = true

  return false
end

local function OrderSideShopItem(npc_bot, item)
  if not IsItemPurchasedFromSideShop(item) then return false end

  if npc_bot.is_side_shop_mode
     and npc_bot:GetActiveMode() ~= BOT_MODE_SIDE_SHOP then
    return false
  end

  if npc_bot:DistanceFromSideShop() <= constants.SHOP_WALK_RADIUS then

    npc_bot.is_side_shop_mode = true
    return true
  end

  return false
end

local function PurchaseItem(npc_bot, item)
  if IsRecipeItem(item) then
    item = FindNextComponentToBuy(npc_bot, item)
  end

  if item == "nil" or (npc_bot:GetGold() < GetItemCost(item)) then
    return false
  end

  -- We should try to buy an item in the side shop first. Otherwise,
  -- it will be bought in the base shop.
  if OrderSideShopItem(npc_bot, item) then
    return false
  end

  local purchase_result = npc_bot:ActionImmediate_PurchaseItem(item)

  if purchase_result == PURCHASE_ITEM_SUCCESS then
    npc_bot.is_side_shop_mode = false
    npc_bot.is_secret_shop_mode = false
    return true
  end

  return OrderSecretShopItem(npc_bot, item, purchase_result)

end

local function FindNextItemToBuy(item_list)
  for i, item in functions.spairs(item_list) do
    if item ~= "nil" then return i, item end
  end

  return "nil"
end

local function PurchaseItemList(npc_bot, item_type)
  local item_list = item_build.ITEM_BUILD[npc_bot:GetUnitName()].items

  local i, item = FindNextItemToBuy(item_list)

  if IsItemAlreadyBought(GetInventoryAndStashItems(npc_bot), item) then
    -- Mark the item as bought. This is safe because of the "spairs"
    -- usage in the FindNextItemToBuy.
    item_list[i] = "nil"
    return
  end

  if PurchaseItem(npc_bot, item) then

    logger.Print("PurchaseItemList() - " .. npc_bot:GetUnitName() ..
                 " bought " .. item)
  end
end

local function SellItemByIndex(npc_bot, index, condition)
  local item = npc_bot:GetItemInSlot(index);

  if npc_bot:GetLevel() < condition.level
    and GameTime() < (condition.time * 60) then

    return
  end

  if npc_bot:DistanceFromFountain() <= constants.BASE_SHOP_USE_RADIUS
    or npc_bot:DistanceFromSideShop() <= constants.SHOP_USE_RADIUS
    or npc_bot:DistanceFromSecretShop() <= constants.SHOP_USE_RADIUS then

    logger.Print("SellItemByIndex() - " .. npc_bot:GetUnitName() ..
                 " sell " .. item:GetName())

    npc_bot:ActionImmediate_SellItem(item)
  end
end

local function GetSlotIndex(inventory_index)
  return inventory_index - 1
end

local function SellExtraItem(npc_bot)
  if not functions.IsItemSlotsFull(npc_bot) then return end

  local inventory = GetInventoryItems(npc_bot)

  for item, condition in pairs(item_sell.ITEM_SELL) do

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

function M.ItemPurchaseThink()
  local npc_bot = GetBot()

  PurchaseCourier(npc_bot)

  PurchaseTpScroll(npc_bot)

  SellExtraItem(npc_bot)

  PurchaseItemList(npc_bot)
end

-- Provide an access to local functions for unit tests only
M.test_IsTpScrollPresent = IsTpScrollPresent
M.test_PurchaseCourier = PurchaseCourier
M.test_PurchaseTpScroll = PurchaseTpScroll
M.test_IsRecipeItem = IsRecipeItem
M.test_IsItemAlreadyBought = IsItemAlreadyBought
M.test_GetInventoryAndStashItems = GetInventoryAndStashItems
M.test_GetInventoryItems = GetInventoryItems
M.test_FindNextComponentToBuy = FindNextComponentToBuy
M.test_OrderSecretShopItem = OrderSecretShopItem
M.test_OrderSideShopItem = OrderSideShopItem
M.test_PurchaseItem = PurchaseItem
M.test_FindNextItemToBuy = FindNextItemToBuy
M.test_PurchaseItemList = PurchaseItemList
M.test_SellItemByIndex = SellItemByIndex
M.test_SellExtraItem = SellExtraItem

return M
