package.path = package.path .. ";../?.lua"
require("global_functions")
require("hero_selection")

Think()

assert((SelectedHero[1] == "npc_dota_hero_juggernaut"), "Think() - failed")
assert((SelectedHero[2] == "npc_dota_hero_obsidian_destroyer"), "Think() - failed")
assert((SelectedHero[3] == "npc_dota_hero_bristleback"), "Think() - failed")
assert((SelectedHero[4] == "npc_dota_hero_shadow_shaman"), "Think() - failed")
assert((SelectedHero[5] == "npc_dota_hero_crystal_maiden"), "Think() - failed")

local laneAssignment = UpdateLaneAssignments()

assert((laneAssignment[1] == LANE_BOT), "UpdateLaneAssignments() - failed")
assert((laneAssignment[2] == LANE_MID), "UpdateLaneAssignments() - failed")
assert((laneAssignment[3] == LANE_TOP), "UpdateLaneAssignments() - failed")
assert((laneAssignment[4] == LANE_BOT), "UpdateLaneAssignments() - failed")
assert((laneAssignment[5] == LANE_TOP), "UpdateLaneAssignments() - failed")
