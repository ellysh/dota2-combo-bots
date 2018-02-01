
local M = {}

M.TEAM_DESIRES = {

  ally_mega_creeps = {
    BOT_MODE_PUSH_TOWER_TOP = {10, 0},
    BOT_MODE_PUSH_TOWER_MID = {10, 0},
    BOT_MODE_PUSH_TOWER_BOT = {10, 0}
  },

  ally_has_aegis = {
    BOT_MODE_PUSH_TOWER_TOP = {10, 0},
    BOT_MODE_PUSH_TOWER_MID = {10, 0},
    BOT_MODE_PUSH_TOWER_BOT = {10, 0}
  },

  ally_has_cheese = {
    BOT_MODE_PUSH_TOWER_TOP = {5, 0},
    BOT_MODE_PUSH_TOWER_MID = {5, 0},
    BOT_MODE_PUSH_TOWER_BOT = {5, 0}
  },

  max_kills_enemy_hero_alive = {
    BOT_MODE_PUSH_TOWER_TOP = {-20, 30},
    BOT_MODE_PUSH_TOWER_MID = {-20, 30},
    BOT_MODE_PUSH_TOWER_BOT = {-20, 30}
  },

  max_kills_ally_hero_alive = {
    BOT_MODE_PUSH_TOWER_TOP = {10, -20},
    BOT_MODE_PUSH_TOWER_MID = {10, -20},
    BOT_MODE_PUSH_TOWER_BOT = {10, -20}
  },

  time_is_more_5_minutes = {
    BOT_MODE_PUSH_TOWER_TOP = {10, -30},
    BOT_MODE_PUSH_TOWER_MID = {10, -30},
    BOT_MODE_PUSH_TOWER_BOT = {10, -30}
  },

  more_ally_heroes_alive_then_enemy = {
    BOT_MODE_PUSH_TOWER_TOP = {20, -20},
    BOT_MODE_PUSH_TOWER_MID = {20, -20},
    BOT_MODE_PUSH_TOWER_BOT = {20, -20}
  },

  no_enemy_heroes_on_top = {
    BOT_MODE_PUSH_TOWER_TOP = {10, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0}
  },

  no_enemy_heroes_on_mid = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {10, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0}
  },

  no_enemy_heroes_on_bot = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {10, 0}
  },

  more_ally_heroes_on_top_then_enemy = {
    BOT_MODE_PUSH_TOWER_TOP = {20, -20},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0}
  },

  more_ally_heroes_on_mid_then_enemy = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {20, -20},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0}
  },

  more_ally_heroes_on_bot_then_enemy = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {20, -20}
  },

}

return M
