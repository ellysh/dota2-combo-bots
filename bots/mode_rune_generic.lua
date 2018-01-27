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

  if constants.MAX_HERO_DISTANCE_FROM_RUNE <= distance then
    return rune, distance
  else
    return nil, 0
  end
end

function GetDesire()
  if functions.IsBotInFightingMode(bot) then
    return 0 end

  local rune, distance = GetClosestRune(GetBot())

  if rune == nil or GetRuneStatus(rune) == RUNE_STATUS_MISSING then
    return 0 end

  if GetRuneStatus(rune) == RUNE_STATUS_AVAILABLE then
    return 0.75 end

  -- TODO: This code is the same as one ine the mode_shop.lua, GetDesire()
  -- Move it to a separate function.
  return (1 - (distance / constants.MAX_HERO_DISTANCE_FROM_RUNE)) + 0.2
end

function Think()
  local bot = GetBot()
  local rune, distance = GetClosestRune(bot)

  bot:Action_PickUpRune(rune)
end
