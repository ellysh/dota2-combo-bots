
local M = {}

M.HEROES = {

  npc_dota_hero_phantom_assassin = {
    positions = {1, 2},
    attribute = "agility",
    damage_type = "physical",
    attack_range = "melee",
    available_skills = {
      "blink",
      "attack_damage",
      "slow",
      "nil",
    },
    available_auras = {
      "nil"
    },
    required_skills = {
      "stun",
      "slow",
      "nil",
    },
    required_auras = {
      "heal",
      "armor",
      "lifesteal",
    },
  },

  npc_dota_hero_chaos_knight = {
    positions = {1, 2},
    attribute = "strength",
    damage_type = "physical",
    attack_range = "melee",
    available_skills = {
      "blink",
      "stun",
      "attack_damage",
      "illusions",
    },
    available_auras = {
      "nil"
    },
    required_skills = {
      "stun",
      "slow",
      "nil",
    },
    required_auras = {
      "heal",
      "armor",
      "lifesteal",
    },
  },

  npc_dota_hero_crystal_maiden = {
    positions = {4, 5},
    attribute = "intelligence",
    damage_type = "magical",
    attack_range = "ranged",
    available_skills = {
      "stun",
      "slow",
      "aoe",
      "nil",
    },
    available_auras = {
      "mana_regen"
    },
    required_skills = {
      "attack_damage",
      "nuke",
      "nil",
    },
    required_auras = {
      "nil",
      "nil",
      "nil",
    },
  },

  npc_dota_hero_drow_ranger = {
    positions = {1, 2},
    attribute = "agility",
    damage_type = "physical",
    attack_range = "ranged",
    available_skills = {
      "silence",
      "slow",
      "nil",
      "nil",
    },
    available_auras = {
      "attack_damage_ranged"
    },
    required_skills = {
      "stun",
      "slow",
      "nil",
    },
    required_auras = {
      "lifesteal",
      "nil",
      "nil",
    },
  },

  npc_dota_hero_juggernaut = {
    positions = {1, 3},
    attribute = "agility",
    damage_type = "physical",
    attack_range = "melee",
    available_skills = {
      "aoe",
      "attack_damage",
      "invulnerable",
      "nil",
    },
    available_auras = {
      "heal"
    },
    required_skills = {
      "stun",
      "slow",
      "aoe",
    },
    required_auras = {
      "nil",
      "nil",
      "nil",
    },
  },

  npc_dota_hero_lich = {
    positions = {5, 4},
    attribute = "intelligence",
    damage_type = "magical",
    attack_range = "ranged",
    available_skills = {
      "slow",
      "mana_regen",
      "nuke",
      "nil",
    },
    available_auras = {
      "armor"
    },
    required_skills = {
      "attack_damage",
      "slow",
      "nuke",
    },
    required_auras = {
      "nil",
      "nil",
      "nil",
    },
  },

  npc_dota_hero_lion = {
    positions = {5, 4},
    attribute = "intelligence",
    damage_type = "magical",
    attack_range = "ranged",
    available_skills = {
      "stun",
      "hex",
      "slow",
      "nuke",
    },
    available_auras = {
      "nil"
    },
    required_skills = {
      "attack_damage",
      "nuke",
      "nil",
    },
    required_auras = {
      "nil",
      "nil",
      "nil",
    },
  },

  npc_dota_hero_phantom_lancer = {
    positions = {1, 3},
    attribute = "agility",
    damage_type = "physical",
    attack_range = "melee",
    available_skills = {
      "illusions",
      "attack_damage",
      "nil",
      "nil",
    },
    available_auras = {
      "nil"
    },
    required_skills = {
      "stun",
      "hex",
      "slow",
    },
    required_auras = {
      "lifesteal",
      "nil",
      "nil",
    },
  },

  npc_dota_hero_shadow_shaman = {
    positions = {5, 4},
    attribute = "intelligence",
    damage_type = "magical",
    attack_range = "ranged",
    available_skills = {
      "hex",
      "stun",
      "minions",
      "nuke",
    },
    available_auras = {
      "nil"
    },
    required_skills = {
      "attack_damage",
      "stun",
      "nuke",
    },
    required_auras = {
      "mana_regen",
      "nil",
      "nil",
    },
  },

  npc_dota_hero_skeleton_king = {
    positions = {2, 3},
    attribute = "strength",
    damage_type = "physical",
    attack_range = "melee",
    available_skills = {
      "attack_damage",
      "stun",
      "nil",
      "nil",
    },
    available_auras = {
      "lifesteal"
    },
    required_skills = {
      "stun",
      "nuke",
      "hex",
    },
    required_auras = {
      "heal",
      "armor",
      "nil",
    },
  },

  npc_dota_hero_sniper = {
    positions = {2, 1},
    attribute = "agility",
    damage_type = "physical",
    attack_range = "ranged",
    available_skills = {
      "attack_damage",
      "slow",
      "aoe",
      "nuke",
    },
    available_auras = {
      "nil"
    },
    required_skills = {
      "stun",
      "slow",
      "nil",
    },
    required_auras = {
      "lifesteal",
      "attack_damage_ranged",
      "nil",
    },
  },

  npc_dota_hero_sven = {
    positions = {1, 3},
    attribute = "strength",
    damage_type = "physical",
    attack_range = "melee",
    available_skills = {
      "attack_damage",
      "stun",
      "aoe",
      "nil",
    },
    available_auras = {
      "armor"
    },
    required_skills = {
      "stun",
      "slow",
      "hex",
    },
    required_auras = {
      "heal",
      "nil",
      "nil",
    },
  },

  npc_dota_hero_ursa = {
    positions = {3, 1},
    attribute = "agility",
    damage_type = "physical",
    attack_range = "melee",
    available_skills = {
      "attack_damage",
      "slow",
      "armor",
      "nil",
    },
    available_auras = {
      "nil"
    },
    required_skills = {
      "stun",
      "hex",
      "nil",
    },
    required_auras = {
      "armor",
      "heal",
      "lifesteal",
    },
  },

  npc_dota_hero_warlock = {
    positions = {2, 4},
    attribute = "intelligence",
    damage_type = "magical",
    attack_range = "ranged",
    available_skills = {
      "stun",
      "slow",
      "minions",
      "nil",
    },
    available_auras = {
      "heal"
    },
    required_skills = {
      "stun",
      "attack_damage",
      "nuke",
    },
    required_auras = {
      "mana_regen",
      "nil",
      "nil",
    },
  },

}

return M
