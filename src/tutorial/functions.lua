local functions = {}
--可变参数函数
function functions.func(...)
  for k,v in ipairs{...} do
    print(k .. "->" .. v)
  end
  --通过下标获取指定参数
  local a = select (3,...)
  print(a)
  --获取参数长度
  print(select('#',...))
end

--多重返回值函数
function functions.foo() 
 return "a","b"
end


--内嵌函数
function functions.newCounter()
  local i = 0
  return function ()
    i = i + 1
    return i
  end
end

--[[
Upvalue：一个函数所使用的定义在它的函数体之外的局部变量（external localvariable）称为这个函数的upvalue。
min是timer的upvalue 而只是newTimer的一个局部变量
--]]
function functions.newTimer(seconds)
  local min = seconds * 60
  local timer = function()
    min = min - 1
    return min
  end
  return timer
end


return functions