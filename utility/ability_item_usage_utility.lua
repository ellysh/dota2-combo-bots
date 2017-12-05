local M = {};

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

return M;
