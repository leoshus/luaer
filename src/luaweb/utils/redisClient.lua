--[[
  author by soniceryd
  Date:2017/02/26
  Desc:redis client
]]--

local redisClient = {}
local redis = require "resty.redis"
local response = require ("luaweb.vo.response"):new()
local redis_max_expires = 3 * 60 * 60
local redis_max_conn = 200

local function getRedisConnection(hostInfo)
    if not hostInfo or not hostInfo.hostIp or not hostInfo.hostPort or not hostInfo.hostPasswd then
        response:exit(response.httpStatus["SC_BAD_REQUEST"])
    end
    local red = redis:new()
    local ok,err = red:connect(hostInfo.hostIp,hostInfo.hostPort)
    if not ok then
        response:exit({code=500,message="Redis connect err " .. err})
    end
    if hostInfo ~= "" then
      local res,err = red:auth(hostInfo.hostPasswd)
    end
    return red
end

function redisClient:connect()
    if not self.hostInfo or not self.hostInfo.hostIp or not self.hostInfo.hostPort or not self.hostInfo.hostPasswd then
        response:exit(response.httpStatus["SC_BAD_REQUEST"])
    end
    local red = redis:new()
    local ok,err = red:connect(self.hostInfo.hostIp,self.hostInfo.hostPort)
    if not ok then
        response:exit({code=500,message="Redis connect err " .. err})
    end
    local res,err = red:auth(self.hostInfo.hostPasswd)
    return red
end

function redisClient:exec(cmd,key,...)
    local redis_cli = getRedisConnection(self.hostInfo)
    local res,err
    if (cmd == 'lrange') then
        res, err = redis_cli:lrange(key,...)
    elseif (cmd == 'sismember') then
        res, err = redis_cli:sismember(key,...)
    elseif (cmd == 'hget') then
        res, err = redis_cli:hget(key,...)
    elseif (cmd == 'hset') then
        res, err = redis_cli:hset(key,...)
    elseif (cmd == 'hmget') then
        res, err = redis_cli:hmget(key,...)
    elseif (cmd == 'hmset') then
        res, err = redis_cli:hmset(key,...)
    elseif (cmd == 'hlen') then
        res, err = redis_cli:hlen(key,...)
    elseif (cmd == 'lset') then
        res, err = redis_cli:lset(key,...)
    elseif (cmd == 'hexists') then
        res, err = redis_cli:hexists(key,...)
    elseif (cmd == 'smembers') then
        res, err = redis_cli:smembers(key)
    elseif (cmd == 'srem') then
        res, err = redis_cli:srem(key,...)
    elseif (cmd == 'llen') then
        res, err = redis_cli:llen(key,...)
    elseif (cmd == 'hgetall') then
        res, err = redis_cli:hgetall(key,...)
    elseif (cmd == 'hdel') then
        res, err = redis_cli:hdel(key,...)
    elseif (cmd == 'get') then
        res, err = redis_cli:get(key,...)
    elseif (cmd == 'hkeys') then
        res, err = redis_cli:hkeys(key,...)
    elseif (cmd == 'zadd') then
        res, err = redis_cli:zadd(key,...)
    elseif (cmd == 'zscore') then
        res, err = redis_cli:zscore(key,...)
    elseif (cmd == 'zincrby') then
        res, err = redis_cli:zincrby(key,...)
    elseif (cmd == 'setex') then
        res, err = redis_cli:setex(key,...)
    elseif (cmd == 'lpush') then
        res, err = redis_cli:lpush(key,...)
    elseif (cmd == 'rpush') then
        res, err = redis_cli:rpush(key,...)
    elseif (cmd == 'del') then
        res, err = redis_cli:del(key,...)
    elseif (cmd == 'expire') then
        res, err = redis_cli:expire(key,...)
    elseif (cmd == 'lrem') then
        res, err = redis_cli:lrem(key,...)
    end
    local ok, re = redis_cli:close()

    if not ok then
        ngx.log(ngx.ERR, "Redis close fail="..re)
    end
    return res,err
end


--deal redis pipeline data
local function init_pipeline_data(result)
    local data={}
    for key, value in ipairs(result) do--循环
        data[#data + 1]=value
    end
    return data
end

local function redis_back_pool(cache)
    local res, err = cache:set_keepalive(redis_max_expires, redis_max_conn)--put into thread pool,pool size 100 max idle time 150 seconds
    if not res then
        ngx.log(ngx.ERR, "failed to set redis keepalive: ", tostring(err))
        --    cache:close()
    end
end
--[[
   batch exec
]]--
function redisClient:batchExec(func)
    if not self.hostInfo or not self.hostInfo.hostIp or not self.hostInfo.hostPort or not self.hostInfo.hostPasswd then
        response:exit(response.httpStatus["SC_BAD_REQUEST"])
    end
    local red = redis:new()
    local ok,err = red:connect(self.hostInfo.hostIp,self.hostInfo.hostPort)
    if not ok then
        response:exit({code=500,message="Redis connect err " .. err})
    end
    red:init_pipeline() --open pipeline
    local res,err = red:auth(self.hostInfo.hostPasswd)
    func(red)
    local result,err = red:commit_pipeline() -- commit
    if not result then
        --    red:close()
        redis_back_pool(red)
        return {},err
    else
        local data = init_pipeline_data(result)
        redis_back_pool(red)
        return data,nil
    end
end

function redisClient:new(hostInfo)
    local client = {
        hostInfo = hostInfo,
    }
    setmetatable(client,{__index = self})
    return client;
end

return redisClient