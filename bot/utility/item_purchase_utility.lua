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

local function IsGameBeginning()
  return DotaTime() < 0
end

local function IsInventoryEmpty(npcBot)
  for i = 0, 16, 1 do
    local item = npcBot:GetItemInSlot(i)
    if item ~= nill and item:GetName() ~= "item_tpscroll" then
      return false
    end
  end

  return true
end

local function PurchaseStartingItem(npcBot)
  if not IsGameBeginning or not IsInventoryEmpty(npcBot) then return end

  local starting_items = item_build.ITEM_BUILD[npcBot:GetUnitName()].starting_items

  for _, item in pairs(starting_items) do
    if item ~= "nil" and (npcBot:GetGold() >= GetItemCost(item)) then

      logger.Print("PurchaseItem() - " .. npcBot:GetUnitName() .. " bought " .. item)

      npcBot:ActionImmediate_PurchaseItem(item)
    end
  end
end

function M.PurchaseItem()
  local npcBot = GetBot()

  PurchaseCourier(npcBot)

  PurchaseTpScroll(npcBot)

  PurchaseStartingItem(npcBot)
end

return M
