local logger = require(
    GetScriptDirectory() .."/utility/logger")

local heroes = require(
    GetScriptDirectory() .."/database/item_recipe")

local heroes = require(
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

function M.PurchaseItem()
  local npcBot = GetBot()

  PurchaseCourier(npcBot)

  PurchaseTpScroll(npcBot)
--[[
  if (#itemsToBuy == 0) then
    return
  end

  local nextItem = itemsToBuy[1]

  if (npcBot:GetGold() >= GetItemCost(nextItem)) then
    logger.Print("M.PurchaseItem() - " .. npcBot:GetUnitName() .. " bought " .. nextItem)
    npcBot:ActionImmediate_PurchaseItem(nextItem)
    table.remove(itemsToBuy, 1)
  end
--]]
end

return M
