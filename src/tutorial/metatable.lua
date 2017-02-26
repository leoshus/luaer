local mt = {__index = function(table,key) return 1 end,__tostring = function()return "hello" end}
--set the table's metatable be protected
mt.__metatable = "not your business"
local a = {}
setmetatable(a,mt)
print (a)
print(a["a"])
--can't change a protected metatable
setmetatable(a,{})
-- not your business
print(getmetatable(a))


