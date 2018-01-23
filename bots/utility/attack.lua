local functions = require(
  GetScriptDirectory() .."/utility/functions")

local attack_target = require(
  GetScriptDirectory() .."/database/attack_target")

local M = {}

function M.max_kills_enemy_hero(bot, radius)
  local enemy_heroes = GetEnemyHeroes(bot, radius)
  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    CompareMaxHeroKills,
    IsTargetable)

  if enemy_hero == nil then
    return false, nil end

  return true, enemy_hero
end

local function GetDesire(bot)
  -- TODO: Implement this function
  return 0
end

local function ChooseTarget(bot)
  local radius = bot:GetCurrentVisionRange()
  local targets = {}

  for _, algorithm in pairs(attack_target.ATTACK_TARGET) do
    local is_succeed, target = M[algorithm](bot, radius)

    if is_succeed then
      targets[target] = GetDesire(bot)
    end
  end

  return functions.GetElementWith(
    targets,
    function(t, a, b)
      return t[b] < t[a]
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
