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
    ["item_ultimate_orb"] = 2150,
    ["item_magic_stick"] = 200
  };

  return itemsCost[item]
end

BOT = Bot:new()

function GetBot()
  return BOT
end

function test_RefreshBot()
  BOT = Bot:new()
end

local TestUnit = Unit:new()

function GetTower(team, tower)
  return TestUnit
end

function GetGlyphCooldown()
  return 0
end

TIME = 0.0

function DotaTime()
  return TIME
end

function RealTime()
  return TIME
end

function RandomInt()
  return 2
end

function GetSelectedHeroName(playerId)
  return "npc_dota_hero_venomancer"
end

--------------------------------------

function GetNumCouriers()
  return 0
end

COURIER = Unit:new()

function GetCourier()
  return COURIER
end

function test_RefreshCourier()
  COURIER = Unit:new()
end

COURIER_STATE = COURIER_STATE_IDLE

function GetCourierState(courier)
  return COURIER_STATE
end

--------------------------------------

function IsItemPurchasedFromSecretShop()
  return false
end

function IsItemPurchasedFromSideShop()
  return false
end
