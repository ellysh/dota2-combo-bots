local BotHeroes = {
  "npc_dota_hero_juggernaut",
  "npc_dota_hero_crystal_maiden",
  "npc_dota_hero_warlock",
  "npc_dota_hero_skeleton_king",
  --"npc_dota_hero_ursa",
  "npc_dota_hero_shadow_shaman"
};

function Think()
  local IDs = GetTeamPlayers(GetTeam());
  for i,id in pairs(IDs) do
    if IsPlayerBot(id) then
      SelectHero(id, BotHeroes[i]);
    end
  end
end

function UpdateLaneAssignments()
  if ( GetTeam() == TEAM_RADIANT ) then
    return {
      [1] = LANE_TOP,
      [2] = LANE_TOP,
      [3] = LANE_MID,
      [4] = LANE_BOT,
      [5] = LANE_BOT,
    };
  elseif ( GetTeam() == TEAM_DIRE ) then
    return {
      [1] = LANE_BOT,
      [2] = LANE_BOT,
      [3] = LANE_MID,
      [4] = LANE_TOP,
      [5] = LANE_TOP,
    };
  end
end
