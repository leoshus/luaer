--���ú����ܽ� �Լ���lua��׼�����չ
local functions = {}

--[[
  ��������ת��  ���ת��ʧ�ܷ���0
@param number ��ת������
@param base ����Ĭ��ʮ����
--]]
function functions.convertnumber(num,base)
  return tonumber(num,base) or 0
end

--[[
���Խ�numת��Ϊ���� ʧ���򷵻�0
--]]
function functions.converInt(num)
  return math.round(functions.convertnumber(num))
end


return functions