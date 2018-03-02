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

function M.InitPurchaseList(bot)
  if IsInitPurchaseList(bot) then
    return end

  local bot_name = bot:GetUnitName()

  PURCHASE_LIST[bot_name] = {}
  PURCHASE_LIST[bot_name].ITEM_BUILD = {}

  local item_list = item_builds.ITEM_BUILDS[bot_name].items

  for _, item in functions.spairs(item_list) do
    AddItemToList(PURCHASE_LIST[bot_name].ITEM_BUILD, item)
  end
end

-- Format of the NEUTRAL_CAMP_LIST list:
-- {
--   camp_type = {
--     is_full = true/false
--     location = Vector(x, y, z)
--   },
-- ...
-- }

NEUTRAL_CAMP_LIST = {}

local function IsInitNeutralCampList()
  return NEUTRAL_CAMP_LIST ~= nil and 0 < #NEUTRAL_CAMP_LIST
end

function M.InitNeutralCampList()
  if IsInitNeutralCampList() then
    return end

  local camps = GetNeutralSpawners()

  functions.DoWithElements(
    camps,
    function(camp)
      table.insert(
        NEUTRAL_CAMP_LIST,
        {
          type = camp.type,
          is_full = true,
          location = camp.location
        })
    end)
end

local function NeutralCampSpawn()
  if (DotaTime() % (1 * 60)) ~= 0 then
    return end

  functions.DoWithElements(
    NEUTRAL_CAMP_LIST,
    function(camp)
      camp.is_full = true
    end)
end

function M.Remember()
  M.InitNeutralCampList()

  NeutralCampSpawn()
end

function M.GetNeutralCampList()
  return NEUTRAL_CAMP_LIST
end

function M.SetNeutralCampEmpty(location)
  local key = functions.GetKeyWith(
    NEUTRAL_CAMP_LIST,
    nil,
    function(key, camp)
      return camp.location == location
    end)

  if key == nil then
    return end

  NEUTRAL_CAMP_LIST[key].is_full = false
end

-- Provide an access to local functions for unit tests only
M.test_IsRecipeItem = IsRecipeItem
M.test_NeutralCampSpawn = NeutralCampSpawn

return M
