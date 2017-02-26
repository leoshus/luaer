--[[
  author by soniceryd
  Date:2017/02/26
  Desc:classic object
]]--

local object = {}

object.__index = object
function object:new()
  print("start...")
  for k,v in ipairs(self) do
      print(k,v)
  end
  print("end...")
end

return object