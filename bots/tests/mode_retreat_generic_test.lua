package.path = package.path .. ";../?.lua"

pcall(require, "luacov")
require("global_functions")

local mode_retreat = require("mode_retreat_generic")
local luaunit = require('luaunit')

function test_IsHealingByShrine_succeed()
  test_RefreshBot()

  IS_SHRINE_HEALING = true

  luaunit.assertTrue(
    mode_retreat.test_IsHealingByShrine(GetBot(), Unit:new()))
end

function test_IsHealingByShrine_when_distance_too_big_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {3000, 3000}

  IS_SHRINE_HEALING = true

  luaunit.assertFalse(
    mode_retreat.test_IsHealingByShrine(GetBot(), Unit:new()))
end

function test_IsHealingByShrine_when_shrine_not_healing_fails()
  test_RefreshBot()

  IS_SHRINE_HEALING = false

  luaunit.assertFalse(
    mode_retreat.test_IsHealingByShrine(GetBot(), Unit:new()))
end

function test_IsShrineFull_succeed()
  SHRINE_COOLDOWN = 0

  luaunit.assertTrue(mode_retreat.test_IsShrineFull(Unit:new()))
end

function test_IsShrineFull_fails()
  SHRINE_COOLDOWN = 10

  luaunit.assertFalse(mode_retreat.test_IsShrineFull(Unit:new()))
end

function test_IsEnemyOnTheWay_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {10, 10}

  UNIT_NO_NEARBY_UNITS = false

  luaunit.assertTrue(mode_retreat.test_IsEnemyOnTheWay(bot, {100, 100}))
end

function test_IsEnemyOnTheWay_no_enemy_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {95, 84}

  UNIT_NO_NEARBY_UNITS = false

  luaunit.assertFalse(mode_retreat.test_IsEnemyOnTheWay(bot, {100, 100}))
end

function test_GetDesire_with_normal_hp_negative()
  test_RefreshBot()
  IS_SHRINE_HEALING = false

  luaunit.assertEquals(GetDesire(), 0)
end

function test_GetDesire_when_low_hp_positive()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 50
  UNIT_NO_NEARBY_UNITS = true
  IS_SHRINE_HEALING = false

  luaunit.assertEquals(GetDesire(), 0.85)
end

function test_Think_move_succeed()
  test_RefreshBot()

  UNIT_NO_NEARBY_UNITS = true
  UNIT_MOVE_LOCATION = nil
  SHRINE_LOCATION = {900, 900}

  Think()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, {900, 900})
end

function test_Think_use_shrine_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {95, 95}

  UNIT_NO_NEARBY_UNITS = false
  UNIT_USE_SHRINE = nil
  SHRINE_LOCATION = {100, 100}

  Think()

  luaunit.assertNotEquals(UNIT_USE_SHRINE, nil)
end

function test_Think_enemy_on_the_way_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {10, 10}

  UNIT_NO_NEARBY_UNITS = false
  UNIT_USE_SHRINE = nil
  SHRINE_LOCATION = {100, 100}

  Think()

  luaunit.assertEquals(UNIT_USE_SHRINE, nil)
end

os.exit(luaunit.LuaUnit.run())
