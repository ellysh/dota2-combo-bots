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
