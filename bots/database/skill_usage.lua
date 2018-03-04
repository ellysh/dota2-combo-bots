
local M = {}

M.SKILL_USAGE = {

  chaos_knight_chaos_bolt = {
      [1] = "stun",
      [2] = "",
      [3] = "",
      [4] = ""
  },

  chaos_knight_phantasm = {
      [1] = "illusions",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  chaos_knight_reality_rift = {
      [1] = "blink",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  crystal_maiden_crystal_nova = {
      [1] = "nuke_aoe",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  crystal_maiden_freezing_field = {
      [1] = "aoe_self_ult",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  crystal_maiden_frostbite = {
      [1] = "stun",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  drow_ranger_frost_arrows = {
      [1] = "attack_autocast",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  drow_ranger_trueshot = {
      [1] = "creeps_buff",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  drow_ranger_wave_of_silence = {
      [1] = "silence",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_blink = {
      [1] = "blink",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_courier = {
      [1] = "always_self",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_cyclone = {
      [1] = "stun",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_glimmer_cape = {
      [1] = "invisibility",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_lotus_orb = {
      [1] = "magic_protection",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_rod_of_atos = {
      [1] = "root",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_sheepstick = {
      [1] = "hex",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  juggernaut_blade_fury = {
      [1] = "aoe_self",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  juggernaut_healing_ward = {
      [1] = "heal",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  juggernaut_omni_slash = {
      [1] = "nuke",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  lich_chain_frost = {
      [1] = "nuke",
      [2] = "chain",
      [3] = "nil",
      [4] = "nil"
  },

  lich_dark_ritual = {
      [1] = "ally_creep_sacrifice",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  lich_frost_armor = {
      [1] = "physical_protection",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  lich_frost_nova = {
      [1] = "stun",
      [2] = "nuke",
      [3] = "nil",
      [4] = "nil"
  },

  lion_finger_of_death = {
      [1] = "nuke",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  lion_impale = {
      [1] = "stun",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  lion_mana_drain = {
      [1] = "mana_drain",
      [2] = "slow",
      [3] = "nil",
      [4] = "nil"
  },

  lion_voodoo = {
      [1] = "hex",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  phantom_assassin_phantom_strike = {
      [1] = "blink",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  phantom_assassin_stifling_dagger = {
      [1] = "nuke",
      [2] = "slow",
      [3] = "nil",
      [4] = "nil"
  },

  phantom_lancer_doppelwalk = {
      [1] = "blink",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  phantom_lancer_phantom_edge = {
      [1] = "attack_autocast",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  phantom_lancer_spirit_lance = {
      [1] = "nuke",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  shadow_shaman_ether_shock = {
      [1] = "nuke",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  shadow_shaman_mass_serpent_ward = {
      [1] = "attack_ward",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  shadow_shaman_shackles = {
      [1] = "stun",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  shadow_shaman_voodoo = {
      [1] = "hex",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  skeleton_king_hellfire_blast = {
      [1] = "stun",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  sniper_assassinate = {
      [1] = "nuke_last_hit",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  sniper_shrapnel = {
      [1] = "nuke_aoe",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  sven_gods_strength = {
      [1] = "buff_self_ult",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  sven_storm_bolt = {
      [1] = "nuke",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  sven_warcry = {
      [1] = "buff_self",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  ursa_earthshock = {
      [1] = "aoe_self_short",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  ursa_enrage = {
      [1] = "buff_self_ult",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  ursa_overpower = {
      [1] = "buff_self",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  warlock_fatal_bonds = {
      [1] = "nuke",
      [2] = "chain",
      [3] = "nil",
      [4] = "nil"
  },

  warlock_rain_of_chaos = {
      [1] = "nuke_aoe",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  warlock_shadow_word = {
      [1] = "nuke",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  warlock_upheaval = {
      [1] = "nuke_aoe",
      [2] = "slow",
      [3] = "nil",
      [4] = "nil"
  },

  item_tango = {
      [1] = "tango",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_clarity = {
      [1] = "mana_regen_self",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_magic_stick = {
      [1] = "heal_charges_self",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_magic_wand = {
      [1] = "heal_charges_self",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_black_king_bar = {
      [1] = "magic_protection",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_armlet = {
      [1] = "attack_toggle",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_mask_of_madness = {
      [1] = "attack_buff",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_phase_boots = {
      [1] = "speedup",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_butterfly = {
      [1] = "speedup",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_satanic = {
      [1] = "attack_buff",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_invis_sword = {
      [1] = "invisibility_self",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_manta = {
      [1] = "illusions",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_diffusal_blade = {
      [1] = "stun",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_abyssal_blade = {
      [1] = "stun",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_hurricane_pike = {
      [1] = "push",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_force_staff = {
      [1] = "push",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_flask = {
      [1] = "heal_self",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

  item_cheese = {
      [1] = "heal_self",
      [2] = "nil",
      [3] = "nil",
      [4] = "nil"
  },

}

return M
