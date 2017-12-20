#---------------------------------------------

HEROES_HEADER = """
local M = {}

M.HEROES = {
"""

HERO = """
  {
    name = "<hero>",
    position = {<position1>, <position2>},
    combo_heroes = {
      "<combo1>",
      "<combo2>",
      "<combo3>"
    },
    counter_heroes = {
      "<counter1>",
      "<counter2>",
      "<counter3>"
    }
  },
"""

HEROES_FOOTER = """
}

return M
"""

#---------------------------------------------

ITEM_RECIPE_HEADER = """
local M = {}

M.ITEM_RECIPE = {
"""

ITEM_RECIPE = """
  {
    name = "<item>",
    combo_heroes = {
      "<component1>",
      "<component2>",
      "<component3>",
      "<component4>"}
  },
"""

ITEM_RECIPE_FOOTER = """
}

return M
"""

