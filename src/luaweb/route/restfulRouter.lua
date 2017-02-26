--[[
  Date 2016/08/04
  Author soniceryd
  Desc 
]]--
local restfulRoute = require("luaweb.route.restful")
local restfulRouter = {}
  
function restfulRouter:new(request)
  local instance = {
    routes = {restfulRoute:new(request)}
  }  
  setmetatable(instance,{__index = self})
  return instance
end

function restfulRouter:route()
  if self.routes ~= nil and #self.routes >= 1 then
    for k,route in ipairs(self.routes) do
      local require_name,action,request = nil
      local ok = pcall(function(route)require_name,action,request = route:match() end,route)
      if ok and require_name ~= nil and action ~= nil and type(require(require_name)[action]) == 'function' then
        return function()
            require(require_name)[action](request)
          end
      else
        return function()
            ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
        end
      end
    end
  end
end
return restfulRouter