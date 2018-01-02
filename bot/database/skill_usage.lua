
local M = {}

local algorithms = require(
  GetScriptDirectory() .."/utility/ability_usage_algorithms")

M.SKILL_USAGE = {

  crystal_maiden_crystal_nova = {
      any_mode = algorithms["low_hp_enemy_hero_to_kill"],
      team_fight = algorithms["nil"],
      BOT_MODE_ROAM = algorithms["any_enemy_hero_in_range"],
      BOT_MODE_TEAM_ROAM = algorithms["any_enemy_hero_in_range"],
      BOT_MODE_PUSH_TOWER = algorithms["four_and_more_creeps"],
      BOT_MODE_ATTACK = algorithms["any_enemy_hero_in_range"],
      BOT_MODE_LANING = algorithms["three_and_more_creeps"],
      BOT_MODE_FARM = algorithms["three_and_more_creeps"],
      BOT_MODE_DEFEND_TOWER = algorithms["four_and_more_creeps"],
      BOT_MODE_RETREAT = algorithms["last_attacked_enemy_hero"],
      BOT_MODE_DEFEND_ALLY = algorithms["any_enemy_hero_in_range"]
  },

  crystal_maiden_frostbite = {
      any_mode = algorithms["channeling_enemy_hero"],
      team_fight = algorithms["strongest_enemy_hero"],
      BOT_MODE_ROAM = algorithms["strongest_enemy_hero"],
      BOT_MODE_TEAM_ROAM = algorithms["strongest_enemy_hero"],
      BOT_MODE_PUSH_TOWER = algorithms["strongest_enemy_hero"],
      BOT_MODE_ATTACK = algorithms["strongest_enemy_hero"],
      BOT_MODE_LANING = algorithms["low_hp_enemy_hero"],
      BOT_MODE_FARM = algorithms["strongest_creep"],
      BOT_MODE_DEFEND_TOWER = algorithms["strongest_enemy_hero"],
      BOT_MODE_RETREAT = algorithms["last_attacked_enemy_hero"],
      BOT_MODE_DEFEND_ALLY = algorithms["any_enemy_hero_in_range"]
  },

  crystal_maiden_freezing_field = {
      any_mode = algorithms["nil"],
      team_fight = algorithms["three_and_more_enemy_hero"],
      BOT_MODE_ROAM = algorithms["nil"],
      BOT_MODE_TEAM_ROAM = algorithms["nil"],
      BOT_MODE_PUSH_TOWER = algorithms["nil"],
      BOT_MODE_ATTACK = algorithms["nil"],
      BOT_MODE_LANING = algorithms["nil"],
      BOT_MODE_FARM = algorithms["nil"],
      BOT_MODE_DEFEND_TOWER = algorithms["nil"],
      BOT_MODE_RETREAT = algorithms["nil"],
      BOT_MODE_DEFEND_ALLY = algorithms["nil"]
  },

}

return M
