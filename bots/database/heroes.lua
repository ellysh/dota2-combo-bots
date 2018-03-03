
local M = {}

M.HEROES = {

  npc_dota_hero_phantom_assassin = {
    position = {1, 2},
    combo_heroes = {
      "agility",
      "physical",
      "melee"
    },
    counter_heroes = {
      "blink",
      "attack_damage",
      "slow"
    }
  },

  npc_dota_hero_chaos_knight = {
    position = {1, 2},
    combo_heroes = {
      "strength",
      "physical",
      "melee"
    },
    counter_heroes = {
      "blink",
      "stun",
      "attack_damage"
    }
  },

  npc_dota_hero_crystal_maiden = {
    position = {4, 5},
    combo_heroes = {
      "intelligence",
      "magical",
      "ranged"
    },
    counter_heroes = {
      "stun",
      "slow",
      "aoe"
    }
  },

  npc_dota_hero_drow_ranger = {
    position = {1, 2},
    combo_heroes = {
      "agility",
      "physical",
      "ranged"
    },
    counter_heroes = {
      "silence",
      "slow",
      "nil"
    }
  },

  npc_dota_hero_juggernaut = {
    position = {1, 3},
    combo_heroes = {
      "agility",
      "physical",
      "melee"
    },
    counter_heroes = {
      "aoe",
      "attack_damage",
      "invulnerable"
    }
  },

  npc_dota_hero_lich = {
    position = {5, 4},
    combo_heroes = {
      "intelligence",
      "magical",
      "ranged"
    },
    counter_heroes = {
      "slow",
      "mana_regen",
      "nuke"
    }
  },

  npc_dota_hero_lion = {
    position = {5, 4},
    combo_heroes = {
      "intelligence",
      "magical",
      "ranged"
    },
    counter_heroes = {
      "stun",
      "hex",
      "mana_regen"
    }
  },

  npc_dota_hero_phantom_lancer = {
    position = {1, 3},
    combo_heroes = {
      "agility",
      "physical",
      "melee"
    },
    counter_heroes = {
      "illusions",
      "attack_damage",
      "nil"
    }
  },

  npc_dota_hero_shadow_shaman = {
    position = {5, 4},
    combo_heroes = {
      "intelligence",
      "magical",
      "ranged"
    },
    counter_heroes = {
      "hex",
      "stun",
      "minions"
    }
  },

  npc_dota_hero_skeleton_king = {
    position = {2, 3},
    combo_heroes = {
      "strength",
      "physical",
      "melee"
    },
    counter_heroes = {
      "attack_damage",
      "stun",
      "nil"
    }
  },

  npc_dota_hero_sniper = {
    position = {2, 1},
    combo_heroes = {
      "agility",
      "physical",
      "ranged"
    },
    counter_heroes = {
      "attack_damage",
      "slow",
      "aoe"
    }
  },

  npc_dota_hero_sven = {
    position = {1, 3},
    combo_heroes = {
      "strength",
      "physical",
      "melee"
    },
    counter_heroes = {
      "attack_damage",
      "stun",
      "aoe"
    }
  },

  npc_dota_hero_ursa = {
    position = {3, 1},
    combo_heroes = {
      "agility",
      "physical",
      "melee"
    },
    counter_heroes = {
      "attack_damage",
      "slow",
      "armor"
    }
  },

  npc_dota_hero_warlock = {
    position = {2, 4},
    combo_heroes = {
      "intelligence",
      "magical",
      "ranged"
    },
    counter_heroes = {
      "stun",
      "slow",
      "minions"
    }
  },

}

return M
