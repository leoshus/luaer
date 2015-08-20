local main = {}
local stringutils = require("com.sdw.utils.stringutils")
local functions = require("com.sdw.utils.functions")
local dateUtils = require ("com.sdw.utils.dateutils")
local dlist = require("com.sdw.utils.Dlist")
function printf(fmt, ...)
    print(string.format(tostring(fmt), ...))
end

function test() 
  print (dateUtils.getCurrentDate("yyyy-mm-dd"))
  print (dateUtils.getCurrentDate("yyyy-mm-dd hh:mm:ss"))
  print (dateUtils.getCurrentWeek())
end

--test()
--[[
printf("The value = %d,%d",100,10)

print(select(2,string.gsub("testntes@163.com:nav15:233:1363",":36","")))
print(string.match("testntes@163.com:nav15:233:363",":36"))
--]]
--local t = stringutils.split("testntes@163.com:nav15:233:363",":")
--print(t[#t])
--local result,p = string.gsub("testntes@163.com:nav15:233:363",":","-");
--print(result .. "," .. p)

--[[
print(stringutils.trim("s    l p") .. "," .."s l p")

local times = stringutils.split("2015-8-1,2015-8-10,2015-8-20,2015-8-25",",")
print(times[#times] .. "," .. times[#times-2])
print(dateUtils.countBetDate(times[#times],times[#times-2],"yyyy-mm-dd"))

print(7*24*3600)
--]]

local list = dlist.new()
print("sdfsdf" .. tostring(list))
dlist.pushLeft(list,1)
--print(dlist.popRight(list))
print (dlist.length(list))
for k,v in pairs(list) do
  print(k .. "----" .. v)
end

