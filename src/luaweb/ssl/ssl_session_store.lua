--[[
  author by soniceryd
  Date:2017/02/26
  Desc:store ssl session in cache
]]--

local ssl_session = require "ngx.ssl.session"
local redisClient = require "luaweb.utils.redisClient":new({hostIp="127.0.0.1",hostPort=6379,hostPasswd=""})
local ssl_session_id,err = ssl_session.get_session_id()
if not ssl_session_id then
  ngx.log(ngx.ERR,"fail to fetch ssl_session_id :",err)
  return
end

local session,err = ssl_session.get_serialized_session()
if not session then
  ngx.log(ngx.ERR,"fail to fetch sesssion cause by:",err)
  return
end


local function save_session(ssl_session_id,session)
  redisClient:exec("set",ssl_session_id,session)
end


local ok,err = ngx.timer.at(0,save_session,ssl_session_id,session)
if not ok then
  ngx.log(ngx.ERR,"failed to create a 0-delay timer cause by :",err)
  return
end
