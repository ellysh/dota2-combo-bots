
local M = {}

M.HEROES = {

  npc_dota_hero_phantom_lancer = {
    position = {1, nil},
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

  npc_dota_hero_lich = {
    position = {4, 5},
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

}

return M
