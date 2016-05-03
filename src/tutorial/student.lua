--[[
  把需要隐藏的成员放在一张表里，把该表作为成员函数的upvalue。
  局限性：
  基于对象的实现不涉及继承及多态。但另一方面，脚本编程是否需要继承和多态要视情况而定。
--]]
function create(id,name)
  local data = {id = id,name = name}
  local obj = {}
  function obj.getName()
    return data.name
  end
  function obj.getId()
    return data.id
  end
  function obj.setName(name)
    data.name = name;
  end
  function obj.setId(id)
    data.id = id
  end
  function obj.getData()
    return data
  end
  function obj.addAge(age)
    data.age = age
  end
  return obj  
end

o1 = create("1","Tom")
o1.setName("Rose")
print (o1.getName())
o1.addAge(25)
for k,v in pairs(o1.getData())do
  print(k .. "->" .. v)
end