
local M = {}

M.HEROES = {

  {
    name = "npc_dota_hero_crystal_maiden",
    position = {5, nil},
    combo_heroes = {
      "npc_dota_hero_juggernaut",
      "npc_dota_hero_sven",
      "npc_dota_hero_ursa"
    },
    counter_heroes = {
      "npc_dota_hero_elder_titan",
      "npc_dota_hero_earth_spirit",
      "npc_dota_hero_brewmaster"
    }
  },

  {
    name = "npc_dota_hero_juggernaut",
    position = {1, nil},
    combo_heroes = {
      "npc_dota_hero_crystal_maiden",
      "npc_dota_hero_shadow_shaman",
      "npc_dota_hero_venomancer"
    },
    counter_heroes = {
      "npc_dota_hero_ursa",
      "npc_dota_hero_razor",
      "npc_dota_hero_drow_ranger"
    }
  },

  {
    name = "npc_dota_hero_ursa",
    position = {3, nil},
    combo_heroes = {
      "npc_dota_hero_crystal_maiden",
      "npc_dota_hero_shadow_shaman",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_razor",
      "npc_dota_hero_venomancer",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_shadow_shaman",
    position = {4, 5},
    combo_heroes = {
      "npc_dota_hero_ursa",
      "npc_dota_hero_juggernaut",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_drow_ranger",
      "nil",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_drow_ranger",
    position = {2, nil},
    combo_heroes = {
      "npc_dota_hero_vengefulspirit",
      "npc_dota_hero_visage",
      "npc_dota_hero_windrunner"
    },
    counter_heroes = {
      "nil",
      "nil",
      "nil"
    }
  },

}

return M
