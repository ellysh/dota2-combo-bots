local desires = require(
  GetScriptDirectory() .."/utility/desires")

local team_desires = require(
  GetScriptDirectory() .."/database/team_desires")

local team_desires_algorithms = require(
  GetScriptDirectory() .."/utility/team_desires_algorithms")

local M = {}

PLAYER_DESIRES = {
  BOT_MODE_PUSH_TOWER_TOP = 0,
  BOT_MODE_PUSH_TOWER_MID = 0,
  BOT_MODE_PUSH_TOWER_BOT = 0,
}

function Think()
  --TODO: Implement this function
end

return M
