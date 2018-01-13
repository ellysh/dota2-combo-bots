local mode_shop = require(
  GetScriptDirectory() .."/utility/mode_shop")

function GetDesire()
  return mode_shop.GetDesireSecretShop()
end

function Think()
  mode_shop.ThinkSecretShop()
end
