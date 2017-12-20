#---------------------------------------------

HEROES_HEADER = """
local M = {}

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
    name = "<0>",
    combo_heroes = {
      "<1>",
      "<2>",
      "<3>",
      "<4>"}
  },
"""

ITEM_RECIPE_FOOTER = """
}

return M
"""

