--[[
  Date:2016/07/09
  For OOP
]]--
local Class = {}

function Class.New(base_class)
  base_class = base_class or {}
  local new_class = {}
  setmetatable(new_class,{
    __index = function(table,key)
      local v = rawget(table,key)
      if v then
        return v
      end
      v = base_class[key]
      if v then
        return v
      end
    end
  })
end

return Class