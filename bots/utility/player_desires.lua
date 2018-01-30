local desires = require(
  GetScriptDirectory() .."/utility/desires")

local player_desires = require(
  GetScriptDirectory() .."/database/player_desires")

local player_desires_algorithms = require(
  GetScriptDirectory() .."/utility/player_desires_algorithms")

local M = {}

PLAYER_DESIRES = {}

function M.GetDesire(mode_name)
  local bot = GetBot()

  PLAYER_DESIRES[bot:GetUnitName()] = desires.Think(
    player_desires.PLAYER_DESIRES,
    player_desires_algorithms)

  return PLAYER_DESIRES[bot:GetUnitName()][mode_name]
end

return M
