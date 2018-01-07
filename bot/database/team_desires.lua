
local M = {}

M.TEAM_DESIRES = {

  ally_mega_creeps = {
    PUSH_TOP_LINE_DESIRE = {0.2, 0},
    PUSH_MID_LINE_DESIRE = {0.2, 0},
    PUSH_BOT_LINE_DESIRE = {0.2, 0}
  },

  ally_have_aegis = {
    PUSH_TOP_LINE_DESIRE = {0.2, 0},
    PUSH_MID_LINE_DESIRE = {0.2, 0},
    PUSH_BOT_LINE_DESIRE = {0.2, 0}
  },

  ally_have_cheese = {
    PUSH_TOP_LINE_DESIRE = {0.1, 0},
    PUSH_MID_LINE_DESIRE = {0.1, 0},
    PUSH_BOT_LINE_DESIRE = {0.1, 0}
  },

  max_kills_enemy_hero_alive = {
    PUSH_TOP_LINE_DESIRE = {-0.1, 0.2},
    PUSH_MID_LINE_DESIRE = {-0.1, 0.2},
    PUSH_BOT_LINE_DESIRE = {-0.2, 0.2}
  },

  max_kills_ally_hero_alive = {
    PUSH_TOP_LINE_DESIRE = {0.2, -0.2},
    PUSH_MID_LINE_DESIRE = {0.2, -0.2},
    PUSH_BOT_LINE_DESIRE = {0.2, -0.2}
  },

  time_is_more_5_minutes = {
    PUSH_TOP_LINE_DESIRE = {0.4, -0.2},
    PUSH_MID_LINE_DESIRE = {0.4, -0.2},
    PUSH_BOT_LINE_DESIRE = {0.4, -0.2}
  },

  time_is_more_15_minutes = {
    PUSH_TOP_LINE_DESIRE = {0.2, 0},
    PUSH_MID_LINE_DESIRE = {0.2, 0},
    PUSH_BOT_LINE_DESIRE = {0.2, 0}
  },

  three_and_more_ally_heroes_on_top = {
    PUSH_TOP_LINE_DESIRE = {0.3, 0},
    PUSH_MID_LINE_DESIRE = {0, -0.1},
    PUSH_BOT_LINE_DESIRE = {0, -0.1}
  },

  three_and_more_ally_heroes_on_mid = {
    PUSH_TOP_LINE_DESIRE = {0, -0.1},
    PUSH_MID_LINE_DESIRE = {0.3, 0},
    PUSH_BOT_LINE_DESIRE = {0, -0.1}
  },

  three_and_more_ally_heroes_on_bot = {
    PUSH_TOP_LINE_DESIRE = {0, -0.1},
    PUSH_MID_LINE_DESIRE = {0, -0.1},
    PUSH_BOT_LINE_DESIRE = {0.3, 0}
  },

  three_and_more_enemy_heroes_on_top = {
    PUSH_TOP_LINE_DESIRE = {-0.2, 0},
    PUSH_MID_LINE_DESIRE = {0.2, 0},
    PUSH_BOT_LINE_DESIRE = {0.2, 0}
  },

  three_and_more_enemy_heroes_on_mid = {
    PUSH_TOP_LINE_DESIRE = {0.2, 0},
    PUSH_MID_LINE_DESIRE = {-0.2, 0},
    PUSH_BOT_LINE_DESIRE = {0.2, 0}
  },

  three_and_more_enemy_heroes_on_bot = {
    PUSH_TOP_LINE_DESIRE = {0.2, 0},
    PUSH_MID_LINE_DESIRE = {0.2, 0},
    PUSH_BOT_LINE_DESIRE = {-0.2, 0}
  },

  more_ally_heroes_alive_then_enemy = {
    PUSH_TOP_LINE_DESIRE = {0.2, 0},
    PUSH_MID_LINE_DESIRE = {0.2, 0},
    PUSH_BOT_LINE_DESIRE = {-0.2, 0}
  },

}

return M
