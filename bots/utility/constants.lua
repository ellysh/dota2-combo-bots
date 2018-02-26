local M = {}

M.INVENTORY_START_INDEX = 0
M.INVENTORY_END_INDEX = 8
M.INVENTORY_SIZE = 9

M.STASH_START_INDEX = 9
M.STASH_END_INDEX = 14
M.STASH_SIZE = 6

M.SHRINE_USE_RADIUS = 150
M.SHRINE_AURA_RADIUS = 500

M.SHOP_USE_RADIUS = 300
M.BASE_SHOP_USE_RADIUS = 1000
M.SHOP_WALK_RADIUS = 3000 -- ~10 second to walk

M.DEFAULT_ABILITY_USAGE_RADIUS = 600
M.MAX_ABILITY_USAGE_RADIUS = 1600
M.MIN_TELEPORT_RADIUS = 1600

M.MAX_ROAM_RADIUS = 4500
M.MAX_GROUP_RADIUS = 1200 -- This is the Smoke of Deceit radius
M.MAX_ENEMY_TO_BUILDING_RADIUS = 3000

M.MELEE_ATTACK_RADIUS = 200

M.MAX_GET_UNITS_RADIUS = 1600

M.ABILITY_NO_TARGET = 1
M.ABILITY_UNIT_TARGET = 2
M.ABILITY_LOCATION_TARGET = 3

M.UNIT_LOW_HEALTH_LEVEL = 0.3 -- 30%
M.UNIT_HALF_HEALTH_LEVEL = 0.5 -- 50%
M.UNIT_LOW_MANA_LEVEL = 0.3 -- 30%

M.UNIT_LOW_HEALTH = 250

M.MAX_HERO_DISTANCE_FROM_LANE = 1200
M.MAX_HERO_DISTANCE_FROM_RUNE = 3000
M.MIN_HERO_DISTANCE_FROM_RUNE = 200

M.MAX_MINION_DISTANCE_FROM_HERO = 300

M.MAX_HERO_DISTANCE_FROM_ITEM = 1600
M.MIN_HERO_DISTANCE_FROM_ITEM = 200

M.MAX_RUNE_DESIRE = 0.6
M.MAX_SHOP_DESIRE = 0.6
M.MAX_PUSH_DESIRE = 0.75
M.MAX_ROAM_DESIRE = 0.7
M.MAX_DEFEND_DESIRE = 0.75
M.MAX_ATTACK_DESIRE = 0.7
M.MAX_LANING_DESIRE = 0.5
M.MAX_FARM_DESIRE = 0.5
M.MAX_ROSHAN_DESIRE = 0.7
M.MAX_RETREAT_DESIRE = 0.85
M.MAX_EVASIVE_MANEUVERS_DESIRE = 0.8

M.MAX_CREEP_ATTACK_RANGE = 690
M.MAX_TOWER_ATTACK_RANGE = 700
M.MAX_HERO_ATTACK_RANGE = 700

-- This is a mapping string from database to the numeric constants for API
M.BOT_MODES = {
  BOT_MODE_NONE = 0,
  BOT_MODE_LANING = 1,
  BOT_MODE_ATTACK = 2,
  BOT_MODE_ROAM = 3,
  BOT_MODE_RETREAT = 4,
  BOT_MODE_SECRET_SHOP = 5,
  BOT_MODE_SIDE_SHOP = 6,
  BOT_MODE_PUSH_TOWER_TOP = 8,
  BOT_MODE_PUSH_TOWER_MID = 9,
  BOT_MODE_PUSH_TOWER_BOT = 10,
  BOT_MODE_DEFEND_TOWER_TOP = 11,
  BOT_MODE_DEFEND_TOWER_MID = 12,
  BOT_MODE_DEFEND_TOWER_BOT = 13,
  BOT_MODE_ASSEMBLE = 14,
  BOT_MODE_TEAM_ROAM = 16,
  BOT_MODE_FARM = 17,
  BOT_MODE_DEFEND_ALLY = 18,
  BOT_MODE_EVASIVE_MANEUVERS = 19,
  BOT_MODE_ROSHAN = 20,
  BOT_MODE_ITEM = 21,
  BOT_MODE_WARD = 22,
}

return M
