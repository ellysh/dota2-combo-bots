package.path = package.path .. ";../utility/?.lua"
require("global_functions")
local ability_item_usage_utility = require("ability_item_usage_utility")

ability_item_usage_utility.UseGlyph(GetBot())

hero, value = ability_item_usage_utility.GetHeroWith(
    GetBot(),
    'min',
    'GetHealth',
    1200,
    true)

assert((hero:GetUnitName() == "test"), "GetHeroWith() - failed")
assert((value == 100), "GetHeroWith() - failed")

ability_item_usage_utility.UseWard(
  GetBot(),
  "shadow_shaman_mass_serpent_ward")

ability_item_usage_utility.UseChanneledSingleDisable(
  GetBot(),
  "shadow_shaman_shackles")

ability_item_usage_utility.UseSingleDisable(
  GetBot(),
  "shadow_shaman_voodoo")

ability_item_usage_utility.UseMultiNuke(
  GetBot(),
  "shadow_shaman_ether_shock")

ability_item_usage_utility.UseChanneledNoTargetDisable(
  GetBot(),
  "ability_item_usage_utility")
