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

