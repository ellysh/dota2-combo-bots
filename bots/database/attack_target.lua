
local M = {}

M.ATTACK_TARGET = {

  attacking_enemy_creep = {
      BOT_MODE_ROAM = 0,
      BOT_MODE_TEAM_ROAM = 0,
      BOT_MODE_PUSH_TOWER = 15,
      BOT_MODE_ATTACK = 15,
      BOT_MODE_NONE = 15,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 15,
      BOT_MODE_DEFEND_TOWER = 25,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

  attacking_enemy_hero = {
      BOT_MODE_ROAM = 50,
      BOT_MODE_TEAM_ROAM = 50,
      BOT_MODE_PUSH_TOWER = 65,
      BOT_MODE_ATTACK = 65,
      BOT_MODE_NONE = 65,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 60,
      BOT_MODE_FARM = 65,
      BOT_MODE_DEFEND_TOWER = 75,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

  last_hit_enemy_creep = {
      BOT_MODE_ROAM = 0,
      BOT_MODE_TEAM_ROAM = 0,
      BOT_MODE_PUSH_TOWER = 60,
      BOT_MODE_ATTACK = 60,
      BOT_MODE_NONE = 60,
      BOT_MODE_LANING = 50,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 50,
      BOT_MODE_DEFEND_TOWER = 50,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

  low_hp_enemy_building = {
      BOT_MODE_ROAM = 0,
      BOT_MODE_TEAM_ROAM = 0,
      BOT_MODE_PUSH_TOWER = 80,
      BOT_MODE_ATTACK = 80,
      BOT_MODE_NONE = 80,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 0,
      BOT_MODE_DEFEND_TOWER = 0,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

  low_hp_enemy_hero = {
      BOT_MODE_ROAM = 90,
      BOT_MODE_TEAM_ROAM = 90,
      BOT_MODE_PUSH_TOWER = 90,
      BOT_MODE_ATTACK = 90,
      BOT_MODE_NONE = 90,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 65,
      BOT_MODE_FARM = 0,
      BOT_MODE_DEFEND_TOWER = 90,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 90
  },

  max_hp_enemy_creep = {
      BOT_MODE_ROAM = 0,
      BOT_MODE_TEAM_ROAM = 0,
      BOT_MODE_PUSH_TOWER = 10,
      BOT_MODE_ATTACK = 10,
      BOT_MODE_NONE = 15,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 40,
      BOT_MODE_DEFEND_TOWER = 10,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

  max_hp_neutral_creep = {
      BOT_MODE_ROAM = 0,
      BOT_MODE_TEAM_ROAM = 0,
      BOT_MODE_PUSH_TOWER = 0,
      BOT_MODE_ATTACK = 10,
      BOT_MODE_NONE = 10,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 60,
      BOT_MODE_DEFEND_TOWER = 0,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

  max_kills_enemy_hero = {
      BOT_MODE_ROAM = 85,
      BOT_MODE_TEAM_ROAM = 85,
      BOT_MODE_PUSH_TOWER = 85,
      BOT_MODE_ATTACK = 85,
      BOT_MODE_NONE = 85,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 0,
      BOT_MODE_DEFEND_TOWER = 85,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 85
  },

  min_hp_enemy_building = {
      BOT_MODE_ROAM = 0,
      BOT_MODE_TEAM_ROAM = 0,
      BOT_MODE_PUSH_TOWER = 70,
      BOT_MODE_ATTACK = 70,
      BOT_MODE_NONE = 70,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 0,
      BOT_MODE_DEFEND_TOWER = 0,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

  assist_ally_hero = {
      BOT_MODE_ROAM = 87,
      BOT_MODE_TEAM_ROAM = 87,
      BOT_MODE_PUSH_TOWER = 87,
      BOT_MODE_ATTACK = 87,
      BOT_MODE_NONE = 87,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 0,
      BOT_MODE_DEFEND_TOWER = 87,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 87
  },

  roshan = {
      BOT_MODE_ROAM = 0,
      BOT_MODE_TEAM_ROAM = 0,
      BOT_MODE_PUSH_TOWER = 0,
      BOT_MODE_ATTACK = 0,
      BOT_MODE_NONE = 10,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 50,
      BOT_MODE_FARM = 0,
      BOT_MODE_DEFEND_TOWER = 0,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

  deny_ally_tower = {
      BOT_MODE_ROAM = 0,
      BOT_MODE_TEAM_ROAM = 0,
      BOT_MODE_PUSH_TOWER = 0,
      BOT_MODE_ATTACK = 80,
      BOT_MODE_NONE = 80,
      BOT_MODE_LANING = 0,
      BOT_MODE_ROSHAN = 0,
      BOT_MODE_FARM = 0,
      BOT_MODE_DEFEND_TOWER = 80,
      BOT_MODE_RETREAT = 0,
      BOT_MODE_DEFEND_ALLY = 0
  },

}

return M
