local attack = require(
  GetScriptDirectory() .."/utility/attack")

function Think()
  attack.Attack(GetBot(), bot:GetCurrentVisionRange())
end
