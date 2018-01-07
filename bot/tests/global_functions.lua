package.path = package.path .. ";../?.lua"
require("unit_scoped_functions")

math.randomseed(os.clock() * 100000)

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
    ["item_magic_stick"] = 200,
    ["item_ring_of_health"] = 850,
    ["item_void_stone"] = 850,
    ["item_platemail"] = 1400,
    ["item_energy_booster"] = 900,
  };

  return itemsCost[item]
end

BOT = Bot:new()

function GetBot()
  return BOT
end

function test_RefreshBot()
  BOT = Bot:new()
  BOT.inventory = {}
end

local TestUnit = Unit:new()

function GetTower(team, tower)
  return TestUnit
end

function GetGlyphCooldown()
  return 0
end

TIME = 0.0

function GameTime()
  return TIME
end

function DotaTime()
  return TIME
end

function RealTime()
  return TIME
end

RANDOM_ENABLE = false

function RandomInt(min, max)
  if RANDOM_ENABLE then
    return math.random(min, max)
  else
    return 2
  end
end

function RandomFloat(min, max)
  if RANDOM_ENABLE then
    return math.random(min, max)
  else
    return 0.2
  end
end

function GetTeam()
  return TEAM_RADIANT
end

function GetOpposingTeam()
  return TEAM_DIRE
end

function GetTeamPlayers(team)
  return {1, 2, 3, 4, 5}
end

function IsPlayerBot(playerId)
  return true
end

SELECTED_HEROES = {}

function SelectHero(playerId, heroName)
  SELECTED_HEROES[playerId] = heroName
end

function GetSelectedHeroName(playerId)
  return SELECTED_HEROES[playerId]
end

function GetUnitToLocationDistance(unit, location)
  return math.sqrt(
    math.pow(unit.location[1] + location[1], 2) +
    math.pow(unit.location[2] + location[2], 2))
end

function GetUnitToUnitDistance(unit1, unit2)
  return math.sqrt(
    math.pow(unit1.location[1] + unit2.location[1], 2) +
    math.pow(unit1.location[2] + unit2.location[2], 2))
end

function GetShopLocation(team, shop)
  if shop == SHOP_SIDE then return {10, 10} end

  if shop == SHOP_SIDE2 then return {20, 20} end

  return nil
end

function GetHeroKills(player_id)
  return 2
end

--------------------------------------

COURIER = Unit:new()

function GetCourier()
  return COURIER
end

function GetNumCouriers()
  if COURIER ~= nil then return 1 end

  return 0
end

function test_RefreshCourier()
  COURIER = Unit:new()
end

COURIER_STATE = COURIER_STATE_IDLE

function GetCourierState(courier)
  return COURIER_STATE
end

BARRAK_HEALTH = 100

function GetBarracks(team, barrack_index)
  local unit = Unit:new()
  unit.name = "unit1"
  unit.health = BARRAK_HEALTH

  return unit
end

--------------------------------------

IS_SECRET_SHOP_ITEM = false

function IsItemPurchasedFromSecretShop()
  return IS_SECRET_SHOP_ITEM
end

IS_SIDE_SHOP_ITEM = false

function IsItemPurchasedFromSideShop()
  return IS_SIDE_SHOP_ITEM
end
