package.path = package.path .. ";../?.lua"
require("unit_scoped_functions")

function GetScriptDirectory()
  return ".."
end

ITEM_COST = 150

function GetItemCost(item)
  return ITEM_COST
end

BOT = Unit:new()

function GetBot()
  return BOT
end

function test_RefreshBot()
  BOT = Unit:new()
  BOT.inventory = {}
end

TOWER_HEALTH = 100
TOWER = Unit:new()

function GetTower(team, tower)
  TOWER.name = "tower" .. tostring(tower)
  TOWER.health = TOWER_HEALTH
  return TOWER
end

function GetAncient(team)
  local ancient = Unit:new("ancient")
  return ancient
end

BARRAK_HEALTH = 100

function GetBarracks(team, barrack_id)
  local unit = Unit:new("barrack" .. tostring(barrack_id))
  unit.health = BARRAK_HEALTH

  return unit
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

ROSHAN_KILL_TIME = 0

function GetRoshanKillTime()
  return ROSHAN_KILL_TIME
end

ROSHAN_DESIRE = 0

function GetRoshanDesire()
  return ROSHAN_DESIRE
end

function RandomSeed()
  math.randomseed(os.clock() * 100000)
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

TEAM = TEAM_RADIANT

function GetTeam()
  return TEAM
end

function GetOpposingTeam()
  if TEAM == TEAM_RADIANT then
    return TEAM_DIRE
  else
    return TEAM_RADIANT
  end
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
    math.pow(unit.location[1] - location[1], 2) +
    math.pow(unit.location[2] - location[2], 2))
end

function GetUnitToUnitDistance(unit1, unit2)
  return math.sqrt(
    math.pow(unit1.location[1] - unit2.location[1], 2) +
    math.pow(unit1.location[2] - unit2.location[2], 2))
end

function GetShopLocation(team, shop)
  if shop == SHOP_SIDE then return {10, 10} end

  if shop == SHOP_SIDE2 then return {20, 20} end

  if shop == SHOP_SECRET then return {10, 10} end

  if shop == SHOP_SECRET2 then return {20, 20} end

  if shop == SHOP_HOME then return {1000, 1000} end

  return nil
end

function GetHeroKills(player_id)
  return 2
end

IS_HERO_ALIVE = true

function IsHeroAlive(player_id)
  return IS_HERO_ALIVE
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

UNITS = {}

function GetUnitList(list_type)
  return UNITS
end

LANE_DISTANCE = 200

function GetAmountAlongLane(lane, location)
  return {amount = 3, distance = LANE_DISTANCE}
end

FRONT_LOCATION = {10, 10}

function GetLaneFrontLocation(team, lane, delta)
  return FRONT_LOCATION
end

PUSH_LANE_DESIRE = 0

function GetPushLaneDesire(lane)
  return PUSH_LANE_DESIRE
end

ROAM_DESIRE = 0

function GetRoamDesire(lane)
  return ROAM_DESIRE
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

RUNE_LOCATION = {20, 20}
RUNE_TYPE = RUNE_BOUNTY_1

function GetRuneSpawnLocation(rune)
  if rune ~= RUNE_TYPE then
    return {9000, 9000}
  else
    return RUNE_LOCATION
  end
end

RUNE_STATUS = RUNE_STATUS_UNKNOWN

function GetRuneStatus(rune)
  return RUNE_STATUS
end

SHRINE_COOLDOWN = 0

function GetShrineCooldown(shrine)
  return SHRINE_COOLDOWN
end

IS_SHRINE_HEALING = false

function IsShrineHealing(shrine)
  return IS_SHRINE_HEALING
end

SHRINE_LOCATION = {900, 900}

function GetShrine(team, shrine)
  local unit1 = Unit:new()
  unit1.name = "shrine1"
  unit1.health = 10
  unit1.location = SHRINE_LOCATION
  unit1.offensive_power = 100

  return unit1
end

TIME_OF_DAY = 0.5

function GetTimeOfDay()
  return TIME_OF_DAY
end

HERO_LAST_SEEN_INFO = {}

function GetHeroLastSeenInfo()
  return HERO_LAST_SEEN_INFO
end

ITEM_LOCATION = {10, 10}

function GetDroppedItemList()
  return {{
    item = Item:new("item_branches"),
    owner = Unit:new(),
    location = ITEM_LOCATION }}
end

-- The real Vector function creaes a Vector object.

function Vector(x, y, z)
  return {x, y}
end

NEUTRAL_CAMP_LOCATION = {10, 10}

function GetNeutralSpawners()
  return {
           {
             type = "neutral_camp0",
             location = NEUTRAL_CAMP_LOCATION
           }
         }
end
