package.path = package.path .. ";../?.lua"
require("global_functions")
require("item_purchase_juggernaut")

ItemPurchaseThink()

-- Buy an item_flask with 110 gold cost at the beginning
assert((TestBot.gold == 515), "ItemPurchaseThink() - failed")
