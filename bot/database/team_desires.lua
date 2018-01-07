
local M = {}

M.TEAM_DESIRES = {

  ally_mega_creeps = {
    PUSH_TOP_LINE_DESIRE = 0.2,
    PUSH_MID_LINE_DESIRE = 0.2,
    PUSH_BOT_LINE_DESIRE = 0.2
  },

  ally_have_aegis = {
    PUSH_TOP_LINE_DESIRE = 0.2,
    PUSH_MID_LINE_DESIRE = 0.2,
    PUSH_BOT_LINE_DESIRE = 0.2
  },

  ally_have_cheese = {
    PUSH_TOP_LINE_DESIRE = 0.1,
    PUSH_MID_LINE_DESIRE = 0.1,
    PUSH_BOT_LINE_DESIRE = 0.1
  },

  top_lane_have_ally_towers = {
    PUSH_TOP_LINE_DESIRE = nil,
    PUSH_MID_LINE_DESIRE = nil,
    PUSH_BOT_LINE_DESIRE = nil
  },

  top_lane_have_ally_barraks = {
    PUSH_TOP_LINE_DESIRE = nil,
    PUSH_MID_LINE_DESIRE = nil,
    PUSH_BOT_LINE_DESIRE = nil
  },

  max_kills_enemy_hero_alive = {
    PUSH_TOP_LINE_DESIRE = -0.2,
    PUSH_MID_LINE_DESIRE = -0.2,
    PUSH_BOT_LINE_DESIRE = -0.2
  },

  max_kills_ally_hero_alive = {
    PUSH_TOP_LINE_DESIRE = 0.2,
    PUSH_MID_LINE_DESIRE = 0.2,
    PUSH_BOT_LINE_DESIRE = 0.2
  },

  max_kills_enemy_hero_has_ult = {
    PUSH_TOP_LINE_DESIRE = nil,
    PUSH_MID_LINE_DESIRE = nil,
    PUSH_BOT_LINE_DESIRE = nil
  },

  max_kills_ally_hero_has_ult = {
    PUSH_TOP_LINE_DESIRE = nil,
    PUSH_MID_LINE_DESIRE = nil,
    PUSH_BOT_LINE_DESIRE = nil
  },

  max_kills_enemy_hero_has_bkb = {
    PUSH_TOP_LINE_DESIRE = nil,
    PUSH_MID_LINE_DESIRE = nil,
    PUSH_BOT_LINE_DESIRE = nil
  },

  max_kills_ally_hero_has_bkb = {
    PUSH_TOP_LINE_DESIRE = nil,
    PUSH_MID_LINE_DESIRE = nil,
    PUSH_BOT_LINE_DESIRE = nil
  },

}

return M
