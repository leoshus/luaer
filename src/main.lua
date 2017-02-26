local main = {}
local stringutils = require("com.sdw.utils.stringutils")
local functions = require("com.sdw.utils.functions")
local dateUtils = require ("com.sdw.utils.dateutils")
local dlist = require("com.sdw.utils.Dlist")
local set = require("com.sdw.utils.Set")
local weakList = require("com.sdw.utils.weakList")
local map = require("com.sdw.utils.map")

function printf(fmt, ...)
    print(string.format(tostring(fmt), ...))
end

function test() 
  print (dateUtils.getCurrentDate("yyyy-mm-dd"))
  print (dateUtils.getCurrentDate("yyyy-mm-dd hh:mm:ss"))
  print (dateUtils.getCurrentWeek())
end
--[==[
print(stringutils.trim("s    l p") .. "," .."s l p")

local times = stringutils.split("2015-8-1,2015-8-10,2015-8-20,2015-8-25",",")
print(times[#times] .. "," .. times[#times-2])
print(dateUtils.countBetDate(times[#times],times[#times-2],"yyyy-mm-dd"))

print(7*24*3600)


local list = dlist.new()
print("sdfsdf" .. tostring(list))
dlist.pushLeft(list,1)
--print(dlist.popRight(list))
for k,v in pairs(list) do
  print(k .. "----" .. v)
end

print(functions.convertnumber("..[[rm]].."))

io.write("test io")
print(os.getenv("JAVA_HOME"))

--pairs and ipairs
t = {12,43,[7]=56,23}
for k,v in pairs(t) do
  print(k .. "--------" .. v)
end

for k,v in ipairs(t) do
  print(k .. "==========" .. v)
end



local set1 = set.new({23,6,456,21})
local set2 = set.new({34,56,28,90,32})
local set3 = set1 + set2
--local set3 = set.union(set1,set2)
for k,v in pairs(set3) do
  print(k .. "---------" .. tostring(v))
end

local co = coroutine.create(function(a,b,c) 
  print (a .. "," .. b .. "," .. c)
end)
coroutine.resume(co,1,2,3)
print(coroutine.status(co))
--function trace(event,line)
--  local s = debug.getinfo(2).short_src
--  print(s .. ":" .. line)
--end
--
--debug.sethook(trace,"l")

function carry()
  for i=1,5 do
    print("carry out =" .. i)
    coroutine.yield(i)
  end
end
local co = coroutine.create(function(x,y) 
  print (x .. "--" .. y)
  carry()
end)

local code, result = coroutine.resume(co,1,2);
print(result)

local code1,result1 = coroutine.resume(co,3,4);
print(result)

print(coroutine.status(co))


local result = weakList:get(1,123)
print(result)
local result2 = weakList:get(2,123)
print(result2)

for k,v in pairs(weakList.wl) do
  print(k .. "=====" .. v)
end


local timecount = "2015-08-01,2015-08-28,2015-08-25"
local currentDate = "2015-08-25"
print(select(2,string.gsub(tostring(timecount),currentDate,"")))
print(select(2,string.gsub("2015-08-25","-","")))
local result = string.gsub("2015-08-25","-","")
print(result)


function main.split(str,delimiter)
  if str == nil or str == "" or delimiter == nil then
    return nil
  end
  local result = {}
  for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result,match)
  end
  return result
end
function main.countBetDate(from,to,pattern)
  if pattern == "yyyymmdd" then
    if from == nil or to == nil or pattern == "" or pattern == nil then
      return 0
    end
    local fromtime = os.time{year=string.sub(from,1,4), month=string.sub(from,5,6), day=string.sub(from,7,8)}
    local totime = os.time{year=string.sub(to,1,4), month=string.sub(to,5,6), day=string.sub(to,7,8)}
    return (fromtime - totime)
  end
  return 0
end

print(main.countBetDate(20150906,20150901,"yyyymmdd")<7 * 24 * 3600)





local context = {__index=function(t,n) if n==1 then print(t) t[0]=123 return "context" end end}
local t = {}
print(t)
setmetatable(t,context)
print (t[1])
print (t[0])



function readOnly(t)
  local proxy = {}
  local mt = {
    __index=t,
    __newindex=function() error("you are attemping access the readonly table...") end
  }
  setmetatable(proxy,mt)
  return proxy
end

local ta = readOnly({1,2,3})
print (ta[1])
--ta[1]=2

function pfunc()
  print"haha"
end
local func = string.dump(pfunc)
print(func)
local c = loadstring(func)
print(c)
c()
--error("occur error")
a,b=string.find("GL31-LWG-LJG-1-BQG-DWG","%-1%-BQG");
print(a,b);
a,b=string.find("GL31-LWG-LJG-1-BQG-DWG","-1-BQG");
print(a,b);
a,b=string.find("GL31-LWG-LJG-1-BQG-DWG","-1-BQG",1,true);
print(a,b);


print (loadstring("return 10")())





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
local t = StringSplit("/reply/upvote/tech_bbs/BDHK1P3I000915BF_BDHQ2KFI","/");
--print(t[#t]);


local t1 = StringSplit("112.80.53.34",",")
--print(t1[1])


local t2 = {"157.122.156.98","58.222.139.182"}

function check_blank_Ip (t,ip)
    for i,v in pairs(t) do
       if(v == ip) then
          return true
       end
    end
    return false
end

--print(check_blank_Ip(t2,"58.222.139.183"))
local comments = {}
local t = {1,2,3,7,"one","two","three"}
setmetatable(comments,{__len = function() return #t; end,__index=function()return 11;end})
print(#comments)
print(comments[0])



setmetatable(t, {__len = function (t)
  local cnt = 0
  for k,v in pairs(t) do
    if type(v) == "number" then 
      cnt = cnt + 1
      print(k,v)
    end
  end
  return cnt
end})

-- 结果是 6 而不是预期中的 3
print(#t)   --> 6 

local cs = map.new()
cs.put("key","value");
print(cs.get("key"))

--]==]

local response_status = {notFound=function()
  return 404,"resouce not found";
end}

print(response_status.notFound())


require"luaweb.classic.object":new()

