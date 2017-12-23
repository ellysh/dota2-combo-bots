package.path = package.path .. ";../?.lua"
require("unit_scoped_functions")

function GetScriptDirectory()
  return ".."
end

function GetItemCost(item)
  local itemsCost = {
    ["item_tango"] = 150,
    ["item_branches"] = 50,
    ["item_flask"] = 110,
    ["item_courier"] = 200,
    ["item_tpscroll"] = 100,
    ["item_clarity"] = 50,
    ["item_enchanted_mango"] = 100,
    ["item_magic_stick"] = 200
  };

  return itemsCost[item]
end

local TestBot = Bot:new()

function GetBot()
  return TestBot
end

function test_RefreshBot()
  TestBot = Bot:new()
end

local TestUnit = Unit:new()

function GetTower(team, tower)
  return TestUnit
end

function GetGlyphCooldown()
  return 0
end

local Time = 0.0

function DotaTime()
  Time = Time + 0.2
  return Time
end

function RealTime()
  return DotaTime() + 1
end

function RandomInt()
  return 2
end

function GetSelectedHeroName(playerId)
  return "npc_dota_hero_venomancer"
end

--------------------------------------


COURIER_ACTION_BURST = 0
COURIER_ACTION_ENEMY_SECRET_SHOP = 1
COURIER_ACTION_RETURN = 2
COURIER_ACTION_SECRET_SHOP = 3
COURIER_ACTION_SIDE_SHOP = 4
COURIER_ACTION_SIDE_SHOP2 = 5
COURIER_ACTION_TAKE_STASH_ITEMS = 6
COURIER_ACTION_TAKE_AND_TRANSFER_ITEMS = 7
COURIER_ACTION_TRANSFER_ITEMS = 8

COURIER_STATE_IDLE = 9
COURIER_STATE_AT_BASE = 10
COURIER_STATE_MOVING = 11
COURIER_STATE_DELIVERING_ITEMS = 12
COURIER_STATE_RETURNING_TO_BASE = 13
COURIER_STATE_DEAD = 14

function GetNumCouriers()
  return 0
end

function GetCourier()
  return nil
end
