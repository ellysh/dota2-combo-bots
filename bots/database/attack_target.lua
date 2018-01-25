
local M = {}

M.ATTACK_TARGET = {

  max_kills_enemy_hero = {
      BOT_MODE_ROAM = 90,
      BOT_MODE_TEAM_ROAM = 90,
      BOT_MODE_PUSH_TOWER = 90,
      BOT_MODE_ATTACK = 90,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 0,
      BOT_MODE_DEFEND_TOWER = 90,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 90
  },

  max_estimated_damage_enemy_hero = {
      BOT_MODE_ROAM = 80,
      BOT_MODE_TEAM_ROAM = 80,
      BOT_MODE_PUSH_TOWER = 80,
      BOT_MODE_ATTACK = 80,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 0,
      BOT_MODE_DEFEND_TOWER = 80,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 80
  },

  max_hp_creep = {
      BOT_MODE_ROAM = 0,
      BOT_MODE_TEAM_ROAM = 0,
      BOT_MODE_PUSH_TOWER = 10,
      BOT_MODE_ATTACK = 10,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 90,
      BOT_MODE_FARM = 90,
      BOT_MODE_DEFEND_TOWER = 10,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

  last_hit_creep = {
      BOT_MODE_ROAM = 0,
      BOT_MODE_TEAM_ROAM = 0,
      BOT_MODE_PUSH_TOWER = 60,
      BOT_MODE_ATTACK = 60,
      BOT_MODE_LANING = 50,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 10,
      BOT_MODE_DEFEND_TOWER = 50,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

  min_hp_enemy_building = {
      BOT_MODE_ROAM = 0,
      BOT_MODE_TEAM_ROAM = 0,
      BOT_MODE_PUSH_TOWER = 70,
      BOT_MODE_ATTACK = 70,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 0,
      BOT_MODE_DEFEND_TOWER = 0,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

}

return M
