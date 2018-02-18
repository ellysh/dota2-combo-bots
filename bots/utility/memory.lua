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
--     ITEM_TO_BUY = "item_name",
--     ITEM_TO_SELL = item_handle,
--     ITEM_BUILD = { "item_name", "item_name", ...}
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
  end
end

function M.GetItemToSell(bot)
  return PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_SELL
end

function M.GetItemToBuy(bot)
  return PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_BUY
end

function M.SetItemToSell(bot, item)
  PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_SELL = item
end

function M.SetItemToBuy(bot, item)
  PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_BUY = item
end

function M.GetItemBuild(bot)
  return PURCHASE_LIST[bot:GetUnitName()].ITEM_BUILD
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

return M
