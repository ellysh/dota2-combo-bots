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

  luaunit.assertNotEquals(result, nil)
  luaunit.assertEquals(result[ability][1], BOT_ACTION_DESIRE_HIGH)
  luaunit.assertEquals(result[ability][2], {0, 0})
end

os.exit(luaunit.LuaUnit.run())
