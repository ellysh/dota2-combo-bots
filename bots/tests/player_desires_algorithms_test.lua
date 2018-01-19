package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local algorithms = require("player_desires_algorithms")
local luaunit = require('luaunit')

function test_have_low_hp()
  test_RefreshBot()

  local bot = GetBot()

  bot.health = 10
  luaunit.assertTrue(algorithms.have_low_hp(bot, ability))

  bot.health = bot.max_health
  luaunit.assertFalse(algorithms.have_low_hp(bot, ability))
end

function test_PlayerOnLane()
  test_RefreshBot()

  luaunit.assertTrue(algorithms.test_PlayerOnLane(LANE_TOP))

  LANE_DISTANCE = 3000

  luaunit.assertFalse(algorithms.test_PlayerOnLane(LANE_TOP))
end

function test_player_on_top()
  test_RefreshBot()

  LANE_DISTANCE = 200
  luaunit.assertTrue(algorithms.player_on_top())

  LANE_DISTANCE = 3000
  luaunit.assertFalse(algorithms.player_on_top())
end

function test_player_on_mid()
  test_RefreshBot()

  LANE_DISTANCE = 200
  luaunit.assertTrue(algorithms.player_on_mid())

  LANE_DISTANCE = 3000
  luaunit.assertFalse(algorithms.player_on_mid())
end

function test_player_on_bot()
  test_RefreshBot()

  LANE_DISTANCE = 200
  luaunit.assertTrue(algorithms.player_on_bot())

  LANE_DISTANCE = 3000
  luaunit.assertFalse(algorithms.player_on_bot())
end

function test_have_tp_scrol_or_travel_boots()
  test_RefreshBot()

  luaunit.assertFalse(algorithms.have_tp_scrol_or_travel_boots())

  local bot = GetBot()

  bot.inventory = { "item_tpscroll" }
  luaunit.assertTrue(algorithms.have_tp_scrol_or_travel_boots())

  bot.inventory = { "item_travel_boots_1" }
  luaunit.assertTrue(algorithms.have_tp_scrol_or_travel_boots())

  bot.inventory = { "item_travel_boots_2" }
  luaunit.assertTrue(algorithms.have_tp_scrol_or_travel_boots())
end

os.exit(luaunit.LuaUnit.run())
