local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local team_desires = require(
  GetScriptDirectory() .."/database/team_desires")

local M = {}

function M.ally_mega_creeps()
  local enemy_team = GetOpposingTeam()

  for i = 1,6,1 do
    local barrack = GetBarracks(enemy_team, i)

    if barrack ~= nil
      and not barrack:IsNull()
      and barrack:IsAlive() then

      return false
    end
  end

  return true
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
  PUSH_TOP_LINE_DESIRE = 0.0,
  PUSH_MID_LINE_DESIRE = 0.0,
  PUSH_BOT_LINE_DESIRE = 0.0
}

function M.TeamThink()
  for algorithm, desires in functions.spairs(team_desires.TEAM_DESIRES) do
    if M[algorithm] == nil then goto continue end

    local desire_index = functions.ternary(M[algorithm](), 1, 2)

    if is_succeed then
      for name, value in pairs(desires) do
        M.PUSH_LINES_DESIRE[name] =
          M.PUSH_LINES_DESIRE[name] + value[desire_index]
      end
    else
    end
    ::continue::
  end

end

return M
