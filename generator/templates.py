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
  {
    name = "<0>",
    position = {<1>, <2>},
    combo_heroes = {
      "<3>",
      "<4>",
      "<5>"
    },
    counter_heroes = {
      "<6>",
      "<7>",
      "<8>"
    }
  },
"""

#---------------------------------------------

ITEM_RECIPE_HEADER = """
M.ITEM_RECIPE = {
"""

ITEM_RECIPE = """
  <0> = {
    components = {
      "<1>",
      "<2>",
      "<3>",
      "<4>"}
  },
"""

#---------------------------------------------

ITEM_BUILD_HEADER = """
M.ITEM_BUILD = {
"""

ITEM_BUILD = """
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
      "<9>",
      "<10>"}
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

SKILL_BUILD_HEADER = """
M.SKILL_BUILD = {
"""

SKILL_BUILD = """
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
      [11] = <10>,
      [12] = <11>,
      [13] = <12>,
      [14] = <13>,
      [16] = <14>,
      [18] = <15>
    },
    talents = {
      [10] = <16>,
      [15] = <17>,
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
      any_mode = <1>,
      team_fight = <2>,
      BOT_MODE_ROAM = <3>,
      BOT_MODE_PUSH_TOWER = <4>,
      BOT_MODE_ATTACK = <5>,
      BOT_MODE_LANING = <6>,
      BOT_MODE_FARM = <7>,
      BOT_MODE_DEFEND_TOWER = <8>,
      BOT_MODE_RETREAT = <9>,
      BOT_MODE_DEFEND_ALLY = <10>
  },
"""
