package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local algorithms = require("player_desires_algorithms")
local luaunit = require('luaunit')

function test_has_low_hp()
  test_RefreshBot()

  local bot = GetBot()

  bot.health = 10
  luaunit.assertTrue(algorithms.has_low_hp(bot, ability))

  bot.health = bot.max_health
  luaunit.assertFalse(algorithms.has_low_hp(bot, ability))
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

function test_has_tp_scrol_or_travel_boots()
  test_RefreshBot()

  luaunit.assertFalse(algorithms.has_tp_scrol_or_travel_boots())

  local bot = GetBot()

  bot.inventory = { "item_tpscroll" }
  luaunit.assertTrue(algorithms.has_tp_scrol_or_travel_boots())

  bot.inventory = { "item_travel_boots_1" }
  luaunit.assertTrue(algorithms.has_tp_scrol_or_travel_boots())

  bot.inventory = { "item_travel_boots_2" }
  luaunit.assertTrue(algorithms.has_tp_scrol_or_travel_boots())
end

function test_player_has_buyback()
  test_RefreshBot()

  UNIT_HAS_BUYBACK = true
  luaunit.assertTrue(algorithms.has_buyback())

  local bot = GetBot()
  bot.gold = 10
  luaunit.assertFalse(algorithms.has_buyback())

  UNIT_HAS_BUYBACK = false
  bot.gold = bot:GetBuybackCost() + 100
  luaunit.assertFalse(algorithms.has_buyback())
end

function test_more_enemy_heroes_around_then_ally_succeed()
  test_RefreshBot()

  UNIT_NO_NEARBY_UNITS = false
  UNIT_NO_NEARBY_ALLIES = true

  luaunit.assertTrue(algorithms.more_enemy_heroes_around_then_ally())
end

function test_more_enemy_heroes_around_then_ally_fails()
  test_RefreshBot()

  luaunit.assertFalse(algorithms.more_enemy_heroes_around_then_ally())
end

function test_is_shrine_healing_and_no_enemy_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {600, 600}

  UNIT_NO_NEARBY_UNITS = true
  IS_SHRINE_HEALING = true

  luaunit.assertTrue(algorithms.is_shrine_healing_and_no_enemy())
end

function test_is_shrine_healing_and_no_enemy_fails()
  test_RefreshBot()

  UNIT_NO_NEARBY_UNITS = false
  IS_SHRINE_HEALING = true

  luaunit.assertFalse(algorithms.is_shrine_healing_and_no_enemy())
end

function test_is_shrine_healing_and_enemies_near_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {600, 600}

  UNIT_NO_NEARBY_UNITS = false
  IS_SHRINE_HEALING = true

  luaunit.assertTrue(algorithms.is_shrine_healing_and_enemies_near())
end

function test_has_not_full_hp_mp_and_near_fountain_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 10

  UNIT_MODIFIER = "modifier_fountain_aura_buff"

  luaunit.assertTrue(algorithms.has_not_full_hp_mp_and_near_fountain())
end

function test_is_attacked_by_tower_succeed()
  test_RefreshBot()

  local bot = GetBot()
  ATTACK_TARGET = bot
  UNIT_IS_NEARBY_TOWERS = true
  UNIT_NO_NEARBY_UNITS = false

  luaunit.assertTrue(algorithms.is_attacked_by_tower())
end

function test_is_attacked_by_tower_no_tower_fails()
  test_RefreshBot()

  local bot = GetBot()
  ATTACK_TARGET = bot
  UNIT_IS_NEARBY_TOWERS = false
  UNIT_NO_NEARBY_UNITS = false

  luaunit.assertFalse(algorithms.is_attacked_by_tower())
end

function test_is_attacked_by_tower_not_attacked_fails()
  test_RefreshBot()

  local bot = GetBot()
  ATTACK_TARGET = nil
  UNIT_IS_NEARBY_TOWERS = true
  UNIT_NO_NEARBY_UNITS = false

  luaunit.assertFalse(algorithms.is_attacked_by_tower())
end

function test_is_attacked_by_enemy_hero_succeed()
  test_RefreshBot()

  local bot = GetBot()
  UNIT_WAS_DAMAGED = true

  luaunit.assertTrue(algorithms.is_attacked_by_enemy_hero())
end

function test_is_attacked_by_enemy_hero_fails()
  test_RefreshBot()

  local bot = GetBot()
  UNIT_WAS_DAMAGED = false

  luaunit.assertFalse(algorithms.is_attacked_by_enemy_hero())
end

function test_is_attacked_by_any_creep_succeed()
  test_RefreshBot()

  local bot = GetBot()
  UNIT_WAS_DAMAGED = true

  luaunit.assertTrue(algorithms.is_attacked_by_any_creep())
end

function test_is_attacked_by_any_creep_fails()
  test_RefreshBot()

  local bot = GetBot()
  UNIT_WAS_DAMAGED = false

  luaunit.assertFalse(algorithms.is_attacked_by_any_creep())
end

os.exit(luaunit.LuaUnit.run())
