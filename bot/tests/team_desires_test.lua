package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local team_desires = require("team_desires")
local luaunit = require('luaunit')

function test_ally_mega_creeps()
  BARRAK_HEALTH = 100
  luaunit.assertFalse(team_desires.ally_mega_creeps())

  BARRAK_HEALTH = 0
  luaunit.assertTrue(team_desires.ally_mega_creeps())
end

function test_TeamThink()
  BARRAK_HEALTH = 0
  team_desires.TeamThink()

  luaunit.assertEquals(
    team_desires.PUSH_LINES_DESIRE["PUSH_TOP_LINE_DESIRE"],
    0.2)

  luaunit.assertEquals(
    team_desires.PUSH_LINES_DESIRE["PUSH_MID_LINE_DESIRE"],
    0.2)

  luaunit.assertEquals(
    team_desires.PUSH_LINES_DESIRE["PUSH_BOT_LINE_DESIRE"],
    0.2)
end

os.exit(luaunit.LuaUnit.run())
