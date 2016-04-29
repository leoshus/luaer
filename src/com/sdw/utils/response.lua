--author by shangyindong
local json = require("cjson")
local response = {}
  
local function set(this,key,msg)
  this.res[key] = msg
end
-- 对返回的信息进行格式化
local function res_format(message)
  message = string.gsub(message, "\n", '&u006e;')
  message = string.gsub(message, '%c', "")
  message = string.gsub(message, "&u006e;", '\\n')
  return message
end

local function exit(this)
  -- 打印错误
  if (this.res['code'] ~= '1' and this.res['code'] ~= '2') then
    ngx.log(ngx.ERR, "error: ", this.res['msg'])
  end
  local message = json.encode(this.res)
  message = res_format(message)
  ngx.say(message)
  ngx.exit(ngx.HTTP_OK)
  --ngx.exit(ngx.OK)
end

-- 正常退出
local function success_exit(this,msg)
  set(this,'code','1')
  set(this,'msg',msg);
  exit(this)
end
-- 操作失败退出
local function error_exit(this,msg,code)
  code = code or '-1'
  set(this,'code',code)
  set(this,'msg',msg);
  exit(this)
end

-- ssi退出
local function ssi_exit(this,msg)
  ngx.say(msg)
  ngx.exit(ngx.HTTP_OK)
end

function response.new()
  local res = {}
  res['code'] = '1'
  local methods = {
    res = res,
    set = set,
    success_exit = success_exit,
    error_exit = error_exit,
    ssi_exit = ssi_exit
  }
  return methods
end

return response