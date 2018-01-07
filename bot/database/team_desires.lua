
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
    PUSH_TOP_LINE_DESIRE = {-0.2, 0.2},
    PUSH_MID_LINE_DESIRE = {-0.2, 0.2},
    PUSH_BOT_LINE_DESIRE = {-0.2, 0.2}
  },

  max_kills_ally_hero_alive = {
    PUSH_TOP_LINE_DESIRE = {0.2, -0.2},
    PUSH_MID_LINE_DESIRE = {0.2, -0.2},
    PUSH_BOT_LINE_DESIRE = {0.2, -0.2}
  },

  time_is_less_5_minutes = {
    PUSH_TOP_LINE_DESIRE = {0, -0.2},
    PUSH_MID_LINE_DESIRE = {0, -0.2},
    PUSH_BOT_LINE_DESIRE = {0, -0.2}
  },

}

return M
