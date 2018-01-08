local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local team_desires_algorithms = require(
  GetScriptDirectory() .."/utility/team_desires_algorithms")

local team_desires = require(
  GetScriptDirectory() .."/database/team_desires")

local M = {}

function M.Think()
  local result = {}

  for algorithm, desires in functions.spairs(team_desires.TEAM_DESIRES) do
    if team_desires_algorithms[algorithm] == nil then goto continue end

    local desire_index = functions.ternary(
      team_desires_algorithms[algorithm](),
      1,
      2)

    for key, value in pairs(desires) do
      if result[key] ~= nil then
        result[key] = result[key] + value[desire_index]
      else
        result[key] = value[desire_index]
      end
    end
    ::continue::
  end

  return result
end

return M
