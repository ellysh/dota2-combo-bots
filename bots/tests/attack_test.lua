package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local attack = require("attack")
local luaunit = require('luaunit')

function test_GetDesire_succeed()
  test_RefreshBot()

  mode_desires = {
      BOT_MODE_ROAM = 90,
      BOT_MODE_TEAM_ROAM = 80,
      BOT_MODE_PUSH_TOWER = 70,
      BOT_MODE_ATTACK = 60,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 0,
      BOT_MODE_DEFEND_TOWER = 50,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 40
  }

  UNIT_MODE = BOT_MODE_TEAM_ROAM
  luaunit.assertEquals(attack.test_GetDesire(GetBot(), mode_desires), 80)
end

function test_ChooseTarget_succeed()
  test_RefreshBot()

  UNIT_MODE = BOT_MODE_TEAM_ROAM

  local target = attack.ChooseTarget(GetBot())
  luaunit.assertNotEquals(target, nil)
  luaunit.assertEquals(target:GetUnitName(), "unit1")
end

function test_Attack_succeed()
  test_RefreshBot()

  local bot = GetBot()
  ATTACK_TARGET = nil
  UNIT_IS_CHANNELING = false
  UNIT_MODE = BOT_MODE_TEAM_ROAM

  local target = attack.ChooseTarget(GetBot())
  attack.Attack(bot, target)

  luaunit.assertNotEquals(ATTACK_TARGET, nil)
end

function test_Attack_when_bot_is_busy_fails()
  test_RefreshBot()

  local bot = GetBot()
  ATTACK_TARGET = nil
  UNIT_IS_CHANNELING = true

  local target = attack.ChooseTarget(GetBot())
  attack.Attack(bot, target)

  luaunit.assertEquals(ATTACK_TARGET, nil)
end

os.exit(luaunit.LuaUnit.run())
