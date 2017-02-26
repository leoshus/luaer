--[[
  author by soniceryd
  Date:2017/02/26
  Desc:redis client
]]--

local ssl = require "ngx.ssl"
local resty_lock = require "resty.lock"

ssl.clear_certs();

local server_name = ssl.server_name()
if server_name == nil then
  server_name = string.format("%d.%d.%d.%d", byte(addr, 1), byte(addr, 2), byte(addr, 3), byte(addr, 4))
  ngx.log(ngx.INFO, "IP Address: ", server_name)
end
ngx.log(ngx.ERR,"receive the server name is :",server_name)

local key_data = nil
local key_f = io.open(string.format("/Users/shangyd/app/openresty/nginx/conf/ssl/%s.der",server_name),"r")
if key_f then
 key_data = key_f:read("*a")
 key_f:close()
end

local cert_data = nil
local cert_f = io.open(string.format("/Users/shangyd/app/openresty/nginx/conf/ssl/%s.crt",server_name),"r")
if cert_f then
  cert_data = cert_f:read("*a")
  cert_f:close()
end

local cert_der_data = ssl.cert_pem_to_der(cert_data)
if not cert_der_data then
  ngx.log(ngx.ERR,"fail to convert private key from pem to der")
  return
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