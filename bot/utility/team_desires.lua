local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local team_desires = require(
  GetScriptDirectory() .."/database/team_desires")

local M = {}

function M.ally_mega_creeps()
  -- TODO: Implement this algorithm
  return false
end

function M.ally_have_aegis()
  -- TODO: Implement this algorithm
  return false
end

function M.ally_have_cheese()
  -- TODO: Implement this algorithm
  return false
end

function M.max_kills_enemy_hero_alive()
  -- TODO: Implement this algorithm
  return false
end

function M.max_kills_ally_hero_alive()
  -- TODO: Implement this algorithm
  return false
end

M.PUSH_LINES_DESIRE = {
  0.0,
  0.0,
  0.0
}

function M.TeamThink()
  for algorithm, desires in functions.spairs(team_desires.TEAM_DESIRES) do
    if M[algorithm] == nil then goto continue end

    local is_succeed = M[algorithm]()

    if is_succeed then
      PUSH_LINES_DESIRE[1] = PUSH_LINES_DESIRE[1] + desires[1]
      PUSH_LINES_DESIRE[2] = PUSH_LINES_DESIRE[2] + desires[2]
      PUSH_LINES_DESIRE[3] = PUSH_LINES_DESIRE[3] + desires[3]
    else
    end
    ::continue::
  end

end

return M
