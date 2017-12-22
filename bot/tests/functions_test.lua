package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local functions = require("functions")
local luaunit = require('luaunit')

function test_IsElementInList()
  local list = {1, 2, 3, 4, 5}

  luaunit.assertTrue(functions.IsElementInList(1, list))
  luaunit.assertTrue(functions.IsElementInList(2, list))
  luaunit.assertTrue(functions.IsElementInList(3, list))
  luaunit.assertTrue(functions.IsElementInList(4, list))
  luaunit.assertTrue(functions.IsElementInList(5, list))
  luaunit.assertFalse(functions.IsElementInList(6, list))
end

os.exit(luaunit.LuaUnit.run())
