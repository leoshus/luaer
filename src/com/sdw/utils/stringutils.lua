local stringutils = {}

--[[
@param str ���ָ��ַ���
@param delimiter �ָ��ַ�
--]]
function stringutils.split(str,delimiter)
  if str == nil or str == "" or delimiter == nil then
    return nil
  end
  local result = {}
  for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result,match)
  end
  return result
end

--[[
ȥ���ַ����ո�
--]]
function stringutils.trim(str)
  if str == nil or tostring(str) == "userdata: NULL" then
    return ""
  end
  local result,count = string.gsub(str,"%s","")
  return result
end



return stringutils

