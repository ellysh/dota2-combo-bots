
local M = {}

M.PLAYER_DESIRES = {

  has_low_hp = {
    BOT_MODE_PUSH_TOWER_TOP = {-10, 0},
    BOT_MODE_PUSH_TOWER_MID = {-10, 0},
    BOT_MODE_PUSH_TOWER_BOT = {-10, 0},
    BOT_MODE_RETREAT = {85, 0}
  },

  player_on_top = {
    BOT_MODE_PUSH_TOWER_TOP = {5, 0},
    BOT_MODE_PUSH_TOWER_MID = {-5, 0},
    BOT_MODE_PUSH_TOWER_BOT = {-5, 0},
    BOT_MODE_RETREAT = {0, 0}
  },

  player_on_mid = {
    BOT_MODE_PUSH_TOWER_TOP = {-5, 0},
    BOT_MODE_PUSH_TOWER_MID = {5, 0},
    BOT_MODE_PUSH_TOWER_BOT = {-5, 0},
    BOT_MODE_RETREAT = {0, 0}
  },

  player_on_bot = {
    BOT_MODE_PUSH_TOWER_TOP = {-5, 0},
    BOT_MODE_PUSH_TOWER_MID = {-5, 0},
    BOT_MODE_PUSH_TOWER_BOT = {5, 0},
    BOT_MODE_RETREAT = {0, 0}
  },

  has_tp_scroll_or_travel_boots = {
    BOT_MODE_PUSH_TOWER_TOP = {5, -5},
    BOT_MODE_PUSH_TOWER_MID = {5, -5},
    BOT_MODE_PUSH_TOWER_BOT = {5, -5},
    BOT_MODE_RETREAT = {0, 0}
  },

  has_buyback = {
    BOT_MODE_PUSH_TOWER_TOP = {0, -5},
    BOT_MODE_PUSH_TOWER_MID = {0, -5},
    BOT_MODE_PUSH_TOWER_BOT = {0, -5},
    BOT_MODE_RETREAT = {0, 0}
  },

  more_enemy_heroes_around_then_ally = {
    BOT_MODE_PUSH_TOWER_TOP = {-10, 0},
    BOT_MODE_PUSH_TOWER_MID = {-10, 0},
    BOT_MODE_PUSH_TOWER_BOT = {-10, 0},
    BOT_MODE_RETREAT = {80, 0}
  },

  is_shrine_healing_and_no_enemy = {
    BOT_MODE_PUSH_TOWER_TOP = {0, 0},
    BOT_MODE_PUSH_TOWER_MID = {0, 0},
    BOT_MODE_PUSH_TOWER_BOT = {0, 0},
    BOT_MODE_RETREAT = {76, 0}
  },

  has_not_full_hp_mp_and_near_fountain = {
    BOT_MODE_PUSH_TOWER_TOP = {-10, 0},
    BOT_MODE_PUSH_TOWER_MID = {-10, 0},
    BOT_MODE_PUSH_TOWER_BOT = {-10, 0},
    BOT_MODE_RETREAT = {76, 0}
  },

}

return M
