
local M = {}

M.PLAYER_DESIRES = {

  have_low_hp = {
    PUSH_TOP_LINE_DESIRE = {-10, 0},
    PUSH_MID_LINE_DESIRE = {-10, 0},
    PUSH_BOT_LINE_DESIRE = {-10, 0}
  },

  player_on_top = {
    PUSH_TOP_LINE_DESIRE = {5, 0},
    PUSH_MID_LINE_DESIRE = {-5, 0},
    PUSH_BOT_LINE_DESIRE = {-5, 0}
  },

  player_on_mid = {
    PUSH_TOP_LINE_DESIRE = {-5, 0},
    PUSH_MID_LINE_DESIRE = {5, 0},
    PUSH_BOT_LINE_DESIRE = {-5, 0}
  },

  player_on_bot = {
    PUSH_TOP_LINE_DESIRE = {-5, 0},
    PUSH_MID_LINE_DESIRE = {-5, 0},
    PUSH_BOT_LINE_DESIRE = {5, 0}
  },

  have_tp_scroll_or_travel_boots = {
    PUSH_TOP_LINE_DESIRE = {5, -5},
    PUSH_MID_LINE_DESIRE = {5, -5},
    PUSH_BOT_LINE_DESIRE = {5, -5}
  },

}

return M
