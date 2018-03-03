package.path = package.path .. ";../?.lua;;../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local hero_selection = require("hero_selection")
local functions = require("functions")
local luaunit = require('luaunit')

function test_Think()
  local hero_counter = {}

  RANDOM_ENABLE = true

  for i = 1, 100 do
    hero_selection.test_ResetTeamComposition(GetTeam())

    SELECTED_HEROES = {}

    RandomSeed()

    Think()
    Think()
    Think()
    Think()
    Think()

    for _, hero in pairs(SELECTED_HEROES) do
      if hero_counter[hero] == nil then
        hero_counter[hero] = 1
      else
        hero_counter[hero] = hero_counter[hero] + 1
      end
    end
  end

  for hero, counter in functions.spairs(hero_counter) do
    print("hero = " .. hero .. " counter = " .. tostring(counter))
  end
end

os.exit(luaunit.LuaUnit.run())
