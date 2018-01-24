local attack = require(
  GetScriptDirectory() .."/utility/attack")

function Think()
  attack.Attack(GetBot())
end
