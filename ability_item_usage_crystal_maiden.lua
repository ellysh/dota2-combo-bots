local utility = require(
    GetScriptDirectory() .."/utility/ability_item_usage_utility")

function AbilityUsageThink()
  local npcBot = GetBot()

  utility.UseGlyph(npcBot)

  utility.UseChanneledNoTargetDisable(
    npcBot,
    "crystal_maiden_freezing_field")
  utility.UseAreaNuke(npcBot, "crystal_maiden_crystal_nova")
  utility.UseSingleDisable(npcBot, "crystal_maiden_frostbite")
end
