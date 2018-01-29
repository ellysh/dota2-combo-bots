
local M = {}

M.TEAM_DESIRES = {

  ally_mega_creeps = {
    PUSH_TOP_LINE_DESIRE = {10, 0},
    PUSH_MID_LINE_DESIRE = {10, 0},
    PUSH_BOT_LINE_DESIRE = {10, 0}
  },

  ally_has_aegis = {
    PUSH_TOP_LINE_DESIRE = {10, 0},
    PUSH_MID_LINE_DESIRE = {10, 0},
    PUSH_BOT_LINE_DESIRE = {10, 0}
  },

  ally_has_cheese = {
    PUSH_TOP_LINE_DESIRE = {5, 0},
    PUSH_MID_LINE_DESIRE = {5, 0},
    PUSH_BOT_LINE_DESIRE = {5, 0}
  },

  max_kills_enemy_hero_alive = {
    PUSH_TOP_LINE_DESIRE = {-20, 30},
    PUSH_MID_LINE_DESIRE = {-20, 30},
    PUSH_BOT_LINE_DESIRE = {-20, 30}
  },

  max_kills_ally_hero_alive = {
    PUSH_TOP_LINE_DESIRE = {10, -20},
    PUSH_MID_LINE_DESIRE = {10, -20},
    PUSH_BOT_LINE_DESIRE = {10, -20}
  },

  time_is_more_5_minutes = {
    PUSH_TOP_LINE_DESIRE = {10, -30},
    PUSH_MID_LINE_DESIRE = {10, -30},
    PUSH_BOT_LINE_DESIRE = {10, -30}
  },

  time_is_more_15_minutes = {
    PUSH_TOP_LINE_DESIRE = {10, 0},
    PUSH_MID_LINE_DESIRE = {10, 0},
    PUSH_BOT_LINE_DESIRE = {10, 0}
  },

  three_and_more_ally_heroes_on_top = {
    PUSH_TOP_LINE_DESIRE = {20, 0},
    PUSH_MID_LINE_DESIRE = {0, 0},
    PUSH_BOT_LINE_DESIRE = {0, 0}
  },

  three_and_more_ally_heroes_on_mid = {
    PUSH_TOP_LINE_DESIRE = {0, 0},
    PUSH_MID_LINE_DESIRE = {20, 0},
    PUSH_BOT_LINE_DESIRE = {0, 0}
  },

  three_and_more_ally_heroes_on_bot = {
    PUSH_TOP_LINE_DESIRE = {0, 0},
    PUSH_MID_LINE_DESIRE = {0, 0},
    PUSH_BOT_LINE_DESIRE = {20, 0}
  },

  three_and_more_enemy_heroes_on_top = {
    PUSH_TOP_LINE_DESIRE = {-20, 0},
    PUSH_MID_LINE_DESIRE = {0, 0},
    PUSH_BOT_LINE_DESIRE = {0, 0}
  },

  three_and_more_enemy_heroes_on_mid = {
    PUSH_TOP_LINE_DESIRE = {0, 0},
    PUSH_MID_LINE_DESIRE = {-20, 0},
    PUSH_BOT_LINE_DESIRE = {0, 0}
  },

  three_and_more_enemy_heroes_on_bot = {
    PUSH_TOP_LINE_DESIRE = {0, 0},
    PUSH_MID_LINE_DESIRE = {0, 0},
    PUSH_BOT_LINE_DESIRE = {-20, 0}
  },

  more_ally_heroes_alive_then_enemy = {
    PUSH_TOP_LINE_DESIRE = {20, -30},
    PUSH_MID_LINE_DESIRE = {20, -30},
    PUSH_BOT_LINE_DESIRE = {20, -30}
  },

  no_enemy_heroes_on_top = {
    PUSH_TOP_LINE_DESIRE = {10, 0},
    PUSH_MID_LINE_DESIRE = {0, 0},
    PUSH_BOT_LINE_DESIRE = {0, 0}
  },

  no_enemy_heroes_on_mid = {
    PUSH_TOP_LINE_DESIRE = {0, 0},
    PUSH_MID_LINE_DESIRE = {10, 0},
    PUSH_BOT_LINE_DESIRE = {0, 0}
  },

  no_enemy_heroes_on_bot = {
    PUSH_TOP_LINE_DESIRE = {0, 0},
    PUSH_MID_LINE_DESIRE = {0, 0},
    PUSH_BOT_LINE_DESIRE = {10, 0}
  },

}

return M
