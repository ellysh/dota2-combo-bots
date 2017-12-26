local logger = require(
  GetScriptDirectory() .."/utility/logger")

local M = {}

function M.low_hp_enemy_hero_to_kill()
  -- TODO: Implement this function
  return BOT_ACTION_DESIRE_HIGH, {0, 0}
end

return M
