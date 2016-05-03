--[[
    基本函数库为lua内置的函数库,不需要额外装载
--]]

--[[
    assert(v[,message]) 相当于C的断言 当表达式v返回为nil或者false时触发错误 message为错误消息 默认为"assertion fail!"
]]--
assert(1 == 0,"Math error")

--[[
  collectgarbage(opt[,arg])
  垃圾收集器的通用接口 用于操作垃圾收集器
  参数：
  opt:操作方法标识
  "stop":停止垃圾收集器
  "restart":重启垃圾收集器
  "collect":执行一次全垃圾收集循环
  "count":返回当前Lua中使用的内存量(以KB为单位)
  "step":单步执行一个垃圾收集.步长"size"由参数arg指定(大型的值需要多步才能完成),如果要准确指定步长,需要多次实验以达到最优效果.如果步长完成一次收集循环,将返回True
  "setpause":设置arg/100的值作为暂定收集的时长
  "setstepmul":设置arg/100的值,作为步长的振幅(即新步长=旧步长*arg/100)
]]--
collectgarbage("restart")


--[[
  dofile(filename)
    打开并且执行一个lua块,当忽略参数filename时,将执行标准输入设备(stdin)的内容.返回所有块的返回值.当发生错误时,dofile将错误反射给调用者
  注:dofile不能在保护模式下运行   
]]--
dofile("test.lua")

--[[
  error(message[,level])
  终止正在执行的函数,并返回message的内容作为错误信息(error函数永远不会返回)
  通常情况下 error会附加一些错误位置的信息到message的头部
  Level参数指示获得错误的位置
  Level=1[默认]:指出error的位置(文件+行号)
  Level=2:指出那个调用error的函数
  Level=0:不添加错误位置信息
]]--
error("occur error",2)


--[[
  _G 全局环境表(全局变量)
  记录全局环境的变量值的表 _G._G = _G
]]--


--[[
  getfenv(f)
   返回函数f的当前环境表
   参数f可以为函数或者调用栈的级别,级别1[默认]为当前的函数,级别0或者其他值将返回全局环境_G
]]--


--[[
  getmetatable(object)
  返回指定对象的元表(若object的元表.__metatable项有值则返回object的元表.__metatable的值),当object没有元素时将返回nil
]]--

--[[
  ipairs(t)
  返回三个值迭代函数、表、0
  多用于穷举表的键名和键值对
  注:本函数只能用于以数字索引访问的表  
]]--

--[[
  load(func[,chunkname])
    装载一个块中的函数 每次调用func将返回一个连接前一结的字串,在块结尾出将返回nil
    当没有发生错误时,将返回一个编译完成的块作为函数,否则返回nil加上错误信息,此函数的环境为全局环境
    chunkname用于错误和调试信息
]]--


--[[
  loadfile([filename])
  与load类似,但装载的是文件或当没有指定filename时装载标准输入(stdin)的内容
]]--

--[[
  loadstring(string[,chunkname])
  类似load 但是装载的内容是一个字符串
]]--


--[[
  next(table[,index])
  允许程序遍历表中的每一个字段,返回下一个索引和该索引的值
  参数:
  table:要遍历的表
  index:要返回的索引的前一索中的号,当index为nil时,将返回第一个索引的值,当索引号为最后一个索引或表为空时将返回nil
  注:可以用next(t)来检测表示为空(此函数只能用于数字索引的表与ipairs相类似)
]]--


--[[
  print(...)
  简单的以tostring方式格式化输出参数的内容
]]--


--[[
  rawequal(v1,v2)
  检测v1是否等于v2 此函数不会调用任何元表的方法
]]--

--[[
  rawget(table,index)
  获取表中指定索引的值,此函数不会调用任何元表的方法,成功返回相应的值,当索引不存在时返回nil
  注:本函数只能只能用于以数字索引访问的表
]]--

--[[
  rawset(table,index,value)
  设置表中指定索引的值,此函数不会调用任何元表的方法,此函数将返回table
]]--

--[[
  select(index,...)
  当index为数字将返回所有index大于index的参数
  当index为"#" 则返回参数的总个数(不包含index)
]]--

--[[
  setfenv(f,table)
  设置函数f的环境表为table
  f可以为函数或者调用栈的级别,级别1[默认]为当前函数,级别0将设置当前线程的环境表
]]--

--[[
  setmetatable(table,metatable)
  为指定的table设置元表metatable 若metatable为nil 则取消table的元表 当metatable已存在将触发错误
  注:只能为LUA_TTABLE表类型执行元表
]]--


--[[
  tonumber(e,[,base])
  尝试将参数e转换为数字,当不能转换时返回nil
  base(2~36)指出参数e当前使用的进制,默认为10进制
]]--


--[[
  tostring(e)
  将参数e转换为字符串,此函数将会触发元表的__tostring事件
]]--

--[[
  type(v)
  返回参数的类型名("nil","number","string","boolean","table","function","thread","userdata")
]]--


--[=[
  unpack(list[,i[,j]])
  返回指定表的索引的值,i为起始索引,j为结束索引 默认返回整个表的数据
  注:本函数只能用于以数字索引访问的表,否则只会返回nil
]=]--

--[[
  _VERSION
  返回当前Lua的版本号
]]--

--[[
  pcall(f,arg1,...)
  在保护模式下调用函数(即发生错误将不会返回给调用者)
  当调用函数成功能返回true,失败时将返回false加错误信息
]]--

--[[
  xpcall(f,err)
  与pcall类似,在保护模式下调用函数(即发生的错误将不会返回给调用者)
  但可指定一个新的错误处理函数的句柄 handler
  当调用函数成功能返回ture,失败时将返回false和err返回的结果
]]--
























































