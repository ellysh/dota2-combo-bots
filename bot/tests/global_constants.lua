-- These are fake values of the Dota 2 API constants.
-- They are required for unit tests purposes only.

COURIER_ACTION_BURST = 0
COURIER_ACTION_ENEMY_SECRET_SHOP = 1
COURIER_ACTION_RETURN = 2
COURIER_ACTION_SECRET_SHOP = 3
COURIER_ACTION_SIDE_SHOP = 4
COURIER_ACTION_SIDE_SHOP2 = 5
COURIER_ACTION_TAKE_STASH_ITEMS = 6
COURIER_ACTION_TAKE_AND_TRANSFER_ITEMS = 7
COURIER_ACTION_TRANSFER_ITEMS = 8

COURIER_STATE_IDLE = 9
COURIER_STATE_AT_BASE = 10
COURIER_STATE_MOVING = 11
COURIER_STATE_DELIVERING_ITEMS = 12
COURIER_STATE_RETURNING_TO_BASE = 13
COURIER_STATE_DEAD = 14

-----------------------------------------

TEAM_RADIANT = 0
TEAM_DIRE = 1

-- This is tested and match the game values
LANE_TOP = 1
LANE_MID = 2
LANE_BOT = 3

-----------------------------------------

BOT_MODE_NONE = 0
BOT_MODE_LANING = 1
BOT_MODE_ATTACK = 2
BOT_MODE_ROAM = 3
BOT_MODE_RETREAT = 4
BOT_MODE_SECRET_SHOP = 5
BOT_MODE_SIDE_SHOP = 6
BOT_MODE_PUSH_TOWER_TOP = 8
BOT_MODE_PUSH_TOWER_MID = 9
BOT_MODE_PUSH_TOWER_BOT = 10
BOT_MODE_DEFEND_TOWER_TOP = 11
BOT_MODE_DEFEND_TOWER_MID = 12
BOT_MODE_DEFEND_TOWER_BOT = 13
BOT_MODE_ASSEMBLE = 14
BOT_MODE_TEAM_ROAM = 16
BOT_MODE_FARM = 17
BOT_MODE_DEFEND_ALLY = 18
BOT_MODE_EVASIVE_MANEUVERS = 19
BOT_MODE_ROSHAN = 20
BOT_MODE_ITEM = 21
BOT_MODE_WARD = 22

-----------------------------------------

SHOP_SIDE = 1
SHOP_SIDE2 = 2

-----------------------------------------

BOT_ACTION_DESIRE_NONE = 0.0
BOT_ACTION_DESIRE_VERYLOW = 0.1
BOT_ACTION_DESIRE_LOW = 0.25
BOT_ACTION_DESIRE_MODERATE = 0.5
BOT_ACTION_DESIRE_HIGH = 0.75
BOT_ACTION_DESIRE_VERYHIGH = 0.9
BOT_ACTION_DESIRE_ABSOLUTE = 1.0

-----------------------------------------

BOT_MODE_DESIRE_NONE = 0
BOT_MODE_DESIRE_VERYLOW = 0.1
BOT_MODE_DESIRE_LOW = 0.25
BOT_MODE_DESIRE_MODERATE = 0.5
BOT_MODE_DESIRE_HIGH = 0.75
BOT_MODE_DESIRE_VERYHIGH = 0.9
BOT_MODE_DESIRE_ABSOLUTE = 1.0

-----------------------------------------

ABILITY_BEHAVIOR_NONE = 0x1
ABILITY_BEHAVIOR_HIDDEN = 0x2
ABILITY_BEHAVIOR_PASSIVE = 0x4
ABILITY_BEHAVIOR_NO_TARGET = 0x8
ABILITY_BEHAVIOR_UNIT_TARGET = 0x10
ABILITY_BEHAVIOR_POINT = 0x20
ABILITY_BEHAVIOR_AOE = 0x40
ABILITY_BEHAVIOR_NOT_LEARNABLE = 0x80
ABILITY_BEHAVIOR_CHANNELLED = 0x100
ABILITY_BEHAVIOR_ITEM = 0x200
ABILITY_BEHAVIOR_TOGGLE = 0x400
ABILITY_BEHAVIOR_DIRECTIONAL = 0x800
ABILITY_BEHAVIOR_IMMEDIATE = 0x1000
ABILITY_BEHAVIOR_AUTOCAST = 0x2000
ABILITY_BEHAVIOR_OPTIONAL_UNIT_TARGET = 0x4000
ABILITY_BEHAVIOR_OPTIONAL_POINT = 0x8000
ABILITY_BEHAVIOR_OPTIONAL_NO_TARGET = 0x10000
ABILITY_BEHAVIOR_AURA = 0x20000
ABILITY_BEHAVIOR_ATTACK = 0x40000
ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT = 0x80000
ABILITY_BEHAVIOR_ROOT_DISABLES = 0x100000
ABILITY_BEHAVIOR_UNRESTRICTED = 0x200000
ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE = 0x400000
ABILITY_BEHAVIOR_IGNORE_CHANNEL = 0x800000
ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT = 0x1000000
ABILITY_BEHAVIOR_DONT_ALERT_TARGET = 0x2000000
ABILITY_BEHAVIOR_DONT_RESUME_ATTACK = 0x4000000
ABILITY_BEHAVIOR_NORMAL_WHEN_STOLEN = 0x8000000
ABILITY_BEHAVIOR_IGNORE_BACKSWING = 0x10000000
ABILITY_BEHAVIOR_RUNE_TARGET = 0x20000000
ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL = 0x40000000
ABILITY_BEHAVIOR_VECTOR_TARGETING = 0x80000000
ABILITY_BEHAVIOR_LAST_RESORT_POINT = 0x100000000

------

PURCHASE_ITEM_SUCCESS = 1
PURCHASE_ITEM_DISALLOWED_ITEM = 2
