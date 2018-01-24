local functions = require(
  GetScriptDirectory() .."/utility/functions")

local attack_target = require(
  GetScriptDirectory() .."/database/attack_target")

local M = {}

function M.max_kills_enemy_hero(bot, radius)
  local enemy_heroes = bot:GetNearbyHeroes(radius, true, BOT_MODE_NONE)
  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    CompareMaxHeroKills,
    IsTargetable)

  if enemy_hero == nil then
    return false, nil end

  return true, enemy_hero
end

local function GetDesire(bot, mode_desires)
  for mode, desire in pairs(mode_desires) do
    if functions.IsBotModeMatch(bot, mode) then
      return desire end
  end
  return 0
end

local function ChooseTarget(bot)
  local radius = bot:GetCurrentVisionRange()
  local targets = {}

  for algorithm, mode_desires in pairs(attack_target.ATTACK_TARGET) do
    if M[algorithm] == nil then
      do goto continue end
    end

    local is_succeed, target = M[algorithm](bot, radius)

    if is_succeed then
      targets[GetDesire(bot, mode_desires)] = target
    end
    ::continue::
  end

  return functions.GetElementWith(
    targets,
    function(t, a, b)
      return b < a
    end)
end

function M.Attack(bot)
  local bot = GetBot()

  if functions.IsBotBusy(bot) then
    return end

  local target = ChooseTarget(bot)

  bot:Action_AttackUnit(target, false)
end

return M
