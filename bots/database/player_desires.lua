
local M = {}

M.PLAYER_DESIRES = {

  have_low_hp = {
    PUSH_TOP_LINE_DESIRE = {-0.1, 0},
    PUSH_MID_LINE_DESIRE = {-0.1, 0},
    PUSH_BOT_LINE_DESIRE = {-0.1, 0}
  },

  player_on_top = {
    PUSH_TOP_LINE_DESIRE = {0.05, 0},
    PUSH_MID_LINE_DESIRE = {-0.05, 0},
    PUSH_BOT_LINE_DESIRE = {-0.05, 0}
  },

  player_on_mid = {
    PUSH_TOP_LINE_DESIRE = {-0.05, 0},
    PUSH_MID_LINE_DESIRE = {0.05, 0},
    PUSH_BOT_LINE_DESIRE = {-0.05, 0}
  },

  player_on_bot = {
    PUSH_TOP_LINE_DESIRE = {-0.05, 0},
    PUSH_MID_LINE_DESIRE = {-0.05, 0},
    PUSH_BOT_LINE_DESIRE = {0.05, 0}
  },

  have_tp_scroll_or_travel_boots = {
    PUSH_TOP_LINE_DESIRE = {0.05, -0.05},
    PUSH_MID_LINE_DESIRE = {0.05, -0.05},
    PUSH_BOT_LINE_DESIRE = {0.05, -0.05}
  },

}

return M
