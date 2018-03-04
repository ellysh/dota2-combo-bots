
local M = {}

local algorithms = require(
  GetScriptDirectory() .. "/utility/ability_usage_algorithms")

M.SKILL_GROUPS = {

  ally_creep_sacrifice = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  always_self = {
      any_mode = {algorithms["always_self"], 100},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  aoe_self = {
      any_mode = {algorithms["use_on_attack_enemy_hero"], nil},
      team_fight = {algorithms["three_and_more_enemy_heroes_self_aoe"], 90},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["use_on_attack_enemy_hero"], 60},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero"], 70},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["three_and_more_neutral_creeps_self_aoe"], 80},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_enemy_creeps_self_aoe"], 60},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["low_hp_self"], 70},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  aoe_self_ult = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["three_and_more_enemy_heroes_self_aoe"], 80},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  aoe_short_self = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero"], 90},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero"], 80},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero"], 80},
      BOT_MODE_PUSH_TOWER = {algorithms["use_on_attack_enemy_hero"], 70},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["use_on_attack_enemy_hero"], 70},
      BOT_MODE_DEFEND_ALLY = {algorithms["use_on_attack_enemy_hero"], 50},
      BOT_MODE_RETREAT = {algorithms["use_on_attack_enemy_hero"], 60},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["use_on_attack_enemy_hero"], 60}
  },

  attack_autocast = {
      any_mode = {algorithms["autocast_on_attack_enemy_hero"], 90},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  attack_buff_self = {
      any_mode = {algorithms["use_on_attack_enemy_hero"], 50},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  attack_buff_self_ult = {
      any_mode = {algorithms["three_and_more_enemy_heroes_self_aoe"], 70},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  attack_toggle = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  attack_ward = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  blink = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero"], 80},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero"], 60},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  creeps_buff = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  heal = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["low_hp_ally_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  heal_charges_self = {
      any_mode = {algorithms["low_hp_charges_self"], 70},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  heal_self = {
      any_mode = {algorithms["low_hp_self"], 70},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  hex = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 40},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["last_attacked_enemy_hero"], 40}
  },

  illusions = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero"], 70},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero"], 50},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero"], 50},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  invisibility = {
      any_mode = {algorithms["low_hp_self"], 50},
      team_fight = {algorithms["low_hp_ally_hero"], 80},
      BOT_MODE_ROAM = {algorithms["low_hp_ally_hero"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["low_hp_ally_hero"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["low_hp_ally_hero"], 70},
      BOT_MODE_ATTACK = {algorithms["low_hp_ally_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["low_hp_ally_hero"], 40},
      BOT_MODE_FARM = {algorithms["low_hp_self"], 20},
      BOT_MODE_DEFEND_TOWER = {algorithms["low_hp_ally_hero"], 60},
      BOT_MODE_DEFEND_ALLY = {algorithms["low_hp_ally_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["low_hp_self"], 60},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  invisibility_self = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["low_hp_self"], 90},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  magic_protection = {
      any_mode = {algorithms["half_hp_self"], 50},
      team_fight = {algorithms["half_hp_ally_hero"], 70},
      BOT_MODE_ROAM = {algorithms["half_hp_ally_hero"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["half_hp_ally_hero"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["half_hp_ally_hero"], 70},
      BOT_MODE_ATTACK = {algorithms["half_hp_ally_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["low_hp_ally_hero"], 40},
      BOT_MODE_FARM = {algorithms["low_hp_self"], 20},
      BOT_MODE_DEFEND_TOWER = {algorithms["half_hp_ally_hero"], 60},
      BOT_MODE_DEFEND_ALLY = {algorithms["half_hp_ally_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  mana_drain = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  mana_regen_self = {
      any_mode = {algorithms["low_mp_self"], 50},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  nuke = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 30},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  nuke_aoe = {
      any_mode = {algorithms["min_hp_enemy_hero_to_kill"], 90},
      team_fight = {algorithms["three_and_more_enemy_heroes_aoe"], 90},
      BOT_MODE_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["three_and_more_enemy_heroes_aoe"], 90},
      BOT_MODE_ATTACK = {algorithms["attacked_enemy_hero"], 90},
      BOT_MODE_LANING = {algorithms["three_and_more_enemy_creeps"], 50},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 70},
      BOT_MODE_FARM = {algorithms["three_and_more_neutral_creeps"], 60},
      BOT_MODE_DEFEND_TOWER = {algorithms["three_and_more_enemy_creeps"], 90},
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 30},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["last_attacked_enemy_hero"], 30}
  },

  nuke_last_hit = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  physical_protection = {
      any_mode = {algorithms["half_hp_self"], 50},
      team_fight = {algorithms["half_hp_ally_hero"], 70},
      BOT_MODE_ROAM = {algorithms["half_hp_ally_hero"], 70},
      BOT_MODE_TEAM_ROAM = {algorithms["half_hp_ally_hero"], 70},
      BOT_MODE_PUSH_TOWER = {algorithms["half_hp_ally_hero"], 70},
      BOT_MODE_ATTACK = {algorithms["half_hp_ally_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["low_hp_ally_hero"], 40},
      BOT_MODE_FARM = {algorithms["low_hp_self"], 20},
      BOT_MODE_DEFEND_TOWER = {algorithms["half_hp_ally_hero"], 60},
      BOT_MODE_DEFEND_ALLY = {algorithms["half_hp_ally_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  physical_protection_buff_aoe_self = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero"], 70},
      BOT_MODE_ROAM = {algorithms["use_on_attack_enemy_hero"], 50},
      BOT_MODE_TEAM_ROAM = {algorithms["use_on_attack_enemy_hero"], 50},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["use_on_attack_enemy_hero"], 50},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["use_on_attack_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  push = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["use_on_attack_enemy_hero"], 50},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["attacked_enemy_creep"], 90},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["low_hp_ally_hero"], 30},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 60},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  root = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 40},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 30},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["last_attacked_enemy_hero"], 30}
  },

  silence = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_enemy_hero"], 70},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 30},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["last_attacked_enemy_hero"], 30}
  },

  speedup = {
      any_mode = {algorithms["nil"], nil},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["low_hp_self"], 90},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

  stun = {
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
      BOT_MODE_DEFEND_ALLY = {algorithms["attacked_not_disabled_enemy_hero"], 60},
      BOT_MODE_RETREAT = {algorithms["last_attacked_enemy_hero"], 60},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["last_attacked_enemy_hero"], 60}
  },

  tango = {
      any_mode = {algorithms["half_hp_tree"], 50},
      team_fight = {algorithms["nil"], nil},
      BOT_MODE_ROAM = {algorithms["nil"], nil},
      BOT_MODE_TEAM_ROAM = {algorithms["nil"], nil},
      BOT_MODE_PUSH_TOWER = {algorithms["nil"], nil},
      BOT_MODE_ATTACK = {algorithms["nil"], nil},
      BOT_MODE_LANING = {algorithms["nil"], nil},
      BOT_MODE_ROSHAN = {algorithms["nil"], nil},
      BOT_MODE_FARM = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_TOWER = {algorithms["nil"], nil},
      BOT_MODE_DEFEND_ALLY = {algorithms["nil"], nil},
      BOT_MODE_RETREAT = {algorithms["nil"], nil},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["nil"], nil}
  },

}

return M
