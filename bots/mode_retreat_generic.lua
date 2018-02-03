local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local move = require(
  GetScriptDirectory() .."/utility/move")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

local M = {}

function GetDesire()
  return player_desires.GetDesire("BOT_MODE_RETREAT")
end

local function IsHealingByShrine(bot, shrine)
  return IsShrineHealing(shrine)
         and GetUnitToUnitDistance(bot, shrine)
             <= constants.SHRINE_AURA_RADIUS
end

local function IsShrineFull(shrine)
  return GetShrineCooldown(shrine) == 0
end

local function AddShrineToList(bot, shrine_id, list)
  local shrine = GetShrine(GetTeam(), shrine_id)

  if IsHealingByShrine(bot, shrine)
     or IsShrineFull(shrine) then
    table.insert(list, shrine:GetLocation())
  end
end

local SHRINES = {
  SHRINE_JUNGLE_1,
  SHRINE_JUNGLE_2,
}

function Think()
  local bot = GetBot()

  local retreat_locations = { GetShopLocation(GetTeam(), SHOP_HOME) }

  for _, shrine_id in pairs(SHRINES) do
    AddShrineToList(bot, shrine_id, retreat_locations)
  end

  local target_location = functions.GetNearestLocation(
    bot,
    retreat_locations)

  if GetUnitToLocationDistance(bot, target_location)
     <= constants.SHRINE_USE_RADIUS then

    local shrines = bot:GetNearbyShrines(
      constants.SHRINE_USE_RADIUS,
      false)

    if 0 < #shrines then
      bot:Action_UseShrine(shrines[1]) end

  else
    move.Move(bot, target_location)
  end
end

-- Provide an access to local functions and variables for unit tests only
M.test_IsHealingByShrine = IsHealingByShrine
M.test_IsShrineFull = IsShrineFull

return M
