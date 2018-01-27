package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local minions = require("minions")
local luaunit = require('luaunit')

function test_MinionThink_move_to_hero_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {500, 500}

  -- TODO: Finish this test
  --minions.MinionThink(Unit:new())
end

os.exit(luaunit.LuaUnit.run())
