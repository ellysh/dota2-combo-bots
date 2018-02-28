package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local luaunit = require("luaunit")
local inventory = require("inventory")

function test_FreeInventorySlot_succeed()
  test_RefreshBot()

  local bot = GetBot()

  bot.inventory = {
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
  }

  inventory.test_FreeInventorySlot(bot)

  luaunit.assertEquals(bot.inventory[1], nil)
end

function test_PickUpItem_pickup_succeed()
  test_RefreshBot()

  ITEM_LOCATION = {10, 10}
  UNIT_PICKUP_ITEM = nil
  UNIT_MODE = BOT_MODE_NONE

  inventory.PickUpItem()

  luaunit.assertEquals(UNIT_PICKUP_ITEM, Item:new("item_branches"))
end

function test_PickUpItem_move_succeed()
  test_RefreshBot()

  ITEM_LOCATION = {1000, 1000}
  UNIT_MOVE_LOCATION = nil

  inventory.PickUpItem()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, {1000, 1000})
end

function test_PickUpItem_pickup_in_roshpit_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {-2190, 1650}

  ITEM_LOCATION = {-2190, 1650}
  UNIT_PICKUP_ITEM = nil
  UNIT_MODE = BOT_MODE_ROSHAN

  inventory.PickUpItem()

  luaunit.assertEquals(UNIT_PICKUP_ITEM, Item:new("item_branches"))
end

function test_PickUpItem_pickup_mode_attack_fails()
  test_RefreshBot()

  ITEM_LOCATION = {10, 10}
  UNIT_PICKUP_ITEM = nil
  UNIT_MODE = BOT_MODE_ATTACK

  inventory.PickUpItem()

  luaunit.assertEquals(UNIT_PICKUP_ITEM, nil)
end

function test_PickUpItem_too_far_fails()
  test_RefreshBot()

  ITEM_LOCATION = {4000, 4000}
  UNIT_MOVE_LOCATION = nil

  inventory.PickUpItem()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, nil)
end

os.exit(luaunit.LuaUnit.run())
