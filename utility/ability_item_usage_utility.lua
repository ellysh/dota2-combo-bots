local M = {};

local cache1 = {};

local function GetLastValues(key, value)
  if cache1[key] == nil then
    cache1[key] = {
      {value, DotaTime()},
      {value, DotaTime()},
      {value, DotaTime()},
      {value, DotaTime()},
      {value, DotaTime()},
      {value, DotaTime()},
      {value, DotaTime()},
      {value, DotaTime()},
      {value, DotaTime()},
      {value, DotaTime()},
    };
  end

  if DotaTime() - cache1[key][1][2] >= 1 then
    table.remove(cache1[key])
    table.insert(cache1[key], 1, {value, DotaTime()})
  end

  return cache1[key];
end

local function GetOutermostTower(team, lane)

  if lane == LANE_TOP then
    if GetTower(team, TOWER_TOP_1) ~= nil then
      return GetTower(team, TOWER_TOP_1);
    end
    if GetTower(team, TOWER_TOP_2) ~= nil then
      return GetTower(team, TOWER_TOP_2);
    end
    if GetTower(team, TOWER_TOP_3) ~= nil then
      return GetTower(team, TOWER_TOP_3);
    end
  end

  if lane == LANE_MID then
    if GetTower(team, TOWER_MID_1) ~= nil then
      return GetTower(team, TOWER_MID_1);
    end
    if GetTower(team, TOWER_MID_2) ~= nil then
      return GetTower(team, TOWER_MID_2);
    end
    if GetTower(team, TOWER_MID_3) ~= nil then
      return GetTower(team, TOWER_MID_3);
    end
    if GetTower(team, TOWER_BASE_1) ~= nil then
      return GetTower(team, TOWER_BASE_1);
    end
    if GetTower(team, TOWER_BASE_2) ~= nil then
      return GetTower(team, TOWER_BASE_2);
    end
  end

  if lane == LANE_BOT then
    if GetTower(team, TOWER_BOT_1) ~= nil then
      return GetTower(team, TOWER_BOT_1);
    end
    if GetTower(team, TOWER_BOT_2) ~= nil then
      return GetTower(team, TOWER_BOT_2);
    end
    if GetTower(team, TOWER_BOT_3) ~= nil then
      return GetTower(team, TOWER_BOT_3);
    end
  end

  return GetAncient(team);
end

local function UseGlyph(tower)
  if tower == nil then return end

  local recentValues = GetLastValues('Health:' .. tower:GetUnitName(), tower:GetHealth());
  if recentValues[5][1] - recentValues[1][1] > tower:GetHealth() * 0.5 and
    GetGlyphCooldown() == 0 then
      GetBot():ActionImmediate_Glyph();
  end
end

function M.UseGlyph()
  UseGlyph(GetOutermostTower(GetTeam(), LANE_TOP));
  UseGlyph(GetOutermostTower(GetTeam(), LANE_MID));
  UseGlyph(GetOutermostTower(GetTeam(), LANE_BOT));
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
    return npcBot:ActionPush_UseAbilityOnLocation(
      ability,
      target.targetloc);
  end

  local towers = npcBot:GetNearbyTowers(castRange, true);
  if #towers > 0 then
    target = towers[1]:GetLocation();
    return npcBot:ActionPush_UseAbilityOnLocation(ability, target);
  end

  local barracks = npcBot:GetNearbyBarracks(castRange, true);
  if #barracks > 0 then
    target = barracks[1]:GetLocation();
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
  local target = GetHeroWith(
    npcBot,
    'max',
    'GetRawOffensivePower',
    castRange,
    true);

  if target ~= nil then
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
  local target = GetHeroWith(
    npcBot,
    'max',
    'GetRawOffensivePower',
    castRange,
    true);

  if target ~= nil then
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

  target = GetHeroWith(
    npcBot,
    'min',
    'GetHealth',
    castRange,
    true);

  if target ~= nil and targt:GetHealth() <= ability:GetAbilityDamage() then
      return npcBot:Action_UseAbilityOnEntity(ability, target);
  end
end

return M;
