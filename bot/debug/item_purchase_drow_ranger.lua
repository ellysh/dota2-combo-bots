-- TODO: Move this code to the item_purchase_generic.lua script.
-- Remove this file.

local item_purchase = require(
  GetScriptDirectory() .."/utility/item_purchase")

function ItemPurchaseThink()
  item_purchase.ItemPurchaseThink()
end
