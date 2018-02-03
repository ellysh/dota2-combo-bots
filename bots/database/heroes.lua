
local M = {}

M.HEROES = {

  npc_dota_hero_crystal_maiden = {
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

  npc_dota_hero_juggernaut = {
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

  npc_dota_hero_ursa = {
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

  npc_dota_hero_shadow_shaman = {
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

  npc_dota_hero_drow_ranger = {
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

  npc_dota_hero_skeleton_king = {
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

  npc_dota_hero_sniper = {
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

  npc_dota_hero_lion = {
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

  npc_dota_hero_lich = {
    position = {5, 4},
    combo_heroes = {
      "npc_dota_hero_faceless_void",
      "npc_dota_hero_weaver",
      "npc_dota_hero_obsidian_destroyer"
    },
    counter_heroes = {
      "npc_dota_hero_sand_king",
      "npc_dota_hero_weaver",
      "npc_dota_hero_broodmother"
    }
  },

  npc_dota_hero_sven = {
    position = {1, 3},
    combo_heroes = {
      "npc_dota_hero_crystal_maiden",
      "npc_dota_hero_vengefulspirit",
      "npc_dota_hero_wisp"
    },
    counter_heroes = {
      "npc_dota_hero_razor",
      "npc_dota_hero_shredder",
      "npc_dota_hero_necrolyte"
    }
  },

  npc_dota_hero_phantom_assassin = {
    position = {1, 2},
    combo_heroes = {
      "npc_dota_hero_ogre_magi",
      "npc_dota_hero_omniknight",
      "npc_dota_hero_shadow_shaman"
    },
    counter_heroes = {
      "npc_dota_hero_axe",
      "npc_dota_hero_dragon_knight",
      "npc_dota_hero_sand_king"
    }
  },

  npc_dota_hero_chaos_knight = {
    position = {1, 2},
    combo_heroes = {
      "npc_dota_hero_crystal_maiden",
      "npc_dota_hero_wisp",
      "npc_dota_hero_rattletrap"
    },
    counter_heroes = {
      "npc_dota_hero_sven",
      "npc_dota_hero_medusa",
      "npc_dota_hero_bristleback"
    }
  },

  npc_dota_hero_phantom_lancer = {
    position = {1, 3},
    combo_heroes = {
      "npc_dota_hero_keeper_of_the_light",
      "npc_dota_hero_dazzle",
      "npc_dota_hero_lich"
    },
    counter_heroes = {
      "npc_dota_hero_axe",
      "npc_dota_hero_sand_king",
      "npc_dota_hero_sven"
    }
  },

  npc_dota_hero_warlock = {
    position = {2, 4},
    combo_heroes = {
      "npc_dota_hero_beastmaster",
      "npc_dota_hero_lycan",
      "npc_dota_hero_abaddon"
    },
    counter_heroes = {
      "npc_dota_hero_antimage",
      "npc_dota_hero_lycan",
      "npc_dota_hero_abaddon"
    }
  },

}

return M
