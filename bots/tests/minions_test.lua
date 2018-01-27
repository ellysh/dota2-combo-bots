package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local minions = require("minions")
local luaunit = require('luaunit')

function test_MinionThink_move_to_hero_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {500, 500}
  UNIT_NO_NEARBY_UNITS = true

  minions.MinionThink(Unit:new())

  luaunit.assertEquals(UNIT_MOVE_LOCATION, bot.location)
end

function test_MinionThink_attack_when_owner_not_near_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {500, 500}
  UNIT_NO_NEARBY_UNITS = false

  minions.MinionThink(Unit:new())

  luaunit.assertNotEquals(ATTACK_TARGET, nil)
end

function test_MinionThink_attack_when_owner_near_succeed()
  test_RefreshBot()

  local bot = GetBot()
  local target = Unit:new()
  ATTACK_TARGET = nil
  bot:SetTarget(target)

  minions.MinionThink(Unit:new())

  luaunit.assertEquals(ATTACK_TARGET, target)
end

os.exit(luaunit.LuaUnit.run())
