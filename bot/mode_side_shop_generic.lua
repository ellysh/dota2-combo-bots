local mode_shop = require(
  GetScriptDirectory() .."/utility/mode_shop")

function GetDesire()
  return mode_shop.GetDesire()
end

function Think()
  mode_shop.Think()
end

