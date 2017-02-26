--[[
  author by soniceryd
  Date:2016/07/09
  Desc: restful route
]]--

local restful = {}
local ngxgsub = ngx.re.gsub
local ngxmatch = ngx.re.match
local http_methods = {
    GET = true,
    POST = true,
    HEAD = true,
    OPTIONS = true,
    PUT = true,
    PATCH = true,
    DELETE = true,
    TRACE = true,
    CONNECT = true
}
local function tableappend(t,v) t[#t+1] = v end
local function parseRule(pattern)
  local params = {}
  local regex = ngxgsub(pattern,"/:([A-Za-z0-9_]+)",function(p) tableappend(params,p[1]) return "/([A-Za-z0-9_]+)" end, "io")
  return regex,params
end
local function getRules(request)
  local ruleconf = require("conf.urlmapping")
  local requestMethod = request:getMethod()
  if not http_methods[requestMethod] then
    error("Request Method is not Right...")
  end
  local rules = {}
  if ruleconf["v1"] ~= nil and ruleconf["v1"][requestMethod] then
    for k,v in pairs(ruleconf["v1"][requestMethod]) do
          local pattern,params = parseRule(v['pattern'])
          rules[k] = v
          rules[k]['regex'] = "^" .. pattern .. "$"
          rules[k]['params'] = params
    end
  end
  return rules
end
function restful:match()
  local uri = self.request.uri
  local matchs = nil
  for k,v in pairs(self.rules) do
    matchs = ngxmatch(uri,v['regex'],"io")
    if matchs then
      local plen = #v['params']
      local mlen = #matchs
      if plen ~= mlen and plen < mlen then -- maches gt param's name,then use reverse 
      local tmp = #matchs - #v['params']
         for i,p in pairs(v['params'])do
          self.request:setParam(p,matchs[i + tmp])
         end
      else
         for i,p in pairs(v['params'])do
          self.request:setParam(p,matchs[i])
         end
      end
      return v['controller'],v['action'],self.request
    end
  end
  return "luaweb.api.defaultController","index",self.request
end

function restful:new(request)
  local instance = {
    route_name = "routes.restful",
    request = request,
    rules = getRules(request)
  }
  setmetatable(instance,{
    __index = self,
    __tostring = function(self) return self.route_name end
  })
  return instance
end

return restful