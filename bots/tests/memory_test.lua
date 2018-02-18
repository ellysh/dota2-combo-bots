package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local luaunit = require("luaunit")
local memory = require("memory")
local constants = require("constants")

function test_SetItemToSell_first_time_succeed()
  test_RefreshBot()

  local bot = GetBot()

  PURCHASE_LIST = {}
  memory.test_InitPurchaseList(bot)
  memory.SetItemToSell(bot, "item_tpscroll")

  luaunit.assertEquals(memory.GetItemToSell(bot), "item_tpscroll")
  luaunit.assertEquals(
    PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_SELL,
    "item_tpscroll")
end

function test_SetItemToSell_second_time_succeed()
  test_RefreshBot()

  local bot = GetBot()

  PURCHASE_LIST = {}
  memory.test_InitPurchaseList(bot)
  memory.SetItemToSell(bot, "item_tpscroll")

  PURCHASE_LIST[bot:GetUnitName()] = {}
  memory.SetItemToSell(bot, "item_tpscroll")

  luaunit.assertEquals(memory.GetItemToSell(bot), "item_tpscroll")
  luaunit.assertEquals(
    PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_SELL,
    "item_tpscroll")
end

function test_GetItemToSell_when_purchase_list_empty_fails()
  memory.test_InitPurchaseList(GetBot())

  luaunit.assertEquals(memory.GetItemToSell(GetBot()), nil)
end

function test_GetItemToBuy_when_purchase_list_empty_fails()
  memory.test_InitPurchaseList(GetBot())

  luaunit.assertEquals(memory.GetItemToBuy(GetBot()), nil)
end

os.exit(luaunit.LuaUnit.run())
