--[[
  Date:2016/07/09
  simple Logger
]]--
local easylog = {}

  easylog.version = "0.0.1"
  function easylog.log(logfile,msg)
    write(logfile,msg)
  end

  local function write(logfile,msg)
    local fd = io.open(logfile,"ab")
    if nil == fd then return end
    fd:write(msg)
    fd:flush()
    fd:close()
  end
  
  function easylog.info(msg)
    ngx.log(ngx.INFO,msg)
  end
  function easylog.error(msg)
    ngx.log(ngx.ERR,msg)
  end
return easylog