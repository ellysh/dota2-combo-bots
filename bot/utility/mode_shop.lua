local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

function M.GetDesire(is_shop_mode, shop_distance)

  local npc_bot = GetBot();

  if functions.IsBotBusy(npc_bot)
    or not is_shop_mode
    or npc_bot:WasRecentlyDamagedByAnyHero(5.0) then

    return 0
  end

  local walk_radius = constants.SHOP_WALK_RADIUS

  if walk_radius < shop_distance then return 0 end

  return 100 - ((shop_distance * 100) / walk_radius)
end

return M
