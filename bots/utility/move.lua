local M = {}

function M.Move(unit, target_location)
  unit:Action_MoveToLocation(target_location);
end

return M
