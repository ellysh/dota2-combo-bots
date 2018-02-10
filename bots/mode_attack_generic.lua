local attack = require(
  GetScriptDirectory() .."/utility/attack")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

function Think()
  attack.Attack(GetBot(), constants.MAX_GET_UNITS_RADIUS)
end
