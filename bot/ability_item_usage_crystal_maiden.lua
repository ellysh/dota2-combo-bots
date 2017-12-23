local utility = require(
    GetScriptDirectory() .."/utility/ability_item_usage")

local Abilities = {}

utility.InitAbilities(GetBot(), Abilities)

function AbilityUsageThink()
  local npcBot = GetBot()

  utility.UseGlyph(npcBot)

  utility.UseAbility(npcBot, Abilities)
end
