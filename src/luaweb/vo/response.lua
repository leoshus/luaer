--[[
  author by soniceryd
  Date:2016/07/09
  Desc:response VO
]]--
local response = {}
local json = require("cjson")

 response.httpStatus = {
 ["SC_OK"] = {["code"]=200,["msg"]="success"},
 ["SC_BAD_REQUEST"] = {["code"]=400,["msg"]="Bad Request"},
 ["SC_UNAUTHORIZED"] = {["code"]=401,["msg"]="Unauthorized"},
 ["SC_FORBIDDEN"] = {["code"]=403,["msg"]="Forbidden"},
 ["SC_NOT_FOUND"] = {["code"]=404,["msg"]="Forbidden"},
 ["SC_METHOD_NOT_ALLOWED"] = {["code"]=405,["msg"]="Method Not Allowed"},
 ["SC_NOT_ACCEPTABLE"] = {["code"]=406,["msg"]="Not Acceptable"},
 ["SC_PROXY_AUTHENTICATION_REQUIRED"] = {["code"]=407,["msg"]="Proxy Authentication Required"},
 ["SC_REQUEST_TIMEOUT"] = {["code"]=408,["msg"]="Request Timeout"},
 ["SC_CONFLICT"] = {["code"]=409,["msg"]="Conflict"},
 ["SC_GONE"] = {["code"]=410,["msg"]="Gone"},
 ["SC_LENGTH_REQUIRED"] = {["code"]=411,["msg"]="Length Required"},
 ["SC_PRECONDITION_FAILED"] = {["code"]=412,["msg"]="Precondition Failed"},
 ["SC_REQUEST_TOO_LONG"] = {["code"]=413,["msg"]="Request Entity Too Large"},
 ["SC_REQUEST_URI_TOO_LONG"] = {["code"]=414,["msg"]="Request-URI Too Long"},
 ["SC_UNSUPPORTED_MEDIA_TYPE"] = {["code"]=415,["msg"]="Unsupported Media Type"},
 ["SC_REQUESTED_RANGE_NOT_SATISFIABLE"] = {["code"]=416,["msg"]="Requested Range Not Satisfiable"},
 ["SC_EXPECTATION_FAILED"] = {["code"]=417,["msg"]="Expectation Failed"},
 ["SC_INSUFFICIENT_SPACE_ON_RESOURCE"] = {["code"]=419,["msg"]="Proxy Reauthentication Required"},
 ["SC_METHOD_FAILURE"] = {["code"]=420,["msg"]="Method Failure"},
 ["SC_UNPROCESSABLE_ENTITY"] = {["code"]=422,["msg"]="Unprocessable Entity"},
 ["SC_LOCKED"] = {["code"]=423,["msg"]="Locked"},
 ["SC_FAILED_DEPENDENCY"] = {["code"]=424,["msg"]="Failed Dependency"},
 ["SC_INTERNAL_SERVER_ERROR"] = {["code"]=500,["msg"]="Server Error"},
 ["SC_NOT_IMPLEMENTED"] = {["code"]=501,["msg"]="Not Implemented"},
 ["SC_BAD_GATEWAY"] = {["code"]=502,["msg"]="Bad Gateway"},
 ["SC_SERVICE_UNAVAILABLE"] = {["code"]=503,["msg"]="Service Unavailable"},
 ["SC_GATEWAY_TIMEOUT"] = {["code"]=504,["msg"]="Gateway Timeout"},
 ["SC_HTTP_VERSION_NOT_SUPPORTED"] = {["code"]=505,["msg"]="HTTP Version Not Supported"},
 ["SC_INSUFFICIENT_STORAGE"] = {["code"]=507,["msg"]="Insufficient Storage"},

 ["SC_ILLEGAL_FORMAT_PARAM"] = {["code"]=40001,["msg"]="Parameter Format Invalid"},
 ["SC_THEAD_SIZE_OVER_LIMIT"] = {["code"]=40002,["msg"]="Thread Size Over limit"},
 ["SC_COMMENT_SIZE_OVER_LIMIT"] = {["code"]=40002,["msg"]="Comment Size Over limit"}
 }

-- format for message
local function res_format(message)
  message = string.gsub(message, "\n", '&u006e;')
  message = string.gsub(message, '%c', "")
  message = string.gsub(message, "&u006e;", '\\n')
  return message
end

  function response:exit(msg)
    if msg ~= nil then
      self.res['code'] = msg.code or 1
      self.res['msg'] = msg.msg or ""
    end
    ngx.say(res_format(json.encode(self.res)))
    ngx.exit(ngx.HTTP_OK)
  end

function response:write(msg,content_type)
    ngx.header["content-type"]=content_type
    ngx.say(msg)
    ngx.exit(ngx.HTTP_OK)
end
  function response:new()
    local instance = {
      version = "0.0.1",
      res = {code=1,msg="200"}
    }
    setmetatable(instance,{__index = self})
    return instance 
  end

return response