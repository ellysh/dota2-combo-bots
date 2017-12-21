local logger = require(
    GetScriptDirectory() .."/utility/logger")

local item_recipe = require(
    GetScriptDirectory() .."/database/item_recipe")

local item_build = require(
    GetScriptDirectory() .."/database/item_build")

local M = {}

local function IsTpScrollPresent(npcBot)
  local tpScroll = npcBot:FindItemSlot("item_tpscroll")

  return tpScroll ~= -1
end

local function PurchaseCourier(npcBot)
  if GetNumCouriers() > 0 then return end

  local players = GetTeamPlayers(GetTeam())

  -- Buy courier only by player of 5th position
  if players[5] == npcBot:GetPlayerID() then

    logger.Print("PurchaseCourier() - " .. npcBot:GetUnitName() .. " bought Courier")

    npcBot:ActionImmediate_PurchaseItem("item_courier")
  end
end

local function PurchaseTpScroll(npcBot)
  if IsTpScrollPresent(npcBot) then return end

  if (npcBot:GetGold() >= GetItemCost("item_tpscroll")) then

    logger.Print("PurchaseTpScroll() - " .. npcBot:GetUnitName() .. " bought TpScroll")

    npcBot:ActionImmediate_PurchaseItem("item_tpscroll")
  end
end

local function PurchaseItem(npcBot, item)
  -- TODO: Process compound items correctly there.
  if item ~= "nil" and (npcBot:GetGold() >= GetItemCost(item)) then

    logger.Print("PurchaseItem() - " .. npcBot:GetUnitName() .. " bought " .. item)

    npcBot:ActionImmediate_PurchaseItem(item)
    return true
  end

  return false
end

local function FindNextItemToBuy(item_list)
  for i, item in pairs(item_list) do
    if item ~= "nil" then return i, item end
  end

  return "nil"
end

local function PurchaseItemList(npcBot, item_type)
  local item_list = item_build.ITEM_BUILD[npcBot:GetUnitName()].items

  local i, item = FindNextItemToBuy(item_list)

  if PurchaseItem(npcBot, item) then
    -- Mark the item as bought
    item_list[i] = "nil"
  end
end

function M.PurchaseItem()
  local npcBot = GetBot()

  PurchaseCourier(npcBot)

  PurchaseTpScroll(npcBot)

  PurchaseItemList(npcBot)
end

-- Provide an access to locac functions for unit tests only
M.test_IsTpScrollPresent = IsTpScrollPresent
M.test_PurchaseCourier = PurchaseCourier
M.test_PurchaseTpScroll = PurchaseTpScroll
M.test_PurchaseItem = PurchaseItem
M.test_FindNextItemToBuy = FindNextItemToBuy
M.test_PurchaseItemList = PurchaseItemList

return M
