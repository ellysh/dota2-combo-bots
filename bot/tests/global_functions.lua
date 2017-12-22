package.path = package.path .. ";../?.lua"
require("unit_scoped_functions")

function GetScriptDirectory()
    return ".."
end

function GetItemCost(item)
    local itemsCost = {
        ["item_tango"] = 150,
        ["item_flask"] = 110,
        ["item_courier"] = 200,
        ["item_tpscroll"] = 100,
        ["item_clarity"] = 50
    };

    return itemsCost[item]
end

function GetBot()
  local TestBot = Bot:new()

  return TestBot
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

function GetNumCouriers()
  return 0
end
