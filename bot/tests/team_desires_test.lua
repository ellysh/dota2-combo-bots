package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local team_desires = require("team_desires")
local luaunit = require('luaunit')

function test_TeamThink()
  team_desires.TeamThink()
end

os.exit(luaunit.LuaUnit.run())
