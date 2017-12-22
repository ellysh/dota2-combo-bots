local logger = require(
  GetScriptDirectory() .."/utility/logger")

local item_recipe = require(
  GetScriptDirectory() .."/database/item_recipe")

local item_build = require(
  GetScriptDirectory() .."/database/item_build")

local M = {}

local function IsTpScrollPresent(npc_bot)
  local tp_scroll = npc_bot:FindItemSlot("item_tpscroll")

  return tp_scroll ~= -1
end

local function PurchaseCourier(npc_bot)
  if GetNumCouriers() > 0 then return end

  local players = GetTeamPlayers(GetTeam())

  -- Buy courier only by player of 5th position
  if players[5] == npc_bot:GetPlayerID() then

    logger.Print("PurchaseCourier() - " .. npc_bot:GetUnitName() .. " bought Courier")

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

local function IsItemAlreadyBought(npc_bot, item)
  if npc_bot:GetCourierValue() > 0 then
    -- TODO: Team can have more then one curier
    if GetCourier(0):FindItemSlot(item) ~= -1 then
      return true
    end
  end

  return npc_bot:FindItemSlot(item) ~= -1
end

local function FindNextComponentToBuy(npc_bot, item)
  local component_list = item_recipe.ITEM_RECIPE[item].components

  for _, component in pairs(component_list) do
    if component ~= "nil" and not IsItemAlreadyBought(npc_bot, component) then
      return component
    end
  end

  return "nil"
end

local function PurchaseItem(npc_bot, item)
  if IsRecipeItem(item) then
    item = FindNextComponentToBuy(item)
  end

  if item ~= "nil" and (npc_bot:GetGold() >= GetItemCost(item)) then

    logger.Print("PurchaseItem() - " .. npc_bot:GetUnitName() .. " bought " .. item)

    npc_bot:ActionImmediate_PurchaseItem(item)
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

local function PurchaseItemList(npc_bot, item_type)
  local item_list = item_build.ITEM_BUILD[npc_bot:GetUnitName()].items

  local i, item = FindNextItemToBuy(item_list)

  if PurchaseItem(npc_bot, item) and IsItemAlreadyBought(npc_bot, item) then
    -- Mark the item as bought
    item_list[i] = "nil"
  end
end

function M.PurchaseItem()
  local npc_bot = GetBot()

  PurchaseCourier(npc_bot)

  PurchaseTpScroll(npc_bot)

  PurchaseItemList(npc_bot)
end

-- Provide an access to local functions for unit tests only
M.test_IsTpScrollPresent = IsTpScrollPresent
M.test_PurchaseCourier = PurchaseCourier
M.test_PurchaseTpScroll = PurchaseTpScroll
M.test_PurchaseItem = PurchaseItem
M.test_FindNextItemToBuy = FindNextItemToBuy
M.test_PurchaseItemList = PurchaseItemList

return M
