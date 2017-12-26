
local M = {}

M.SKILL_USAGE = {

  crystal_maiden_crystal_nova = {
      any_mode = low_hp_enemy_hero_to_kill,
      team_fight = nil,
      BOT_MODE_ROAM = any_enemy_hero_in_range,
      BOT_MODE_PUSH_TOWER = four_and_more_creeps,
      BOT_MODE_ATTACK = any_enemy_hero_in_range,
      BOT_MODE_LANING = two_and_more_creeps,
      BOT_MODE_FARM = three_and_more_creeps,
      BOT_MODE_DEFEND_TOWER = four_and_more_creeps,
      BOT_MODE_RETREAT = last_attacked_enemy_hero,
      BOT_MODE_DEFEND_ALLY = any_enemy_hero_in_range
  },

  crystal_maiden_frostbite = {
      any_mode = channeling_enemy_hero,
      team_fight = strongest_enemy_hero,
      BOT_MODE_ROAM = strongest_enemy_hero,
      BOT_MODE_PUSH_TOWER = strongest_enemy_hero,
      BOT_MODE_ATTACK = strongest_enemy_hero,
      BOT_MODE_LANING = low_hp_enemy_hero,
      BOT_MODE_FARM = strongest_creep,
      BOT_MODE_DEFEND_TOWER = strongest_enemy_hero,
      BOT_MODE_RETREAT = last_attacked_enemy_hero,
      BOT_MODE_DEFEND_ALLY = any_enemy_hero_in_range
  },

  crystal_maiden_freezing_field = {
      any_mode = nil,
      team_fight = three_and_more_enemy_hero,
      BOT_MODE_ROAM = nil,
      BOT_MODE_PUSH_TOWER = nil,
      BOT_MODE_ATTACK = nil,
      BOT_MODE_LANING = nil,
      BOT_MODE_FARM = nil,
      BOT_MODE_DEFEND_TOWER = nil,
      BOT_MODE_RETREAT = nil,
      BOT_MODE_DEFEND_ALLY = nil
  },

}

return M
