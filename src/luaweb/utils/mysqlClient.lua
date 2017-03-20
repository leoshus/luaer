--
-- Created by IntelliJ IDEA.
-- User: shangyindong
-- Date: 2017/3/20
-- Time: 17:47
--
--usage: local mysql = mysqlClient:new({host="",port=3306,database="",user="",password=""})



local mysql = require "resty.mysql"
local mysqlClient = {}

function mysqlClient:new(info)
    info = info or {}
    setmetatable(info,{__index=self})
    return info
end
function mysqlClient:queryData(sql,nrow)
    local db ,err = mysql:new()

    if not db then
        ngx.say("failed to instantiate mysql:",err)
        return
    end

    db:set_timeout(1000) -- 1sec

    local ok,err,errcode,sqlstate = db:connect({
        host = self.host,
        port = self.port,
        database = self.database,
        user = self.user,
        password = self.password,
        max_packet_size = self.max_packet_size or 1024 * 1024
    })

    if not ok then
        ngx.say("failed to connect:",err,": ",errcode," ",sqlstate)
        return
    end

    local res,err,errcode,sqlstate = db:query(sql,nrow or 1)
    if not res then
        ngx.say("bad result:",err,": ",errcode,": ",sqlstate,".")
        return
    end
    --ngx.say("result:",cjson.encode(res))

    local ok ,err = db:set_keepalive(10000,100)
    if not ok then
        ngx.say("failed to set keepalive :",err)
        return
    end
    return res
end



return mysqlClient