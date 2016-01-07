local Set = {}
Set.mt = {}
function Set.new(t)
  local set = {}
  setmetatable(set,Set.mt)
  for _, v in ipairs(t) do
    set[v] = true
  end
  return set
end

function Set.union(t1,t2)
  local result = Set.new{}
  for i in pairs(t1) do result[i] = true end
  for i in pairs(t2) do result[i] = true end
  return result
end

Set.mt.__add = Set.union

return Set