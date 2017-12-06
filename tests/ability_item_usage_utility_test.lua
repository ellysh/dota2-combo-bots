package.path = package.path .. ";../utility/?.lua"
require("global_functions")
local ability_item_usage_utility = require("ability_item_usage_utility")

ability_item_usage_utility.UseGlyph()

hero, value = ability_item_usage_utility.GetHeroWith(
    GetBot(),
    'min',
    'GetHealth',
    1200,
    true)

assert((hero:GetUnitName() == "test"), "GetHeroWith() - failed")
assert((value == 100), "GetHeroWith() - failed")
