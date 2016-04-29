--author by shangyindong
local map = {}
map.tables = {} 
map.indexs = {} --data index

--insert element if element absent
local function putIfAbsent(key,value)
  if(map.tables[key] == nil) then
    map.tables[key] = value
    table.insert(map.indexs,key)
  end
  return map.tables;
end

--insert element override data forcely
local function put(key,value)
  if (map.tables[key] == nil) then
    map.tables[key] = value
    table.insert(map.indexs,key)
  else
    map.tables[key] = nil
    map.tables[key] = value  
  end
  return map.tables
end

--read by key
local function get(key)
  return map.tables[key]
end


--clear map
local function clear()
  for i = 1,#map.tables do 
    map.tables[map.indexs[i]] = nil
    table.remove(map.indexs,i);
  end
end

function map.new()
  local obj = {
    putIfAbsent = putIfAbsent,
    put = put,
    get = get,
    clear = clear
  }
  return obj
end
return map