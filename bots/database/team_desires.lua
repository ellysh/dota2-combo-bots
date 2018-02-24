
local M = {}

M.TEAM_DESIRES = {

  all_enemy_team_dead = {
    BOT_MODE_PUSH_TOWER_TOP = {40, 0},
    BOT_MODE_PUSH_TOWER_MID = {40, 0},
    BOT_MODE_PUSH_TOWER_BOT = {40, 0},
    BOT_MODE_TEAM_ROAM = {-100, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {-20, 0},
    BOT_MODE_DEFEND_TOWER_MID = {-20, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {-20, 0},
  },

  ally_has_aegis = {
    BOT_MODE_PUSH_TOWER_TOP = {20, 0},
    BOT_MODE_PUSH_TOWER_MID = {20, 0},
    BOT_MODE_PUSH_TOWER_BOT = {20, 0},
    BOT_MODE_TEAM_ROAM = {20, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  ally_has_cheese = {
    BOT_MODE_PUSH_TOWER_TOP = {10, 0},
    BOT_MODE_PUSH_TOWER_MID = {10, 0},
    BOT_MODE_PUSH_TOWER_BOT = {10, 0},
    BOT_MODE_TEAM_ROAM = {10, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  ally_mega_creeps = {
    BOT_MODE_PUSH_TOWER_TOP = {20, 0},
    BOT_MODE_PUSH_TOWER_MID = {20, 0},
    BOT_MODE_PUSH_TOWER_BOT = {20, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {-10, 0},
    BOT_MODE_DEFEND_TOWER_MID = {-10, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {-10, 0},
  },

  enemy_hero_was_seen = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_TEAM_ROAM = {0, -100},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  is_night = {
    BOT_MODE_PUSH_TOWER_TOP = {-10, 0},
    BOT_MODE_PUSH_TOWER_MID = {-10, 0},
    BOT_MODE_PUSH_TOWER_BOT = {-10, 0},
    BOT_MODE_TEAM_ROAM = {10, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  max_kills_ally_hero_alive = {
    BOT_MODE_PUSH_TOWER_TOP = {10, -20},
    BOT_MODE_PUSH_TOWER_MID = {10, -20},
    BOT_MODE_PUSH_TOWER_BOT = {10, -20},
    BOT_MODE_TEAM_ROAM = {20, -30},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  max_kills_enemy_hero_alive = {
    BOT_MODE_PUSH_TOWER_TOP = {-10, 20},
    BOT_MODE_PUSH_TOWER_MID = {-10, 20},
    BOT_MODE_PUSH_TOWER_BOT = {-10, 20},
    BOT_MODE_TEAM_ROAM = {20, -10},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  more_ally_heroes_alive_then_enemy = {
    BOT_MODE_PUSH_TOWER_TOP = {20, -20},
    BOT_MODE_PUSH_TOWER_MID = {20, -20},
    BOT_MODE_PUSH_TOWER_BOT = {20, -20},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  more_ally_heroes_on_bot_then_enemy = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {20, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 20},
  },

  more_ally_heroes_on_mid_then_enemy = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {20, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 20},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  more_ally_heroes_on_top_then_enemy = {
    BOT_MODE_PUSH_TOWER_TOP = {20, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 20},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  no_enemy_heroes_on_bot = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {20, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  no_enemy_heroes_on_mid = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {20, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  no_enemy_heroes_on_top = {
    BOT_MODE_PUSH_TOWER_TOP = {20, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  time_is_more_3_minutes = {
    BOT_MODE_PUSH_TOWER_TOP = {10, -30},
    BOT_MODE_PUSH_TOWER_MID = {10, -30},
    BOT_MODE_PUSH_TOWER_BOT = {10, -30},
    BOT_MODE_TEAM_ROAM = {10, -30},
    BOT_MODE_DEFEND_TOWER_TOP = {0, -30},
    BOT_MODE_DEFEND_TOWER_MID = {0, -30},
    BOT_MODE_DEFEND_TOWER_BOT = {0, -30},
  },

  is_bot_building_focused_by_enemies = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {65, 0},
  },

  is_mid_building_focused_by_enemies = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {65, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  is_top_building_focused_by_enemies = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {65, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  three_enemy_heroes_on_bot = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {60, 0},
  },

  three_enemy_heroes_on_mid = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {0, 0},
    BOT_MODE_DEFEND_TOWER_MID = {60, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

  three_enemy_heroes_on_top = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_TEAM_ROAM = {0, 0},
    BOT_MODE_DEFEND_TOWER_TOP = {60, 0},
    BOT_MODE_DEFEND_TOWER_MID = {0, 0},
    BOT_MODE_DEFEND_TOWER_BOT = {0, 0},
  },

}

return M
