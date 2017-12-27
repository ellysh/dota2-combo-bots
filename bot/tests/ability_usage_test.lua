package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local ability_usage = require("ability_usage")
local luaunit = require('luaunit')

function test_ChooseAbilityAndTarget()
  test_RefreshBot()

  local ability, target =
    ability_usage.test_ChooseAbilityAndTarget(GetBot())

  luaunit.assertEquals(
    ability,
    Ability:new("crystal_maiden_crystal_nova"))

  luaunit.assertEquals(target, {0, 0})
end

os.exit(luaunit.LuaUnit.run())
