--[[
  author by soniceryd
  Date:2016/07/09
  Desc:request VO
]]--
local main = {}
local request = require "luaweb.vo.request"
local restfulRouter = require "luaweb.route.restfulRouter"

  function main:run()
    restfulRouter:new(request:new()):route()()
  end

return main