--[[
--string.find
local pair = "name = Tom"
local _,_,key,value = string.find(pair,"(%a+)%s*=%s*(%a+)");
print(key .. "->" .. value)
date = "17/7/1990"
_, _, d, m, y = string.find(date, "(%d+)/(%d+)/(%d+)")
print(d, m, y)      --> 17 7 1990
--]]

--string.gsub
print(string.gsub("hello","(%a)","%1-%1"))
--\value{hello lua} -> <value>hello lua</value>
print(string.gsub("\\value{hello lua}","\\(%a+){(.-)}","<%1>%2</%1>"))
print(string.gsub("hello lua","(%a)",string.upper));    