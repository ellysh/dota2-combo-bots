package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local team_desires = require("team_desires")
local luaunit = require('luaunit')

function test_ally_mega_creeps()
  luaunit.assertFalse(team_desires.ally_mega_creeps())

  BARRAK_HEALTH = 0

  luaunit.assertTrue(team_desires.ally_mega_creeps())
end

function test_TeamThink()
  team_desires.TeamThink()
end

os.exit(luaunit.LuaUnit.run())
