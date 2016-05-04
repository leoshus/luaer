local functions = require("tutorial.functions")

--[[

--可变长度参数 函数
functions.func("a","b","c")

--多重返回值 函数
local p1,p2 = functions.foo()
print (p1 .. "-" .. p2)

--嵌套函数
local counter = functions.newCounter()
for a = 0,1 do
  print(counter())
end
local timer = functions.newTimer(1)
for i = 1,3 do
  print(timer())
end
print("----------")
local timer2 = functions.newTimer(1)
for n = 0,2 do
  print(timer2())
end

--异常捕捉 pcall xpcall debug
if pcall(function(i) eror("test pcall")end,23) then
  print("no error")
else
  print("occur error")
end
xpcall(function(i) error("test xpcall")end,function() print(debug.traceback())end,23)


--元表操作
local t = {10,20,30}
setmetatable(t,{
  __call = function(t1,t2)
    local sum = 0
    for i = 1,table.maxn(t1) do
      sum = sum + t1[i]
    end
    for i = 1,table.maxn(t2) do
      sum = sum + t2[i]
    end
    return "add sum = " .. sum
  end,
  __tostring = function(t1)
    local sum = 0
    for i = 1,table.maxn(t1)do
      sum = sum + t1[i]
    end  
    return "the table sum = " .. sum
  end
})   

print(t({10,20}))


-- __add method
local set1 = {}
local set2 = {10,20,30}
setmetatable(set1,{__add = function (s1,s2)
  for k,v in pairs(s2) do
    s1[k] = v
  end
  return s1
end})
local set = set2 + set1
for k,v in pairs(set) do
  print (k .. "->" ..v)
end


]]--

local ffi = require("ffi")
ffi.cdef[[
int printf(const char *fmt, ...);
]]
ffi.C.printf("Hello %s!", "world")



 















































