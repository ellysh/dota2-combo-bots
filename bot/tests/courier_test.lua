package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local courier = require("courier")
local luaunit = require('luaunit')

function test_IsCourierFree()
  luaunit.assertFalse(courier.test_IsCourierFree(COURIER_STATE_MOVING))

  luaunit.assertFalse(
    courier.test_IsCourierFree(COURIER_STATE_DELIVERING_ITEMS))

  luaunit.assertTrue(courier.test_IsCourierFree(COURIER_STATE_IDLE))
end

function test_IsCourierIdle()
  luaunit.assertTrue(courier.test_IsCourierIdle(0, COURIER_STATE_IDLE))
end

os.exit(luaunit.LuaUnit.run())
