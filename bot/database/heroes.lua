
local M = {}

M.HEROES = {

  {
    name = "npc_dota_hero_crystal_maiden",
    position = {4, 5},
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
    position = {1, 3},
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
    position = {3, 1},
    combo_heroes = {
      "npc_dota_hero_crystal_maiden",
      "npc_dota_hero_shadow_shaman",
      "npc_dota_hero_wisp"
    },
    counter_heroes = {
      "npc_dota_hero_razor",
      "npc_dota_hero_venomancer",
      "npc_dota_hero_phantom_lancer"
    }
  },

  {
    name = "npc_dota_hero_shadow_shaman",
    position = {5, 4},
    combo_heroes = {
      "npc_dota_hero_ursa",
      "npc_dota_hero_juggernaut",
      "npc_dota_hero_broodmother"
    },
    counter_heroes = {
      "npc_dota_hero_drow_ranger",
      "npc_dota_hero_phantom_lancer",
      "npc_dota_hero_terrorblade"
    }
  },

  {
    name = "npc_dota_hero_drow_ranger",
    position = {1, 2},
    combo_heroes = {
      "npc_dota_hero_vengefulspirit",
      "npc_dota_hero_visage",
      "npc_dota_hero_windrunner"
    },
    counter_heroes = {
      "npc_dota_hero_phantom_assassin",
      "npc_dota_hero_phantom_lancer",
      "npc_dota_hero_broodmother"
    }
  },

  {
    name = "npc_dota_hero_skeleton_king",
    position = {2, 3},
    combo_heroes = {
      "npc_dota_hero_vengefulspirit",
      "npc_dota_hero_lina",
      "npc_dota_hero_ursa"
    },
    counter_heroes = {
      "npc_dota_hero_phantom_lancer",
      "npc_dota_hero_undying",
      "npc_dota_hero_broodmother"
    }
  },

  {
    name = "npc_dota_hero_sniper",
    position = {2, 1},
    combo_heroes = {
      "npc_dota_hero_ogre_magi",
      "npc_dota_hero_skeleton_king",
      "npc_dota_hero_vengefulspirit"
    },
    counter_heroes = {
      "npc_dota_hero_phantom_assassin",
      "npc_dota_hero_rattletrap",
      "npc_dota_hero_centaur"
    }
  },

  {
    name = "npc_dota_hero_lion",
    position = {5, 4},
    combo_heroes = {
      "npc_dota_hero_lina",
      "npc_dota_hero_legion_commander",
      "npc_dota_hero_juggernaut"
    },
    counter_heroes = {
      "npc_dota_hero_vengefulspirit",
      "npc_dota_hero_centaur",
      "npc_dota_hero_tidehunter"
    }
  },

}

return M
