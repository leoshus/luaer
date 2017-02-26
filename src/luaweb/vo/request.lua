--[[
  author by soniceryd
  Date:2016/07/09
  Desc:request VO
]]--
local _M = {}
  _M.version = "0.0.1"
  
  function _M:new()
    local instance = {
       uri = ngx.var.uri
    }
    setmetatable(instance,{__index=self})
    return instance    
  end
  
  function _M:getMethod()
    if self.method == nil then
      return ngx.var.request_method
    end
    return self.method
  end
  
--[[
  body may get buffered in a temp file
]]--
local function getParamFromTmpFile()
    local function getFile(fileName)
      local f = assert(io.open(fileName,'r'))
      local str = f:read("*all")
      f:close()
      return str
    end
   local file = ngx.req.get_body_file()
   if file then
       return getFile(file)
   else
       return nil
   end
end

  function _M:buildParams()
    local params = {}
    if "GET" == self:getMethod() then
      for k,v in pairs(ngx.req.get_uri_args())do
        params[k]=v
      end
    elseif "POST" == _M:getMethod() then
       ngx.req.read_body()
       params = ngx.req.get_body_data()
    end
    if not params then
      local tmp = getParamFromTmpFile()
      if tmp then
        params = tmp
      end
    end
    self.params = params
    return self.params
  end
  
  function _M:getParams()
    if self.params ~= nil then return self.params end
    return self:buildParams()
  end
  function _M:setParam(key,value)
    if self.params == nil then self:buildParams()end
    self.params[key] = value
  end
  
  function _M:getHeader(header_name)
    return ngx.req.get_headers()[header_name];
  end

  function _M:isGet()
    if self:getMethod() == "GET" then return true else return false end
  end

  function _M:isPost()
    if self:getMethod() == "POST" then return true else return false end
  end
return _M