local mode_shop = require(
  GetScriptDirectory() .."/utility/mode_shop")

function GetDesire()
  return mode_shop.GetDesireSideShop()
end

function Think()
  mode_shop.ThinkSideShop()
end

