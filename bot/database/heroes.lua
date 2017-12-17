
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
    name = "npc_dota_hero_sven",
    position = {1, nil},
    combo_heroes = {
      "npc_dota_hero_crystal_maiden",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_razor",
      "npc_dota_hero_shredder",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_ursa",
    position = {1, nil},
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
    name = "npc_dota_hero_venomancer",
    position = {5, nil},
    combo_heroes = {
      "npc_dota_hero_juggernaut",
      "nil",
      "nil"
    },
    counter_heroes = {
      "nil",
      "nil",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_obsidian_destroyer",
    position = {2, nil},
    combo_heroes = {
      "npc_dota_hero_skywrath_mage",
      "npc_dota_hero_bristleback",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_death_prophet",
      "nil",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_death_prophet",
    position = {2, nil},
    combo_heroes = {
      "npc_dota_hero_faceless_void",
      "npc_dota_hero_nevermore",
      "nil"
    },
    counter_heroes = {
      "nil",
      "nil",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_queenofpain",
    position = {2, nil},
    combo_heroes = {
      "npc_dota_hero_tiny",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_drow_ranger",
      "npc_dota_hero_faceless_void",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_bristleback",
    position = {3, nil},
    combo_heroes = {
      "npc_dota_hero_crystal_maiden",
      "npc_dota_hero_dazzle",
      "npc_dota_hero_obsidian_destroyer"
    },
    counter_heroes = {
      "npc_dota_hero_legion_commander",
      "npc_dota_hero_dazzle",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_tidehunter",
    position = {3, nil},
    combo_heroes = {
      "npc_dota_hero_tiny",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_bristleback",
      "npc_dota_hero_venomancer",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_shredder",
    position = {3, 2},
    combo_heroes = {
      "npc_dota_hero_crystal_maiden",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_obsidian_destroyer",
      "npc_dota_hero_skywrath_mage",
      "npc_dota_hero_lina"
    }
  },

  {
    name = "npc_dota_hero_skywrath_mage",
    position = {4, nil},
    combo_heroes = {
      "npc_dota_hero_obsidian_destroyer",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_shadow_shaman",
      "npc_dota_hero_bristleback",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_lion",
    position = {4, 5},
    combo_heroes = {
      "npc_dota_hero_lina",
      "npc_dota_hero_legion_commander",
      "npc_dota_hero_juggernaut"
    },
    counter_heroes = {
      "npc_dota_hero_tidehunter",
      "nil",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_sand_king",
    position = {4, nil},
    combo_heroes = {
      "nil",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_death_prophet",
      "npc_dota_hero_dazzle",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_lich",
    position = {5, nil},
    combo_heroes = {
      "npc_dota_hero_faceless_void",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_sand_king",
      "nil",
      "nil"
    }
  },

  {
    name = "  npc_dota_hero_faceless_void",
    position = {3, nil},
    combo_heroes = {
      "npc_dota_hero_lich",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_lion",
      "npc_dota_hero_shadow_shaman",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_nevermore",
    position = {2, nil},
    combo_heroes = {
      "npc_dota_hero_tiny",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_zuus",
      "npc_dota_hero_ursa",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_tiny",
    position = {2, nil},
    combo_heroes = {
      "npc_dota_hero_nevermore",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_bristleback",
      "npc_dota_hero_lich",
      "nil"
    }
  },

  {
    name = "  npc_dota_hero_dazzle",
    position = {5, nil},
    combo_heroes = {
      "npc_dota_hero_bristleback",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_tidehunter",
      "npc_dota_hero_ursa",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_lina",
    position = {4, nil},
    combo_heroes = {
      "npc_dota_hero_lion",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_bristleback",
      "npc_dota_hero_tidehunter",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_legion_commander",
    position = {1, 3},
    combo_heroes = {
      "npc_dota_hero_lion",
      "nil",
      "nil"
    },
    counter_heroes = {
      "npc_dota_hero_dazzle",
      "npc_dota_hero_razor",
      "nil"
    }
  },

  {
    name = "npc_dota_hero_drow_ranger",
    position = {1, nil},
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

  {
    name = "  npc_dota_hero_razor",
    position = {2, nil},
    combo_heroes = {
      "npc_dota_hero_bane",
      "nil",
      "nil"
    },
    counter_heroes = {
      "nil",
      "nil",
      "nil"
    }
  },

}

return M
