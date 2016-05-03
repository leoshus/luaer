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
]]--
--原表操作
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



 















































