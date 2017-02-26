--[[
  author by soniceryd
  Date:2017/02/26
  Desc:store ssl session in cache
]]--

local ssl_session = require "ngx.ssl.session"
local redisClient = require "luaweb.utils.redisClient":new({hostIp="127.0.0.1",hostPort=6379,hostPasswd=""})
