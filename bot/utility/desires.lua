local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local team_desires_algorithms = require(
  GetScriptDirectory() .."/utility/team_desires_algorithms")

local team_desires = require(
  GetScriptDirectory() .."/database/team_desires")

local M = {}

M.PUSH_LINES_DESIRE = {
  PUSH_TOP_LINE_DESIRE = 0,
  PUSH_MID_LINE_DESIRE = 0,
  PUSH_BOT_LINE_DESIRE = 0
}

local function ResetTeamDesires()
  for key, _ in pairs(M.PUSH_LINES_DESIRE) do
    M.PUSH_LINES_DESIRE[key] = 0
  end
end

function M.Think()
  ResetTeamDesires()

  for algorithm, desires in functions.spairs(team_desires.TEAM_DESIRES) do
    if team_desires_algorithms[algorithm] == nil then goto continue end

    local desire_index = functions.ternary(
      team_desires_algorithms[algorithm](),
      1,
      2)

    for key, value in pairs(desires) do
      M.PUSH_LINES_DESIRE[key] =
        M.PUSH_LINES_DESIRE[key] + value[desire_index]
    end
    ::continue::
  end
end

function M.UpdatePushLaneDesires()
  return {
    M.PUSH_LINES_DESIRE["PUSH_TOP_LINE_DESIRE"],
    M.PUSH_LINES_DESIRE["PUSH_MID_LINE_DESIRE"],
    M.PUSH_LINES_DESIRE["PUSH_BOT_LINE_DESIRE"]
  }
end

return M
