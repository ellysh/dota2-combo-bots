local logger = require(
  GetScriptDirectory() .."/utility/logger")

-- TODO: Remove the "item_recipe" require
local item_recipe = require(
  GetScriptDirectory() .."/database/item_recipe")

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

local function SellExtraItem(bot)
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

local function PurchaseViaCourier(bot)
  local courier = GetCourier(0)
  local buy_item = memory.GetItemToBuy(bot)
  local is_item_from_secret_shop = IsItemPurchasedFromSecretShop(buy_item)

  if courier == nil
     or (is_item_from_secret_shop
         and constants.SHOP_USE_RADIUS < courier:DistanceFromSecretShop())
     or (not is_item_from_secret_shop
         and constants.BASE_SHOP_USE_RADIUS
             < courier:DistanceFromFountain()) then

     return PURCHASE_ITEM_DISALLOWED_ITEM
   end

  if buy_item ~= nil then
    if PURCHASE_ITEM_SUCCESS ==
      courier:ActionImmediate_PurchaseItem(buy_item) then

      logger.Print("PurchaseViaCourier() - " .. bot:GetUnitName() ..
                   " bought " .. buy_item .. " via courier")

      memory.SetItemToBuy(bot, nil)

      return PURCHASE_ITEM_SUCCESS
    end
  end

  return PURCHASE_ITEM_DISALLOWED_ITEM
end

local function PerformPlannedPurchaseAndSell(bot)
  if constants.BASE_SHOP_USE_RADIUS < bot:DistanceFromFountain()
    and constants.SHOP_USE_RADIUS < bot:DistanceFromSideShop()
    and constants.SHOP_USE_RADIUS < bot:DistanceFromSecretShop() then

    PurchaseViaCourier(bot)
    return
  end

  local sell_item = memory.GetItemToSell(bot)

  if sell_item ~= nil then

    logger.Print("PerformPlannedPurchaseAndSell() - " ..
      bot:GetUnitName() .. " sell " .. sell_item)

    local item_handle = functions.GetItem(bot, sell_item)

    if item_handle ~= nil then
      bot:ActionImmediate_SellItem(item_handle)
    end

    memory.SetItemToSell(bot, nil)
  end

  local buy_item = memory.GetItemToBuy(bot)

  if functions.IsInventoryFull(bot)
     or bot:GetGold() < GetItemCost(buy_item) then
     return end

  if buy_item ~= nil then
    if PURCHASE_ITEM_SUCCESS ==
      bot:ActionImmediate_PurchaseItem(buy_item) then

      logger.Print("PerformPlannedPurchaseAndSell() - " ..
        bot:GetUnitName() .. " bought " .. buy_item)

      memory.IncreaseItemToBuyIndex(bot)
    end
  end
end

memory.MakePurchaseList(GetBot())

function M.ItemPurchaseThink()
  local bot = GetBot()

  PerformPlannedPurchaseAndSell(bot)

  PurchaseCourier(bot)

  PurchaseTpScroll(bot)

  SellExtraItem(bot)
end

-- Provide an access to local functions for unit tests only
M.test_IsTpScrollPresent = IsTpScrollPresent
M.test_PurchaseCourier = PurchaseCourier
M.test_PurchaseTpScroll = PurchaseTpScroll
M.test_SellItemByIndex = SellItemByIndex
M.test_SellExtraItem = SellExtraItem
M.test_PurchaseViaCourier = PurchaseViaCourier
M.test_PerformPlannedPurchaseAndSell = PerformPlannedPurchaseAndSell

return M
