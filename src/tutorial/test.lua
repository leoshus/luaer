local functions = require("tutorial.functions")

--[==[

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


local ffi = require("ffi")
ffi.cdef[[
int printf(const char *fmt, ...);
]]
ffi.C.printf("Hello %s!", "world")


a = 1;
print(_G["a"])
setmetatable(_G,{
  __index=function(_,k)
    error("can't read _G" .. k)
  end,
  __newindex = function(_,_,k)
    local w = debug.getinfo(2,"S").what
    if w ~= "main" and w ~= "C" then
      error("cat't create data for _G")
    end
    rawset(t,n,v)
  end
})
b=3
--_G["b"] = 2
print(rawget(_G,"a"))

--local a = _G[a]
for n in pairs(_G) do
  print(n)
end
]==]--


a = 1
local env = {}
setmetatable(env,{__index = _G})
setfenv(1,env)
print(a)

function factory ()
  local a = 0
  return function()
    a = a + 1
    return a
  end
end
a=2
f1 = factory()
setfenv(f1,{a=10})
f2 = factory()
f3 = factory()
print(f1(),f2(),f3(),f3())

local router = require "tutorial.Router"
local r = router:new({name="Tom"})
r:peek()

router:new({name="Rose"}):peek()

function test(param)
  return param
end

local ok,err = pcall(test,123)
print(err)


print(unpack(package.preload))

print(unpack(package.loaded))
print(unpack(package.loaders))

print((package.loaded["tutorial.functions"])["foo"]())
print(package.path)
print(package.cpath)








