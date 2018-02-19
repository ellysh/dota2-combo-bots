local logger = require(
  GetScriptDirectory() .."/utility/logger")

local item_sell = require(
  GetScriptDirectory() .."/database/item_sell")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local memory = require(
  GetScriptDirectory() .."/utility/memory")

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

local function PurchaseTpScroll(bot)
  if IsTpScrollPresent(bot)
     or memory.GetItemToBuy(bot) == "item_tpscroll" then
    return end

  memory.AddItemToBuy(bot, "item_tpscroll")
end

local function SellItemByIndex(bot, index, condition)
  local item = bot:GetItemInSlot(index);

  -- We should sell an item despite the condition if we want to buy
  -- item and an inventory is full.

  if memory.GetItemToBuy(bot) == nil
     and bot:GetLevel() < condition.level
     and DotaTime() < (condition.time * 60) then

    return
  end

  memory.SetItemToSell(bot, item:GetName())
end

local function GetSlotIndex(inventory_index)
  return inventory_index - 1
end

local function SetItemToSell(bot)
  if memory.GetItemToSell(bot) ~= nil then
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

local function IsUnitNearSecretSideShop(unit)
  return unit:DistanceFromSecretShop() <= constants.SHOP_USE_RADIUS
         or unit:DistanceFromSideShop() <= constants.SHOP_USE_RADIUS
end

local function IsUnitNearBaseShop(unit)
  return unit:DistanceFromFountain() <= constants.BASE_SHOP_USE_RADIUS
end

local function PurchaseViaCourier(bot)
  local courier = GetCourier(0)
  local buy_item = memory.GetItemToBuy(bot)
  local is_item_from_secret_shop = IsItemPurchasedFromSecretShop(buy_item)

  if buy_item == nil
     or courier == nil
     or functions.IsInventoryFull(courier)
     or (is_item_from_secret_shop
        and not IsUnitNearSecretSideShop(courier))
     or (not is_item_from_secret_shop
         and not IsUnitNearBaseShop(courier)) then

    return PURCHASE_ITEM_DISALLOWED_ITEM
  end

  local result = courier:ActionImmediate_PurchaseItem(buy_item)

  if PURCHASE_ITEM_SUCCESS == result then

    logger.Print("PurchaseViaCourier() - " .. bot:GetUnitName() ..
                 " bought " .. buy_item .. " via courier")

    memory.RemoveItemToBuyIndex(bot)
  end

  return result
end

local function HasEmptySlotToBuy(bot)
  if not IsUnitNearBaseShop(bot)
     and not IsUnitNearSecretSideShop(bot) then

    return not functions.IsStashFull(bot)

  elseif IsUnitNearSecretSideShop(bot) then

    return not functions.IsInventoryFull(bot)

  elseif IsUnitNearBaseShop(bot) then

    return not functions.IsInventoryFull(bot)
           or not functions.IsStashFull(bot)
  end

  return false
end

local function PerformSell(bot)
  if not IsUnitNearBaseShop(bot)
     and not IsUnitNearSecretSideShop(bot) then
    return end

  local sell_item = memory.GetItemToSell(bot)

  if sell_item == nil then
    return end

  local item_handle = functions.GetItem(bot, sell_item)

  if item_handle == nil then
    return end

  logger.Print("PerformSell() - " ..
    bot:GetUnitName() .. " sell " .. sell_item)

  bot:ActionImmediate_SellItem(item_handle)

  memory.SetItemToSell(bot, nil)
end

local function PerformPurchase(bot)
  if not IsUnitNearBaseShop(bot)
     and not IsUnitNearSecretSideShop(bot) then

    PurchaseViaCourier(bot)

    -- We return here because otherwise all purchases will be done via stash
    -- and courier. But bots should walk to the side and secret shops instead.
    return
  end

  local buy_item = memory.GetItemToBuy(bot)

  if buy_item == nil
     or bot:GetGold() < GetItemCost(buy_item)
     or not HasEmptySlotToBuy(bot) then
        return end

  if PURCHASE_ITEM_SUCCESS ==
    bot:ActionImmediate_PurchaseItem(buy_item) then

    logger.Print("PerformPlannedPurchaseAndSell() - " ..
      bot:GetUnitName() .. " bought " .. buy_item)

    memory.RemoveItemToBuyIndex(bot)
  end
end

function M.ItemPurchaseThink()
  local bot = GetBot()

  memory.MakePurchaseList(bot)

  PerformSell(bot)

  PerformPurchase(bot)

  PurchaseCourier(bot)

  PurchaseTpScroll(bot)

  SetItemToSell(bot)
end

-- Provide an access to local functions for unit tests only
M.test_IsTpScrollPresent = IsTpScrollPresent
M.test_PurchaseCourier = PurchaseCourier
M.test_PurchaseTpScroll = PurchaseTpScroll
M.test_SellItemByIndex = SellItemByIndex
M.test_SetItemToSell = SetItemToSell
M.test_PurchaseViaCourier = PurchaseViaCourier
M.test_PerformPurchase = PerformPurchase
M.test_PerformSell = PerformSell

return M
