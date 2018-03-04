HEADER = """
local M = {}
"""

FOOTER = """
}

return M
"""
#---------------------------------------------

HEROES_HEADER = """
M.HEROES = {
"""

HEROES = """
  <0> = {
    positions = {<1>, <2>},
    attribute = "<3>",
    damage_type = "<4>",
    attack_range = "<5>",
    available_skills = {
      "<6>",
      "<7>",
      "<8>",
      "<9>",
    },
    available_auras = {
      "<10>"
    },
    required_skills = {
      "<11>",
      "<12>",
      "<13>",
    },
    required_auras = {
      "<14>",
      "<15>",
      "<16>",
    },
  },
"""

#---------------------------------------------

ITEM_SETS_HEADER = """
M.ITEM_SETS = {
"""

ITEM_SETS = """
  <0> = {
    components = {
      "<1>",
      "<2>",
      "<3>",
      "<4>"}
  },
"""

#---------------------------------------------

ITEM_BUILDS_HEADER = """
M.ITEM_BUILDS = {
"""

ITEM_BUILDS = """
  <0> = {
    items = {
      "<1>",
      "<2>",
      "<3>",
      "<4>",
      "<5>",
      "<6>",
      "<7>",
      "<8>",
      "<9>"}
  },
"""

#---------------------------------------------

ITEM_SELL_HEADER = """
M.ITEM_SELL = {
"""

ITEM_SELL = """
  <0> = {
    level = <1>,
    time = <2>
  },
"""

#---------------------------------------------

SKILL_BUILDS_HEADER = """
M.SKILL_BUILDS = {
"""

SKILL_BUILDS = """
  <0> = {
    abilities = {
      [1] = <1>,
      [2] = <2>,
      [3] = <3>,
      [4] = <4>,
      [5] = <5>,
      [6] = <6>,
      [7] = <7>,
      [8] = <8>,
      [9] = <9>,
      [10] = <10>,
      [11] = <11>,
      [12] = <12>,
      [13] = <13>,
      [14] = <14>,
      [15] = <15>,
      [16] = <16>,
      [18] = <17>,
      [20] = <18>,
      [25] = <19>
    }
  },
"""

#---------------------------------------------

SKILL_USAGE_HEADER = """
M.SKILL_USAGE = {
"""

SKILL_USAGE = """
  <0> = {
      [1] = "<1>",
      [2] = "<2>",
      [3] = "<3>",
      [4] = "<4>"
  },
"""

#---------------------------------------------

SKILL_GROUPS_HEADER = """
local algorithms = require(
  GetScriptDirectory() .. "/utility/ability_usage_algorithms")

M.SKILL_GROUPS = {
"""

SKILL_GROUPS = """
  <0> = {
      any_mode = {algorithms["<1>"], <2>},
      team_fight = {algorithms["<3>"], <4>},
      BOT_MODE_ROAM = {algorithms["<5>"], <6>},
      BOT_MODE_TEAM_ROAM = {algorithms["<7>"], <8>},
      BOT_MODE_PUSH_TOWER = {algorithms["<9>"], <10>},
      BOT_MODE_ATTACK = {algorithms["<11>"], <12>},
      BOT_MODE_LANING = {algorithms["<13>"], <14>},
      BOT_MODE_ROSHAN = {algorithms["<15>"], <16>},
      BOT_MODE_FARM = {algorithms["<17>"], <18>},
      BOT_MODE_DEFEND_TOWER = {algorithms["<19>"], <20>},
      BOT_MODE_DEFEND_ALLY = {algorithms["<21>"], <22>},
      BOT_MODE_RETREAT = {algorithms["<23>"], <24>},
      BOT_MODE_EVASIVE_MANEUVERS  = {algorithms["<25>"], <26>}
  },
"""

#---------------------------------------------

TEAM_DESIRES_HEADER = """
M.TEAM_DESIRES = {
"""

TEAM_DESIRES = """
  <0> = {
    BOT_MODE_PUSH_TOWER_TOP = {<1>, <2>},
    BOT_MODE_PUSH_TOWER_MID = {<3>, <4>},
    BOT_MODE_PUSH_TOWER_BOT = {<5>, <6>},
    BOT_MODE_TEAM_ROAM = {<7>, <8>},
    BOT_MODE_DEFEND_TOWER_TOP = {<9>, <10>},
    BOT_MODE_DEFEND_TOWER_MID = {<11>, <12>},
    BOT_MODE_DEFEND_TOWER_BOT = {<13>, <14>},
    BOT_MODE_ROSHAN = {<15>, <16>},
  },
"""

#---------------------------------------------

PLAYER_DESIRES_HEADER = """
M.PLAYER_DESIRES = {
"""

PLAYER_DESIRES = """
  <0> = {
    BOT_MODE_PUSH_TOWER_TOP = {<1>, <2>},
    BOT_MODE_PUSH_TOWER_MID = {<3>, <4>},
    BOT_MODE_PUSH_TOWER_BOT = {<5>, <6>},
    BOT_MODE_RETREAT = {<7>, <8>},
    BOT_MODE_TEAM_ROAM = {<9>, <10>},
    BOT_MODE_ATTACK  = {<11>, <12>},
    BOT_MODE_EVASIVE_MANEUVERS = {<13>, <14>},
    BOT_MODE_LANING = {<15>, <16>},
    BOT_MODE_DEFEND_TOWER_TOP = {<17>, <18>},
    BOT_MODE_DEFEND_TOWER_MID = {<19>, <20>},
    BOT_MODE_DEFEND_TOWER_BOT = {<21>, <22>},
    BOT_MODE_FARM = {<23>, <24>},
    BOT_MODE_ROSHAN = {<25>, <26>},
  },
"""

#---------------------------------------------

ATTACK_TARGET_HEADER = """
M.ATTACK_TARGET = {
"""

ATTACK_TARGET = """
  <0> = {
      BOT_MODE_ROAM = <1>,
      BOT_MODE_TEAM_ROAM = <2>,
      BOT_MODE_PUSH_TOWER = <3>,
      BOT_MODE_ATTACK = <4>,
      BOT_MODE_NONE = <5>,
      BOT_MODE_LANING = <6>,
      BOT_MODE_ROSHAN = <7>,
      BOT_MODE_FARM = <8>,
      BOT_MODE_DEFEND_TOWER = <9>,
      BOT_MODE_RETREAT = <10>,
      BOT_MODE_DEFEND_ALLY = <11>
  },
"""
