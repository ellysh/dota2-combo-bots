local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

-- Indexes in resulting array do not match to slot indexes.
-- You should shift them -1 to match the slot indexes.
function M.GetItems(npc_bot, slot_numbers)
  local item_list = {}
  local items_number = 0

  for i = 0, slot_numbers, 1 do
    local item = npc_bot:GetItemInSlot(i)
    if item ~= nil and item:GetName() ~= "nil" then
      items_number = items_number + 1
      table.insert(item_list, item:GetName())
    else
      table.insert(item_list, "nil")
    end
  end

  return items_number, item_list
end

local function GetItemSlotsCount(npc_bot)
  local result, _ = M.GetItems(npc_bot, constants.INVENTORY_SIZE)
  return result
end

function M.IsItemSlotsFull(npc_bot)
  return constants.INVENTORY_SIZE <= GetItemSlotsCount(npc_bot)
end

function M.GetElementIndexInList(element, list)
  for i, e in pairs(list) do
    if e == element then return i end
  end
  return -1
end

function M.IsElementInList(element, list)
  return M.GetElementIndexInList(element, list) ~= -1
end

function M.IsBotBusy(npc_bot)
  return npc_bot:IsChanneling()
        or npc_bot:IsUsingAbility()
        or npc_bot:IsCastingAbility()
end

-- Provide an access to local functions for unit tests only
M.test_GetItemSlotsCount = GetItemSlotsCount

return M
