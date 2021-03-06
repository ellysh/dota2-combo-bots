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

function test_is_shrine_healing_and_no_enemy_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {600, 600}

  UNIT_HAS_NEARBY_UNITS = false
  IS_SHRINE_HEALING = true

  luaunit.assertTrue(algorithms.is_shrine_healing_and_no_enemy())
end

function test_is_shrine_healing_and_no_enemy_fails()
  test_RefreshBot()

  UNIT_HAS_NEARBY_UNITS = true
  IS_SHRINE_HEALING = true

  luaunit.assertFalse(algorithms.is_shrine_healing_and_no_enemy())
end

function test_is_shrine_healing_and_enemies_near_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {600, 600}

  UNIT_HAS_NEARBY_UNITS = true
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

function test_is_focused_by_enemies_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 100

  ATTACK_TARGET = bot
  UNIT_HAS_NEARBY_UNITS = true

  luaunit.assertTrue(algorithms.is_focused_by_enemies())
end

function test_is_focused_by_enemies_low_damage_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 5000

  ATTACK_TARGET = bot
  UNIT_HAS_NEARBY_UNITS = true

  luaunit.assertFalse(algorithms.is_focused_by_enemies())
end

function test_is_weaker_enemy_group_near_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 5000

  NEARBY_HEROES_COUNT = 1
  UNIT_HAS_NEARBY_ALLIES = true
  UNIT_HAS_NEARBY_UNITS = true

  luaunit.assertTrue(algorithms.is_weaker_enemy_group_near())
end

function test_is_weaker_enemy_group_near_when_stronger_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 10
  bot.damage = 1

  UNIT_HAS_NEARBY_ALLIES = false
  NEARBY_HEROES_COUNT = 1
  UNIT_HAS_NEARBY_UNITS = true

  luaunit.assertFalse(algorithms.is_weaker_enemy_group_near())
end

function test_roam_target_is_near_succeed()
  test_RefreshBot()

  IS_HERO_ALIVE = true
  HERO_LAST_SEEN_INFO = { {location = {10, 10}, time_since_seen = 2} }

  luaunit.assertTrue(algorithms.roam_target_is_near())
end

function test_roam_target_is_near_but_too_far_fails()
  test_RefreshBot()

  IS_HERO_ALIVE = true
  HERO_LAST_SEEN_INFO = { {location = {5000, 5000}, time_since_seen = 2} }

  luaunit.assertFalse(algorithms.roam_target_is_near())
end

function test_has_level_six_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 6

  luaunit.assertTrue(algorithms.has_level_six())
end

function test_has_level_six_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 5

  luaunit.assertFalse(algorithms.has_level_six())
end

function test_ally_hero_is_near_succeed()
  test_RefreshBot()

  UNIT_HAS_NEARBY_UNITS = true

  luaunit.assertTrue(algorithms.ally_hero_is_near())
end

function test_ally_hero_is_near_fails()
  test_RefreshBot()

  UNIT_HAS_NEARBY_UNITS = false

  luaunit.assertFalse(algorithms.ally_hero_is_near())
end

function test_has_high_damage_and_health_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.max_health = 1000
  bot.damage = 100

  luaunit.assertTrue(algorithms.has_high_damage_and_health())
end

function test_has_high_damage_and_health_low_health_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 100
  bot.damage = 100

  luaunit.assertFalse(algorithms.has_high_damage_and_health())
end

function test_has_high_damage_and_health_low_damage_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 1000
  bot.damage = 10

  luaunit.assertFalse(algorithms.has_high_damage_and_health())
end

function test_ally_hero_in_roshpit_succeed()
  test_RefreshBot()

  local unit = Unit:new()
  unit.location = {-2250, 1700}

  UNITS = {unit}

  luaunit.assertTrue(algorithms.ally_hero_in_roshpit())
end

function test_ally_hero_in_roshpit_too_far_fails()
  test_RefreshBot()

  local unit = Unit:new()
  unit.location = {-1000, 1000}

  UNITS = {unit}

  luaunit.assertFalse(algorithms.ally_hero_in_roshpit())
end

function test_ally_hero_in_roshpit_dead_fails()
  test_RefreshBot()

  local unit = Unit:new()
  unit.location = {-2250, 1700}
  unit.health = 0

  UNITS = {unit}

  luaunit.assertFalse(algorithms.ally_hero_in_roshpit())
end

os.exit(luaunit.LuaUnit.run())
