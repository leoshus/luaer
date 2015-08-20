--常用函数总结 以及对lua标准库的扩展
local functions = {}

--[[
  尝试数字转换  如果转换失败返回0
@param number 带转换数字
@param base 进制默认十进制
--]]
function functions.convertnumber(num,base)
  return tonumber(num,base) or 0
end

--[[
尝试将num转换为整数 失败则返回0
--]]
function functions.converInt(num)
  return math.round(functions.convertnumber(num))
end


return functions