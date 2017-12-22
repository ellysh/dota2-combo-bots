local item_purchase_utility = require(
  GetScriptDirectory() .."/utility/item_purchase_utility")

function ItemPurchaseThink()
  item_purchase_utility.PurchaseItem()
end
