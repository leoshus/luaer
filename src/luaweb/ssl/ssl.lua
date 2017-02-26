--[[
  author by soniceryd
  Date:2017/02/26
  Desc:redis client
]]--

local ssl = require "ngx.ssl"
local redisClient = require "luaweb.utils.redisClient":new({hostIp="127.0.0.1",hostPort=6379,hostPasswd=""})
ssl.clear_certs();

local server_name = ssl.server_name()
if server_name == nil then
  server_name = string.format("%d.%d.%d.%d", byte(addr, 1), byte(addr, 2), byte(addr, 3), byte(addr, 4))
  ngx.log(ngx.INFO, "IP Address: ", server_name)
end
ngx.log(ngx.ERR,"receive the server name is :",server_name)

function load_key_data()
  local key_data = nil
  local key_f = io.open(string.format("/Users/shangyd/app/openresty/nginx/conf/ssl/%s.der",server_name),"r")
  if key_f then
   key_data = key_f:read("*a")
   key_f:close()
  end
  local ok,err = redisClient:exec("hset",server_name,"key_data",key_data)
  if not ok then
    ngx.log(ngx.ERR,"fail save private key to redis",err)
    return
  end
  return key_data
end

function load_cert_data()
  local cert_data = nil
  local cert_f = io.open(string.format("/Users/shangyd/app/openresty/nginx/conf/ssl/%s.crt",server_name),"r")
  if cert_f then
    cert_data = cert_f:read("*a")
    cert_f:close()
  end
  local cert_der_data = ssl.cert_pem_to_der(cert_data)
  local ok,err = redisClient:exec("hset",server_name,"cert_data",cert_der_data)
  if not ok then
    ngx.log(ngx.ERR,"fail save cert to redis:",err)
    return
  end
  if not cert_der_data then
    ngx.log(ngx.ERR,"fail to convert private key from pem to der")
    return
  end
  return cert_der_data
end
local key_data = nil
local cert_der_data = nil
local res ,err = redisClient:exec("hmget",server_name,"key_data","cert_data")
if res then
  for k,v in pairs(res) do
    if k and k == 1 and not v and v ~= "null" then
       key_data = v
    else
       key_data = load_key_data()
    end
    if k and k == 2 and not v and v ~= "null" then
      cert_der_data = v
    else
      cert_der_data = load_cert_data()
    end
    
  end
else
  ngx.log(ngx.ERR,"fail read data from redis:",err) 
  key_data = load_key_data()
  cert_der_data = load_cert_data()
end

if key_data and cert_der_data then
  local ok,err = ssl.set_der_priv_key(key_data)
  if not ok then
    ngx.log(ngx.ERR,"fail to set Der priv key:",err)
    return
  end
  local ok,err = ssl.set_der_cert(cert_der_data)
  if not ok then
    ngx.log(ngx.ERR,"fail to set Der Cert:",err)
    return
  end
  return
 end