package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local ability_usage = require("ability_usage")
local luaunit = require('luaunit')

function test_GetDesireAndTargetList()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  abilities = {
    ability,
  }

  local result = ability_usage.test_GetDesireAndTargetList(abilities)
end

os.exit(luaunit.LuaUnit.run())
