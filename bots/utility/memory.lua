local item_builds = require(
  GetScriptDirectory() .."/database/item_builds")

local item_sets = require(
  GetScriptDirectory() .."/database/item_sets")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

-- Format of the PURCHASE_LIST list:
-- {
--   hero_name = {
--     ITEM_BUILD = { "item_name", "item_name", ...}
--     ITEM_TO_SELL = item_handle,
--   },
-- ...
-- }

PURCHASE_LIST = {}

local function IsInitPurchaseList(bot)
  return PURCHASE_LIST ~= nil and PURCHASE_LIST[bot:GetUnitName()] ~= nil
end

local function InitPurchaseList(bot)
  PURCHASE_LIST[bot:GetUnitName()] = {}
  PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD = {}
end

function M.SetItemToSell(bot, item)
  PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_SELL = item
end

function M.GetItemToSell(bot)
  return PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_SELL
end

function M.AddItemToBuy(bot, item)
  table.insert(PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD, 1, item)
end

function M.RemoveItemToBuyIndex(bot)
  local item_build = PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD

  if #item_build == 0 then
    return end

  table.remove(PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD, 1)
end

function M.GetItemToBuy(bot)
  -- The CourierUsageThink function is call for all allies units.
  -- Therefore, the IsSecretShopRequired happens for non heroes.

  if PURCHASE_LIST[bot:GetUnitName()] == nil then
    return nil end

  local item_build = PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD

  if #item_build == 0 then
    return nil end

  return item_build[1]
end

local function IsRecipeItem(item)
  return item_sets.ITEM_SETS[item] ~= nil
end

local function AddItemToList(list, item)
  if item == "nil" then
    return end

  if not IsRecipeItem(item) then
    table.insert(list, item)
    return
  end

  local component_list = item_sets.ITEM_SETS[item].components

  for _, component in functions.spairs(component_list) do
    AddItemToList(list, component)
  end
end

function M.MakePurchaseList(bot)
  if IsInitPurchaseList(bot) then
    return end

  InitPurchaseList(bot)

  local item_list = item_builds.ITEM_BUILDS[bot:GetUnitName()].items

  for _, item in functions.spairs(item_list) do
    AddItemToList(PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD, item)
  end
end

-- Format of the NEUTRAL_CAMP_LIST list:
-- {
--   camp_type = {
--     is_empty = true/false
--     locaion = Vector(x, y, z)
--   },
-- ...
-- }

NEUTRAL_CAMP_LIST = {}

local function IsInitNeutralCampList()
  return NEUTRAL_CAMP_LIST == nil or #NEUTRAL_CAMP_LIST == 0
end

function M.InitNeutralCampList()
  if IsInitNeutralCampList() then
    return end

  local camps = GetNeutralSpawners()

  functions.DoWithElements(
    camps,
    function(camp)
      NEUTRAL_CAMP_LIST[camp.type] = {
        is_full = true,
        locaion = camp.locaion}
    end)
end

-- Provide an access to local functions for unit tests only
M.test_InitPurchaseList = InitPurchaseList
M.test_IsRecipeItem = IsRecipeItem

return M
