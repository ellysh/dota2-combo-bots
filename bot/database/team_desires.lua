
local M = {}

M.SKILL_BUILD = {

  ally_mega_creeps = {
    [1] = 0.2,
    [2] = 0.2,
    [3] = 0.2
  },

  ally_have_aegis = {
    [1] = 0.2,
    [2] = 0.2,
    [3] = 0.2
  },

  ally_have_cheese = {
    [1] = 0.1,
    [2] = 0.1,
    [3] = 0.1
  },

  top_lane_have_ally_towers = {
    [1] = nil,
    [2] = nil,
    [3] = nil
  },

  top_lane_have_ally_barraks = {
    [1] = nil,
    [2] = nil,
    [3] = nil
  },

  max_kills_enemy_hero_alive = {
    [1] = -0.2,
    [2] = -0.2,
    [3] = -0.2
  },

  max_kills_ally_hero_alive = {
    [1] = 0.2,
    [2] = 0.2,
    [3] = 0.2
  },

  max_kills_enemy_hero_has_ult = {
    [1] = nil,
    [2] = nil,
    [3] = nil
  },

  max_kills_ally_hero_has_ult = {
    [1] = nil,
    [2] = nil,
    [3] = nil
  },

  max_kills_enemy_hero_has_bkb = {
    [1] = nil,
    [2] = nil,
    [3] = nil
  },

  max_kills_ally_hero_has_bkb = {
    [1] = nil,
    [2] = nil,
    [3] = nil
  },

}

return M
