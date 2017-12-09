local logger = require(
    GetScriptDirectory() .."/utility/logger")

local M = {};

local function GetEnemiesNearLocation(loc, dist)
  if loc ==nil then return {}; end

  local enemies={}

  for _,enemy in pairs(GetUnitList(UNIT_LIST_ENEMY_HEROES)) do
    if(GetUnitToLocationDistance(enemy, loc) < dist)
    then
      table.insert(enemies,enemy)
    end
  end

  return enemies;
end

local Towers = {
    TOWER_TOP_1,
    TOWER_TOP_2,
    TOWER_TOP_3,
    TOWER_MID_1,
    TOWER_MID_2,
    TOWER_MID_3,
    TOWER_BOT_1,
    TOWER_BOT_2,
    TOWER_BOT_3,
    TOWER_BASE_1,
    TOWER_BASE_2
}

function M.UseGlyph(npcBot)
  if GetGlyphCooldown() > 0 then return end

  for i, buildingId in pairs(Towers) do
    local tower = GetTower(GetTeam(), buildingId)

    if tower == nil then goto continue end

    local tableNearbyEnemyHeroes = GetEnemiesNearLocation(
      tower:GetLocation(),
      700)

    if 200 <= tower:GetHealth() and tower:GetHealth() <=1000
        and 2 <= #tableNearbyEnemyHeroes then

      logger.Print("M.UseGlyph() - use glyph to " .. tower:GetUnitName() .. ". HP = " .. tower:GetHealth() .. " enemies = " .. #tableNearbyEnemyHeroes);

      npcBot:ActionImmediate_Glyph()
      break
    end

     ::continue::
  end
end

function M.GetHeroWith(npcBot, comparison, attr, radius, enemy)

  local heroes = npcBot:GetNearbyHeroes(radius, enemy, BOT_MODE_NONE);
  local hero = npcBot;
  local value = npcBot[attr](npcBot);

  if enemy then
    hero = nil;
    value = 10000;
  end

  if comparison == 'max' then
    value = 0;
  end

  if heroes == nil or #heroes == 0 then
    return hero, value;
  end

  for _, h in pairs(heroes) do

    if h ~= nil and h:IsAlive() then

      local valueToCompare = h[attr](h);
      local success = valueToCompare < value;

      if comparison == 'max' then
        success = valueToCompare > value;
      end

      if success then
        value = valueToCompare;
        hero = h;
      end

    end
  end

  return hero, value;

end

local function UseAbilityOnLocation(npcBot, ability, target)
  if target ~= nil and ability:IsFullyCastable() then
    return npcBot:ActionPush_UseAbilityOnLocation(ability, target);
  end
end

function M.UseWard(npcBot, ability_name)
  if npcBot:IsChanneling() or npcBot:IsUsingAbility() then
    return;
  end

  local ability = npcBot:GetAbilityByName(ability_name);

  if not ability:IsFullyCastable() then return end

  local castRange = ability:GetCastRange();
  local target = npcBot:FindAoELocation(
    true,
    true,
    npcBot:GetLocation(),
    castRange,
    400,        -- TODO: With Aghanim the wards radius became 875
    0,
    0)

  if target.count >= 2 then

    logger.Print("M.UseWard() - " .. npcBot:GetUnitName() .. " cast #1 " .. ability_name .. " to " .. target.targetloc);

    return npcBot:ActionPush_UseAbilityOnLocation(
      ability,
      target.targetloc);
  end

  local towers = npcBot:GetNearbyTowers(castRange, true);
  if #towers > 0 then
    target = towers[1]:GetLocation();

    logger.Print("M.UseWard() - " .. npcBot:GetUnitName() .. " cast #2 " .. ability_name .. " to " .. target:GetUnitName());

    return npcBot:ActionPush_UseAbilityOnLocation(ability, target);
  end

  local barracks = npcBot:GetNearbyBarracks(castRange, true);
  if #barracks > 0 then
    target = barracks[1]:GetLocation();

    logger.Print("M.UseWard() - " .. npcBot:GetUnitName() .. " cast #3 " .. ability_name .. " to " .. target:GetUnitName());

    return npcBot:ActionPush_UseAbilityOnLocation(ability, target);
  end
end

function M.UseChanneledSingleDisable(npcBot, ability_name)
  if npcBot:IsChanneling() or npcBot:IsUsingAbility() then
    return;
  end

  local ability = npcBot:GetAbilityByName(ability_name);

  if not ability:IsFullyCastable() then return end

  -- Check if an ally hero is near. He will attack the disabled enemy
  if #npcBot:GetNearbyHeroes(600, false, BOT_MODE_NONE) < 2 then return end

  local castRange = ability:GetCastRange();
  local target = M.GetHeroWith(
    npcBot,
    'max',
    'GetRawOffensivePower',
    castRange,
    true);

  if target ~= nil then

    logger.Print("M.UseChanneledSingleDisable() - " .. npcBot:GetUnitName() .. " cast " .. ability_name .. " to " .. target:GetUnitName());

    return npcBot:Action_UseAbilityOnEntity(ability, target);
  end
end

function M.UseSingleDisable(npcBot, ability_name)
  if npcBot:IsChanneling() or npcBot:IsUsingAbility() then
    return;
  end

  local ability = npcBot:GetAbilityByName(ability_name);

  if not ability:IsFullyCastable() then return end

  local castRange = ability:GetCastRange();
  local target = M.GetHeroWith(
    npcBot,
    'max',
    'GetRawOffensivePower',
    castRange,
    true);

  if target ~= nil then

    logger.Print("M.UseSingleDisable() - " .. npcBot:GetUnitName() .. " cast " .. ability_name .. " to " .. target:GetUnitName());

    return npcBot:Action_UseAbilityOnEntity(ability, target);
  end
end

function M.UseMultiNuke(npcBot, ability_name)
  if npcBot:IsChanneling() or npcBot:IsUsingAbility() then
    return;
  end

  local ability = npcBot:GetAbilityByName(ability_name);

  if not ability:IsFullyCastable() then return end

  local castRange = ability:GetCastRange();

  local target = npcBot:GetNearbyHeroes(castRange, true, BOT_MODE_NONE);

  if #target >= 2 then
      return npcBot:Action_UseAbilityOnEntity(ability, target[1]);
  end

  target = M.GetHeroWith(
    npcBot,
    'min',
    'GetHealth',
    castRange,
    true);

  if target ~= nil and targt:GetHealth() <= ability:GetAbilityDamage() then

    logger.Print("M.UseMultiNuke() - " .. npcBot:GetUnitName() .. " cast " .. ability_name .. " to " .. target:GetUnitName());

    return npcBot:Action_UseAbilityOnEntity(ability, target);
  end
end

return M;
