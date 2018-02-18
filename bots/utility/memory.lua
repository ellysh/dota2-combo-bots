local item_build = require(
  GetScriptDirectory() .."/database/item_build")

local item_recipe = require(
  GetScriptDirectory() .."/database/item_recipe")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

-- Format of the PURCHASE_LIST list:
-- {
--   hero_name = {
--     ITEM_BUILD = { "item_name", "item_name", ...}
--     ITEM_BUILD_INDEX = 1
--     ITEM_TO_SELL = item_handle,
--   },
-- ...
-- }

PURCHASE_LIST = {}

local function IsInitPurchaseList(bot)
  return PURCHASE_LIST ~= nil and PURCHASE_LIST[bot:GetUnitName()] ~= nil
end

local function InitPurchaseList(bot)
  if not IsInitPurchaseList(bot) then
    PURCHASE_LIST[bot:GetUnitName()] = {}
    PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD = {}
    PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD_INDEX = 1
  end
end

function M.SetItemToSell(bot, item)
  PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_SELL = item
end

function M.GetItemToSell(bot)
  return PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_SELL
end

function M.GetItemToBuy(bot)
  local index = PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD_INDEX

  return PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD[index]
end

function M.AddItemToBuy(bot, item)
  local index = PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD_INDEX

  table.insert(PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD, index, item)
end

function M.IncreaseItemToBuyIndex(bot)
  PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD_INDEX =
    PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD_INDEX + 1
end

local function IsRecipeItem(item)
  return item_recipe.ITEM_RECIPE[item] ~= nil
end

local function AddItemToList(list, item)
  if not IsRecipeItem(item) then
    table.insert(list, item)
    return
  end

  local component_list = item_recipe.ITEM_RECIPE[item].components

  for _, component in functions.spairs(component_list) do
    AddItemToList(list, component)
  end
end

function M.MakePurchaseList(bot)
  InitPurchaseList(bot)

  local item_list = item_build.ITEM_BUILD[bot:GetUnitName()].items

  for _, item in functions.spairs(item_list) do
    AddItemToList(PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD, item)
  end
end

-- Provide an access to local functions for unit tests only
M.test_InitPurchaseList = InitPurchaseList
M.test_IsRecipeItem = IsRecipeItem

return M
