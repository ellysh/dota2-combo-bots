package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local minions = require("minions")
local luaunit = require('luaunit')

function test_MinionThink_move_to_hero_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {500, 500}

  minions.MinionThink(Unit:new())

  luaunit.assertEquals(UNIT_MOVE_LOCATION, bot.location)
end

function test_MinionThink_attack_succeed()
  test_RefreshBot()

  local bot = GetBot()
  local target = Unit:new()

  ATTACK_TARGET = nil
  bot:SetTarget(target)

  minions.MinionThink(Unit:new())

  luaunit.assertEquals(ATTACK_TARGET, target)
end

os.exit(luaunit.LuaUnit.run())
