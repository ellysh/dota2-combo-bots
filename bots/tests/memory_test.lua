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
  test_RefreshBot()

  local bot = GetBot()

  memory.test_InitPurchaseList(bot)

  luaunit.assertEquals(memory.GetItemToSell(bot), nil)
end

function test_GetItemToBuy_when_purchase_list_empty_fails()
  test_RefreshBot()

  local bot = GetBot()
  memory.test_InitPurchaseList(bot)

  luaunit.assertEquals(memory.GetItemToBuy(bot), nil)
end

function test_GetItemToBuy_when_purchase_list_not_exist_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.name = "unknown"

  luaunit.assertEquals(memory.GetItemToBuy(GetBot()), nil)
end

function test_IsRecipeItem_succeed()
  luaunit.assertTrue(memory.test_IsRecipeItem("item_magic_wand"))
end

function test_IsRecipeItem_fails()
  luaunit.assertFalse(memory.test_IsRecipeItem("item_tango"))
  luaunit.assertFalse(memory.test_IsRecipeItem("item_branches"))

end

function test_InitNeutralCampList_succeed()
  NEUTRAL_CAMP_LIST = {}

  memory.InitNeutralCampList()

  luaunit.assertEquals(
    NEUTRAL_CAMP_LIST,
    {{is_full=true, location={15, 15}, type="medium"}})
end

function test_InitNeutralCampList_reinit_succeed()
  NEUTRAL_CAMP_LIST = {}

  memory.InitNeutralCampList()
  memory.InitNeutralCampList()

  luaunit.assertEquals(
    NEUTRAL_CAMP_LIST,
    {{is_full=true, location={15, 15}, type="medium"}})
end

function test_Rememeber_init_succeed()
  NEUTRAL_CAMP_LIST = {}

  memory.Remember()

  luaunit.assertEquals(
    NEUTRAL_CAMP_LIST,
    {{is_full=true, location={15, 15}, type="medium"}})
end

function test_NeutralCampSpawn_succeed()
  NEUTRAL_CAMP_LIST = {{is_full=false, location={15, 15}, type="medium"}}

  TIME = 120
  memory.test_NeutralCampSpawn()

  luaunit.assertEquals(
    NEUTRAL_CAMP_LIST,
    {{is_full=true, location={15, 15}, type="medium"}})
end

function test_NeutralCampSpawn_too_early_fails()
  NEUTRAL_CAMP_LIST = {{is_full=false, location={15, 15}, type="medium"}}

  TIME = 119
  memory.test_NeutralCampSpawn()

  luaunit.assertEquals(
    NEUTRAL_CAMP_LIST,
    {{is_full=false, location={15, 15}, type="medium"}})
end

function test_NeutralCampSpawn_succeed()
  NEUTRAL_CAMP_LIST = {{is_full=false, location={15, 15}, type="medium"}}

  local camps = memory.GetNeutralCampList()

  luaunit.assertEquals(camps, NEUTRAL_CAMP_LIST)
end

function test_SetNeutralCampEmpty_succeed()
  NEUTRAL_CAMP_LIST = {{is_full=true, location={15, 15}, type="medium"}}

  memory.SetNeutralCampEmpty({15, 15})

  luaunit.assertEquals(
    NEUTRAL_CAMP_LIST,
    {{is_full=false, location={15, 15}, type="medium"}})
end

function test_SetNeutralCampEmpty_wrong_coordinates_fails()
  NEUTRAL_CAMP_LIST = {{is_full=true, location={15, 15}, type="medium"}}

  memory.SetNeutralCampEmpty({10, 20})

  luaunit.assertEquals(
    NEUTRAL_CAMP_LIST,
    {{is_full=true, location={15, 15}, type="medium"}})
end

os.exit(luaunit.LuaUnit.run())
