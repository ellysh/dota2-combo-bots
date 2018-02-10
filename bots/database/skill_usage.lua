
local M = {}

local algorithms = require(
  GetScriptDirectory() .. "/utility/ability_usage_algorithms")

M.SKILL_USAGE = {

  crystal_maiden_crystal_nova = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 90},
      team_fight = {algorithms["three_and_more_enemy_heroes"], 90},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["three_and_more_enemy_heroes"], 90},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_LANING = {algorithms["three_and_more_enemy_creeps"], 50},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_FARM = {algorithms["three_and_more_enemy_creeps"], 60},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_enemy_creeps"], 90},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 30},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 70}
  },

  crystal_maiden_frostbite = {
      any_mode = {algorithms["channeling_enemy_hero"], 90},
      team_fight = {algorithms["attacked_not_disabled_enemy_hero"], 70},
      BOT_MODE_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 90},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 90},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 70},
      BOT_MODE_ATTACK = {algorithms["attacked_not_disabled_enemy_hero"], 70},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 50},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 80}
  },

  crystal_maiden_freezing_field = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_enemy_heroes_aoe"], 80},
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
      any_mode = {algorithms["toggle_on_attack_enemy_hero"], 90},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  drow_ranger_wave_of_silence = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["attacked_enemy_hero"], 80},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_enemy_hero"], nil},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 30},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 70}
  },

  drow_ranger_trueshot = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_ally_creeps_aoe"], 80},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["three_and_more_ally_creeps_aoe"], 70},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_ally_creeps_aoe"], 70},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  juggernaut_blade_fury = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_enemy_heroes_aoe"], 90},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_aoe"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_aoe"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["use_on_attack_enemy_hero_aoe"], 60},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_aoe"], 70},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_aoe"], 90},
      BOT_MODE_FARM = {algorithms["three_and_more_enemy_creeps_aoe"], 80},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_enemy_creeps_aoe"], 60},
      BOT_MODE_RETREAT = {algorithms["low_hp_self"], 70},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  juggernaut_healing_ward = {
      any_mode = {algorithms["low_hp_self"], 80},
      team_fight = {algorithms["low_hp_ally_hero"], 70},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["low_hp_ally_hero"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["low_hp_ally_hero"], 70}
  },

  juggernaut_omni_slash = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 90},
      team_fight = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["low_hp_ally_hero"], 60},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 30}
  },

  shadow_shaman_ether_shock = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 90},
      team_fight = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 30}
  },

  shadow_shaman_voodoo = {
      any_mode = {algorithms["channeling_enemy_hero"], 90},
      team_fight = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 40},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 70}
  },

  shadow_shaman_shackles = {
      any_mode = {algorithms["channeling_enemy_hero"], 90},
      team_fight = {algorithms["attacked_not_disabled_enemy_hero"], 70},
      BOT_MODE_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 50},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 70},
      BOT_MODE_ATTACK = {algorithms["attacked_not_disabled_enemy_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 10}
  },

  shadow_shaman_mass_serpent_ward = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_enemy_building"], 90},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], 90},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  ursa_earthshock = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_aoe"], 90},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_aoe"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_aoe"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["use_on_attack_enemy_hero_aoe"], 70},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_aoe"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["use_on_attack_enemy_hero_aoe"], 70},
      BOT_MODE_RETREAT = {algorithms["use_on_attack_enemy_hero_aoe"], 60},
      BOT_MODE_DEFEND_ALLY = {algorithms["use_on_attack_enemy_hero_aoe"], 50}
  },

  ursa_overpower = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_melee"], 80},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_melee"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  ursa_enrage = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_melee"], 70},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 50},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 50},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_melee"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  skeleton_king_hellfire_blast = {
      any_mode = {algorithms["channeling_enemy_hero"], 90},
      team_fight = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_ATTACK = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 60},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 60}
  },

  sniper_shrapnel = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_enemy_heroes"], 80},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 50},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 50},
      BOT_MODE_PUSH_TOWER = {algorithms["three_and_more_enemy_creeps"], 70},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 30},
      BOT_MODE_LANING = {algorithms["three_and_more_enemy_creeps"], 50},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["three_and_more_enemy_creeps"], 70},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_enemy_creeps"], 70},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 10}
  },

  sniper_assassinate = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 90},
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
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 90},
      team_fight = {algorithms["attacked_not_disabled_enemy_hero"], 90},
      BOT_MODE_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_ATTACK = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["attacked_enemy_creep"], 60},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 50},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 60}
  },

  lion_voodoo = {
      any_mode = {algorithms["channeling_enemy_hero"], 90},
      team_fight = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 40},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 70}
  },

  lion_mana_drain = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_with_mana_when_low_mp"], 70},
      BOT_MODE_LANING = {algorithms["use_on_attack_enemy_with_mana_when_low_mp"], 70},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_with_mana_when_low_mp"], 70},
      BOT_MODE_FARM = {algorithms["use_on_attack_enemy_with_mana_when_low_mp"], 70},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  lion_finger_of_death = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 90},
      team_fight = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 10}
  },

  sven_storm_bolt = {
      any_mode = {algorithms["channeling_enemy_hero"], 90},
      team_fight = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_ATTACK = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 60},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 60}
  },

  sven_warcry = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_melee"], 80},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_melee"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  sven_gods_strength = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_melee"], 70},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 50},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 50},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_melee"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  lich_frost_nova = {
      any_mode = {algorithms["channeling_enemy_hero"], 90},
      team_fight = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_FARM = {algorithms["attacked_enemy_creep"], 60},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 50},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 80}
  },

  lich_frost_armor = {
      any_mode = {algorithms["low_hp_self"], 80},
      team_fight = {algorithms["low_hp_ally_hero"], 70},
      BOT_MODE_ROAM = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_TEAM_ROAM = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_PUSH_TOWER = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_ATTACK = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["low_hp_ally_hero"], 40},
      BOT_MODE_FARM = {algorithms["low_hp_self"], 20},
      BOT_MODE_DEFEND_TOWER = {algorithms["low_hp_ally_hero"], 40},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["low_hp_ally_hero"], 70}
  },

  lich_dark_ritual = {
      any_mode = {algorithms["low_hp_ally_creep"], 70},
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
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 90},
      team_fight = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 70}
  },

  phantom_assassin_stifling_dagger = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 90},
      team_fight = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 30},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 50}
  },

  phantom_assassin_phantom_strike = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_ranged"], 80},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_ranged"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_ranged"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_ranged"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  chaos_knight_chaos_bolt = {
      any_mode = {algorithms["channeling_enemy_hero"], 90},
      team_fight = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_ATTACK = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 60},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 60}
  },

  chaos_knight_reality_rift = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_ranged"], 80},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_ranged"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_ranged"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_ranged"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  chaos_knight_phantasm = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_melee"], 70},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 50},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_melee"], 50},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_melee"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  phantom_lancer_spirit_lance = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 90},
      team_fight = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 30},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 50}
  },

  phantom_lancer_doppelwalk = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_ranged"], 80},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_ranged"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_ranged"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_ranged"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep_melee"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  phantom_lancer_phantom_edge = {
      any_mode = {algorithms["toggle_on_attack_enemy_hero"], 90},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  warlock_fatal_bonds = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["attacked_enemy_hero"], 80},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  warlock_shadow_word = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["attacked_enemy_hero"], 75},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_FARM = {algorithms["attacked_enemy_creep"], 60},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_enemy_hero"], 75},
      BOT_MODE_RETREAT = {algorithms["low_hp_self"], 90},
      BOT_MODE_DEFEND_ALLY = {algorithms["low_hp_ally_hero"], 80}
  },

  warlock_upheaval = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_enemy_heroes"], 70},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 60},
      BOT_MODE_PUSH_TOWER = {algorithms["three_and_more_enemy_heroes"], 50},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 40},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_enemy_heroes"], 70},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  warlock_rain_of_chaos = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_enemy_heroes"], 90},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["three_and_more_enemy_heroes"], 90},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 20},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_enemy_heroes"], 90},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

  item_glimmer_cape = {
      any_mode = {algorithms["low_hp_self"], 80},
      team_fight = {algorithms["low_hp_ally_hero"], 70},
      BOT_MODE_ROAM = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_TEAM_ROAM = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_PUSH_TOWER = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_ATTACK = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["low_hp_ally_hero"], 40},
      BOT_MODE_FARM = {algorithms["low_hp_self"], 20},
      BOT_MODE_DEFEND_TOWER = {algorithms["low_hp_ally_hero"], 40},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["low_hp_ally_hero"], 70}
  },

  item_rod_of_atos = {
      any_mode = {algorithms["channeling_enemy_hero"], 90},
      team_fight = {algorithms["attacked_enemy_hero"], 80},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 30},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 40}
  },

  item_sheepstick = {
      any_mode = {algorithms["channeling_enemy_hero"], 90},
      team_fight = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 40},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 70}
  },

  item_lotus_orb = {
      any_mode = {algorithms["low_hp_self"], 80},
      team_fight = {algorithms["low_hp_ally_hero"], 70},
      BOT_MODE_ROAM = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_TEAM_ROAM = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_PUSH_TOWER = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_ATTACK = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["low_hp_ally_hero"], 40},
      BOT_MODE_FARM = {algorithms["low_hp_self"], 20},
      BOT_MODE_DEFEND_TOWER = {algorithms["low_hp_ally_hero"], 40},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["low_hp_ally_hero"], 70}
  },

  item_cyclone = {
      any_mode = {algorithms["channeling_enemy_hero"], 90},
      team_fight = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_not_disabled_enemy_hero"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_ATTACK = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_DEFEND_TOWER = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 60},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 60}
  },

  item_blink = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero_ranged"], 80},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero_ranged"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero_ranged"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero_ranged"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil}
  },

}

return M
