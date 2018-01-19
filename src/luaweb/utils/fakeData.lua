--
-- Created by IntelliJ IDEA.
-- User: shangyindong
-- Date: 2018/1/19
-- Time: 10:28
--
--

--[[
fake  data
--]]


local redis = require "resty.redis"
local red = redis:new()
local rate = 10000000 -- 统计时长内的次数上限
local expires = 2 * 60 * 60 -- 统计时长
local badExpires = 2 * 60 * 60 --封禁时长
local whiteIp = {""}
local blackIp = {""}
local redisClient = require ("utils.redisClient"):new({hostIp="xxx.xxx.xxx",hostPort=6379,hostPasswd="xxx"});
-- fake json
local fakeJson = [[
                {
                    "code": 200,
                    "data": {
                        "hello": "world"
                    },
                    "message": "操作成功"
                }
        ]]
--[[
@param str 待分割字符串
@param delimiter 分割字符
--]]
function StringSplit(str,delimiter)
    if str == nil or str == "" or delimiter == nil then
        return nil
    end
    local result = {}
    for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result,match)
    end
    return result
end

function check_black_Ip (t,ip)
    for _,v in pairs(t) do
        if(v == ip) then
            return true
        end
    end
    return false
end

local myIp = ngx.req.get_headers()["X-Real-IP"]
if myIp == nil then
    myIp = ngx.req.get_headers()["X-Forwarded-For"]
    if myIp then
        ngx.log(ngx.ERR,tostring(myIp))
        local ips = StringSplit(tostring(myIp),",")
        myIp = ips[1]
    end
end

if myIp == nil then
    myIp = ngx.var.remote_addr
end

if myIp ~= nil then

    local match = ngx.re.match(myIp,"106\\.75.+","o")
    if match or check_black_Ip(blackIp,myIp)then
        ngx.log(ngx.ERR,"FIND FORBBIDEN IP:" .. myIp)

        ngx.header["content-type"]="application/json;charset=UTF-8"
        ngx.say(fakeJson)
        ngx.exit(ngx.HTTP_OK)
    end
    local accKey = accIp .. ":" .. myIp
    local badIp = denyIp .. ":" .. myIp

    local badRate = redisClient:exec("get",badIp)

    if badRate and tostring(badRate) ~= "userdata: (nil)" and tostring(badRate) ~= "userdata: NULL" then -- current is bad Ip
        ngx.exit(ngx.HTTP_NOT_FOUND)
    else
        local accessNum = redisClient:exec("get",accKey);
        if (not accessNum) or tostring(accessNum) == "userdata: (nil)" or tostring(accessNum) == "userdata: NULL" then
            redisClient:exec("setex",accKey,expires,1)
        else
            accessNum = tonumber(accessNum,10) or 0;
            if accessNum >= rate then -- over the limit
                redisClient:exec("setex",badIp,badExpires,1)
                redisClient:exec("del",accKey)
                ngx.exit(ngx.HTTP_NOT_FOUND)
            else
                redisClient:exec("incr",accKey)
            end
        end
    end


else
    --TODO Ip is nil

end
