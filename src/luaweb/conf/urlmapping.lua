--[[
  author by soniceryd
  Date:2016/07/09
  Desc: urlmapping configuration
]]--
local urlmapping = {
  v1 = {}
}

urlmapping.v1.GET = {
  {pattern="/default",controller="luaweb.api.default.Contoller",action="index"}
}

return urlmapping