local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

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

local function IsRuneAppearSoon()
  local time = DotaTime()

  if time < 0 then
    return false end

  local last_appear = time - (time % 2)

  return 1.9 <= (time - last_appear)
end

function GetDesire()
  local bot = GetBot()

  if functions.IsBotInFightingMode(bot) then
    return 0 end

  local rune, distance = GetClosestRune(bot)

  if rune == nil then
    return 0 end

  if IsBeginningOfMatch() then
    return 0.75 end

  if GetRuneStatus(rune) == RUNE_STATUS_MISSING
     and not IsRuneAppearSoon() then
    return 0 end

  if GetRuneStatus(rune) == RUNE_STATUS_AVAILABLE then
    return 0.75 end

  -- TODO: This code is the same as one ine the mode_shop.lua, GetDesire()
  -- Move it to a separate function.
  return (1 - (distance / constants.MAX_HERO_DISTANCE_FROM_RUNE)) + 0.3
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
