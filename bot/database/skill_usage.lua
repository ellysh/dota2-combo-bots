
local M = {}

local algorithms = require(
  GetScriptDirectory() .. "/utility/ability_usage_algorithms")

M.SKILL_USAGE = {

  crystal_maiden_crystal_nova = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 0.9},
      team_fight = {algorithms["three_and_more_enemy_heroes"], 0.9},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_PUSH_TOWER = {algorithms["three_and_more_creeps"], 0.9},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.9},
      BOT_MODE_LANING = {algorithms["three_and_more_creeps"], 0.5},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.7},
      BOT_MODE_FARM = {algorithms["three_and_more_creeps"], 0.6},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_creeps"], 0.9},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 0.3},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.7}
  },

  crystal_maiden_frostbite = {
      any_mode = {algorithms["channeling_enemy_hero"], 0.9},
      team_fight = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.9},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.9},
      BOT_MODE_PUSH_TOWER = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.7},
      BOT_MODE_FARM = {algorithms["max_hp_creep"], 0.6},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 0.5},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.8}
  },

  crystal_maiden_freezing_field = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_enemy_heroes_aoe"], 0.8},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  drow_ranger_frost_arrows = {
      any_mode = {algorithms["toggle_on_attack_enemy_hero"], 0.9},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.9},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  drow_ranger_wave_of_silence = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["max_estimated_damage_enemy_hero"], 0.8},
      BOT_MODE_ROAM = {algorithms["max_estimated_damage_enemy_hero"], 0.6},
      BOT_MODE_TEAM_ROAM = {algorithms["max_estimated_damage_enemy_hero"], 0.6},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["max_estimated_damage_enemy_hero"], 0.6},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_estimated_damage_enemy_hero"], nil},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 0.3},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_estimated_damage_enemy_hero"], 0.7}
  },

  drow_ranger_trueshot = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_ally_creeps_aoe"], 0.8},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["three_and_more_ally_creeps_aoe"], 0.7},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_ally_creeps_aoe"], 0.7},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  juggernaut_blade_fury = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_enemy_heroes_aoe"], 0.9},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_aoe"], 0.8},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_aoe"], 0.8},
      BOT_MODE_PUSH_TOWER = {algorithms["use_on_attack_enemy_hero_aoe"], 0.6},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_aoe"], 0.7},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_aoe"], 0.9},
      BOT_MODE_FARM = {algorithms["three_and_more_enemy_creeps_aoe"], 0.8},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_enemy_creeps_aoe"], 0.6},
      BOT_MODE_RETREAT = {algorithms["low_hp_self"], 0.7},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  juggernaut_healing_ward = {
      any_mode = {algorithms["low_hp_self"], 0.8},
      team_fight = {algorithms["low_hp_ally_hero"], 0.7},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["low_hp_ally_hero"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["low_hp_ally_hero"], 0.7}
  },

  juggernaut_omni_slash = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 0.9},
      team_fight = {algorithms["max_kills_enemy_hero"], 0.9},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_PUSH_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.5},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["low_hp_ally_hero"], 0.6},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.3}
  },

  shadow_shaman_ether_shock = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 0.9},
      team_fight = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_PUSH_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.5},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.9},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.3}
  },

  shadow_shaman_voodoo = {
      any_mode = {algorithms["channeling_enemy_hero"], 0.9},
      team_fight = {algorithms["max_estimated_damage_enemy_hero"], 0.8},
      BOT_MODE_ROAM = {algorithms["max_estimated_damage_enemy_hero"], 0.8},
      BOT_MODE_TEAM_ROAM = {algorithms["max_estimated_damage_enemy_hero"], 0.8},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["max_estimated_damage_enemy_hero"], 0.6},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_estimated_damage_enemy_hero"], nil},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 0.4},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_estimated_damage_enemy_hero"], 0.7}
  },

  shadow_shaman_shackles = {
      any_mode = {algorithms["channeling_enemy_hero"], 0.9},
      team_fight = {algorithms["max_estimated_damage_enemy_hero"], 0.7},
      BOT_MODE_ROAM = {algorithms["max_estimated_damage_enemy_hero"], 0.3},
      BOT_MODE_TEAM_ROAM = {algorithms["max_estimated_damage_enemy_hero"], 0.7},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["max_estimated_damage_enemy_hero"], 0.5},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_estimated_damage_enemy_hero"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_estimated_damage_enemy_hero"], 0.1}
  },

  shadow_shaman_mass_serpent_ward = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_enemy_heroes"], 0.9},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["min_hp_enemy_building"], 0.9},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], 0.9},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  ursa_earthshock = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_aoe"], 0.9},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_aoe"], 0.8},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_aoe"], 0.8},
      BOT_MODE_PUSH_TOWER = {algorithms["use_on_attack_enemy_hero_aoe"], 0.7},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_aoe"], 0.6},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["use_on_attack_enemy_hero_aoe"], 0.7},
      BOT_MODE_RETREAT = {algorithms["use_on_attack_enemy_hero_aoe"], 0.6},
      BOT_MODE_DEFEND_ALLY = {algorithms["use_on_attack_enemy_hero_aoe"], 0.5}
  },

  ursa_overpower = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_melee"], 0.8},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 0.7},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 0.7},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_melee"], 0.6},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 0.9},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  ursa_enrage = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_melee"], 0.7},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 0.5},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 0.5},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_melee"], 0.5},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 0.9},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  skeleton_king_hellfire_blast = {
      any_mode = {algorithms["channeling_enemy_hero"], 0.9},
      team_fight = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_PUSH_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.9},
      BOT_MODE_FARM = {algorithms["max_hp_creep"], 0.7},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 0.6},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.6}
  },

  sniper_shrapnel = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_enemy_heroes"], 0.8},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.5},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.5},
      BOT_MODE_PUSH_TOWER = {algorithms["three_and_more_creeps"], 0.7},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.3},
      BOT_MODE_LANING = {algorithms["three_and_more_creeps"], 0.5},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.9},
      BOT_MODE_FARM = {algorithms["three_and_more_creeps"], 0.7},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_creeps"], 0.7},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.1}
  },

  sniper_assassinate = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 0.9},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  lion_impale = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 0.9},
      team_fight = {algorithms["max_kills_enemy_hero"], 0.9},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_PUSH_TOWER = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.9},
      BOT_MODE_FARM = {algorithms["max_hp_creep"], 0.6},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 0.5},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.6}
  },

  lion_voodoo = {
      any_mode = {algorithms["channeling_enemy_hero"], 0.9},
      team_fight = {algorithms["max_estimated_damage_enemy_hero"], 0.8},
      BOT_MODE_ROAM = {algorithms["max_estimated_damage_enemy_hero"], 0.7},
      BOT_MODE_TEAM_ROAM = {algorithms["max_estimated_damage_enemy_hero"], 0.7},
      BOT_MODE_PUSH_TOWER = {algorithms["max_estimated_damage_enemy_hero"], 0.7},
      BOT_MODE_ATTACK = {algorithms["max_estimated_damage_enemy_hero"], 0.7},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_estimated_damage_enemy_hero"], 0.7},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 0.3},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.4}
  },

  lion_mana_drain = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_with_mana_when_low_mp"], 0.7},
      BOT_MODE_LANING = {algorithms["use_on_attack_enemy_with_mana_when_low_mp"], 0.7},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_with_mana_when_low_mp"], 0.7},
      BOT_MODE_FARM = {algorithms["use_on_attack_enemy_with_mana_when_low_mp"], 0.7},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  lion_finger_of_death = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 0.9},
      team_fight = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_PUSH_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.5},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.1}
  },

  sven_storm_bolt = {
      any_mode = {algorithms["channeling_enemy_hero"], 0.9},
      team_fight = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_PUSH_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.9},
      BOT_MODE_FARM = {algorithms["max_hp_creep"], 0.7},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 0.6},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.6}
  },

  sven_warcry = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_melee"], 0.8},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 0.7},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 0.7},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_melee"], 0.6},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 0.9},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  sven_gods_strength = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_melee"], 0.7},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 0.5},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 0.5},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_melee"], 0.5},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 0.9},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  lich_frost_nova = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 0.9},
      team_fight = {algorithms["max_kills_enemy_hero"], 0.9},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_PUSH_TOWER = {algorithms["three_and_more_creeps"], 0.9},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.9},
      BOT_MODE_LANING = {algorithms["three_and_more_creeps"], 0.5},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.7},
      BOT_MODE_FARM = {algorithms["three_and_more_creeps"], 0.6},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_creeps"], 0.9},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 0.3},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.7}
  },

  lich_frost_armor = {
      any_mode = {algorithms["low_hp_self"], 0.8},
      team_fight = {algorithms["low_hp_ally_hero"], 0.7},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["low_hp_ally_hero"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["low_hp_ally_hero"], 0.7}
  },

  lich_dark_ritual = {
      any_mode = {algorithms["low_hp_ally_creep"], 0.7},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  lich_chain_frost = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 0.9},
      team_fight = {algorithms["max_kills_enemy_hero"], 0.9},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_PUSH_TOWER = {algorithms["three_and_more_creeps"], 0.9},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.9},
      BOT_MODE_LANING = {algorithms["three_and_more_creeps"], 0.5},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.7},
      BOT_MODE_FARM = {algorithms["three_and_more_creeps"], 0.6},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_creeps"], 0.9},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 0.3},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.7}
  },

  phantom_assassin_stifling_dagger = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 0.9},
      team_fight = {algorithms["max_kills_enemy_hero"], 0.9},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.7},
      BOT_MODE_PUSH_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.9},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.7},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 0.3},
      BOT_MODE_DEFEND_ALLY = {algorithms["max_kills_enemy_hero"], 0.5}
  },

  phantom_assassin_phantom_strike = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_ROAM = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_TEAM_ROAM = {algorithms["max_kills_enemy_hero"], 0.6},
      BOT_MODE_PUSH_TOWER = {algorithms["max_kills_enemy_hero"], 0.5},
      BOT_MODE_ATTACK = {algorithms["max_kills_enemy_hero"], 0.8},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["max_hp_creep"], 0.6},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["max_kills_enemy_hero"], 0.5},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

}

return M
