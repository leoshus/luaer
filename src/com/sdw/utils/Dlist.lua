--双向队列
local Dlist = {}

--[[
  initialize Dlist
--]]
function Dlist.new()
  return {first=0,last=-1}
end

--[[
  puhs left node
--]]
function Dlist.pushLeft(list,value)
  local first = list.first -1
  list.first = first
  list[first] = value
end

--[[
  push right node
--]]
function Dlist.pushRight(list,value)
  local last = list.last + 1
  list.last = last
  list[last] = value
end

--[[
  pop left node
--]]
function Dlist.popLeft(list)
  local first = list.first
  if first > list.last then
    return nil --list is empty
  end
  local result = list[first];
  list[first] = nil
  list.first = first + 1
  return result
end

--[[
    pop right node
--]]
function Dlist.popRight(list)
  local last = list.last
  if list.first > last then
    return nil --list is empty
  end
  local result = list[last]
  list[last] = nil
  list.last = last - 1
  return result
end

--[[
    当前Dlist是否为空
--]]
function Dlist.isEmpty(list)
  local first = list.first
  if first > list.last then
    return true
  end
    return false
end

return Dlist