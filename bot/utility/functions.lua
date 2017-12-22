local M = {}

local INVENTORY_SIZE = 8

local function GetItemSlotsCount()
  local result = 0

  for i = 0, INVENTORY_SIZE, 1 do
    local item = npc_bot:GetItemInSlot(i)
    if item ~= nil then
      result = result + 1
    end
  end

  return result
end

function M.IsItemSlotsFull(npc_bot)
  return INVENTORY_SIZE <= GetItemSlotsCount()
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

M.test_GetItemSlotsCount = GetItemSlotsCount

return M
