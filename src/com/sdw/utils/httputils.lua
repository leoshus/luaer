--author by shangyindong
local httputils = {}
local res = require("com.sdw.utils.response")
local response = res.new();
local request_method = ngx.var.request_method
local httpStatus = {}
httpStatus["SC_OK"] = {["code"]=200,["msg"]="success"}
httpStatus["SC_BAD_REQUEST"] = {["code"]=400,["msg"]="Bad Request"}
httpStatus["SC_UNAUTHORIZED"] = {["code"]=401,["msg"]="Unauthorized"}
httpStatus["SC_FORBIDDEN"] = {["code"]=403,["msg"]="Forbidden"}
httpStatus["SC_NOT_FOUND"] = {["code"]=404,["msg"]="Forbidden"}
httpStatus["SC_METHOD_NOT_ALLOWED"] = {["code"]=405,["msg"]="Method Not Allowed"}
httpStatus["SC_NOT_ACCEPTABLE"] = {["code"]=406,["msg"]="Not Acceptable"}
httpStatus["SC_PROXY_AUTHENTICATION_REQUIRED"] = {["code"]=407,["msg"]="Proxy Authentication Required"}
httpStatus["SC_REQUEST_TIMEOUT"] = {["code"]=408,["msg"]="Request Timeout"}
httpStatus["SC_CONFLICT"] = {["code"]=409,["msg"]="Conflict"}
httpStatus["SC_GONE"] = {["code"]=410,["msg"]="Gone"}
httpStatus["SC_LENGTH_REQUIRED"] = {["code"]=411,["msg"]="Length Required"}
httpStatus["SC_PRECONDITION_FAILED"] = {["code"]=412,["msg"]="Precondition Failed"}
httpStatus["SC_REQUEST_TOO_LONG"] = {["code"]=413,["msg"]="Request Entity Too Large"}
httpStatus["SC_REQUEST_URI_TOO_LONG"] = {["code"]=414,["msg"]="Request-URI Too Long"}
httpStatus["SC_UNSUPPORTED_MEDIA_TYPE"] = {["code"]=415,["msg"]="Unsupported Media Type"}
httpStatus["SC_REQUESTED_RANGE_NOT_SATISFIABLE"] = {["code"]=416,["msg"]="Requested Range Not Satisfiable"}
httpStatus["SC_EXPECTATION_FAILED"] = {["code"]=417,["msg"]="Expectation Failed"}
httpStatus["SC_INSUFFICIENT_SPACE_ON_RESOURCE"] = {["code"]=419,["msg"]="Proxy Reauthentication Required"}
httpStatus["SC_METHOD_FAILURE"] = {["code"]=420,["msg"]="Method Failure"}
httpStatus["SC_UNPROCESSABLE_ENTITY"] = {["code"]=422,["msg"]="Unprocessable Entity"}
httpStatus["SC_LOCKED"] = {["code"]=423,["msg"]="Locked"}
httpStatus["SC_FAILED_DEPENDENCY"] = {["code"]=424,["msg"]="Failed Dependency"}
httpStatus["SC_INTERNAL_SERVER_ERROR"] = {["code"]=500,["msg"]="Server Error"}
httpStatus["SC_NOT_IMPLEMENTED"] = {["code"]=501,["msg"]="Not Implemented"}
httpStatus["SC_BAD_GATEWAY"] = {["code"]=502,["msg"]="Bad Gateway"}
httpStatus["SC_SERVICE_UNAVAILABLE"] = {["code"]=503,["msg"]="Service Unavailable"}
httpStatus["SC_GATEWAY_TIMEOUT"] = {["code"]=504,["msg"]="Gateway Timeout"}
httpStatus["SC_HTTP_VERSION_NOT_SUPPORTED"] = {["code"]=505,["msg"]="HTTP Version Not Supported"}
httpStatus["SC_INSUFFICIENT_STORAGE"] = {["code"]=507,["msg"]="Insufficient Storage"}



local function getRequestParams(method)
  local args = nil;
  if method and method ~= request_method then
    response:error_exit("Method not support");
  end
  if "GET" == request_method then
    args = ngx.req.get_uri_args()
  elseif "POST" == request_method then
    ngx.req.read_body()
    args = ngx.req.get_post_args()
  end
  if not args then
    response:error_exit("Arguments is illegal");
  end
  return args
end

local function query(url)
  local res = ngx.location.capture(url)
  if res and res.status == 200 then
    return res.body
  end
  return nil
end

function httputils.new()
  local methods = {
    httpStatus = httpStatus,
    getRequestParams = getRequestParams,
    query = query
  }
  return methods
end

return httputils