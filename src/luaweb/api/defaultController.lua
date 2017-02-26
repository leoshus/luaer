--[[
  author by soniceryd
  Date:2016/08/04
  Desc:deafult controller
]]--

local default = {}

  function default.index()
    ngx.exit(ngx.HTTP_NOT_FOUND)
  end

return default
