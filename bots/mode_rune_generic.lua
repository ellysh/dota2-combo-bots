local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

local RUNES = {
    RUNE_POWERUP_1,
    RUNE_POWERUP_2,
    RUNE_BOUNTY_1,
    RUNE_BOUNTY_2,
    RUNE_BOUNTY_3,
    RUNE_BOUNTY_4,
}

local function GetClosestRune(bot)
  local rune_distance = {}

  for _, rune in pairs(RUNES) do
    local loc = GetRuneSpawnLocation(rune)
    rune_distance[rune] = GetUnitToLocationDistance(bot, loc)
  end

  local rune, distance = functions.GetKeyAndElementWith(
    rune_distance,
    function(t, a, b) return t[a] < t[b] end)

  if distance < constants.MAX_HERO_DISTANCE_FROM_RUNE then
    return rune, distance
  else
    return nil, 0
  end
end

local function IsBeginningOfMatch()
  return DotaTime() < 0
end

local function IsRuneAppeared()
  local time = DotaTime()
  local last_appear = time - (time % 2)

  return 1.8 <= (time - last_appear)
         or (time - last_appear) <= 0.2
end

local function IsPowerRune(rune)
  return rune == RUNE_POWERUP_1
         or rune == RUNE_POWERUP_2
end

function GetDesire()
  local bot = GetBot()

  if functions.IsBotInFightingMode(bot) then
    return 0 end

  local rune, distance = GetClosestRune(bot)

  if rune == nil then
    return 0 end

  if IsBeginningOfMatch()
     and not IsPowerRune(rune) then
    return 0.75 end

  if GetRuneStatus(rune) == RUNE_STATUS_MISSING
     and not IsRuneAppeared() then
    return 0 end

  if GetRuneStatus(rune) == RUNE_STATUS_AVAILABLE then
    return 0.75 end

  return functions.DistanceToDesire(
    distance,
    constants.MAX_HERO_DISTANCE_FROM_RUNE,
    0.3)
end

function Think()
  local bot = GetBot()
  local rune, distance = GetClosestRune(bot)

  if rune == nil then
    return end

  if bot:GetCurrentVisionRange() < distance then
    bot:Action_MoveToLocation(GetRuneSpawnLocation(rune))
  else
    bot:Action_PickUpRune(rune)
  end
end

return M
