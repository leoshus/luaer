--[[
  author by soniceryd
  Date:2017/02/26
  Desc:fetch ssl session which store in cache
]]--
local ssl_session = require "ngx.ssl.session"
local redisClient = require "luaweb.utils.redisClient":new({hostIp="127.0.0.1",hostPort=6379,hostPasswd=""})
local ssl_session_id,err = ssl_session.get_session_id()
ngx.log(ngx.ERR,"ssl session id is=",ssl_session_id)
if not ssl_session_id then
  ngx.log(ngx.ERR,"fail fetch ssl session id:",err)
  return
end

local session = fetchSession(ssl_session_id)
if not session then
  ngx.log(ngx.ERR,"fail to fetch session from internal-cache by ssl_session_id=",ssl_session_id)
  return
end

local ok,err = ssl_session.set_serialized_session(session)
if not ok then
  ngx.log(ngx.ERR,"fail to set ssl_sesion for ssl_session_id:",ssl_session_id," cause by :",err)
  return
end

function fetchSession(ssl_session_id)
  return redisClient:exec("get",ssl_session_id)
end