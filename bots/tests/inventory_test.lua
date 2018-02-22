package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local luaunit = require("luaunit")
local inventory = require("inventory")

function test_PickUpItem_pickup_succeed()
  test_RefreshBot()

  ITEM_LOCATION = {10, 10}
  UNIT_PICKUP_ITEM = nil

  inventory.PickUpItem()

  luaunit.assertEquals(UNIT_PICKUP_ITEM, Item:new("item_branches"))
end

function test_PickUpItem_move_succeed()
  test_RefreshBot()

  ITEM_LOCATION = {1000, 1000}

  inventory.PickUpItem()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, {1000, 1000})
end

os.exit(luaunit.LuaUnit.run())
