require ("com.sdw.test.Flexihash")
local flexihash = nil;

local redis_server = {"127.0.0.1:6380", "127.0.0.1:6381", "127.0.0.1:6382", "127.0.0.1:6383"}

function split(s, p)
  local sen_list = {}
  string.gsub(s, '[^'..p..']+', function(w) table.insert(sen_list, w) end )
  return sen_list
end
-- 根据key hash redis 实例
local function init_flexihash(parameters)
  flexihash = Flexihash.New();
  flexihash:addTargets(redis_server)
end

-- 根据key hash redis 实例
function get_redis_cli(key)
  if (flexihash == nil) then
    init_flexihash();
  end
  local server = flexihash:lookup(key);
  server = split(server, ':')
  local host =  server[1]
  local port =  server[2]
  print(server)
end

print(get_redis_cli("sdf"))