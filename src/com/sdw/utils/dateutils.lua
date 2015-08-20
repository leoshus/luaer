--���ڹ�����
--author by shangyd
local dateutils = {}
local stringutils = require("com.sdw.utils.stringutils")
local currentyear = nil;
local currentmonth = nil;
local currentday = nil;
local currentweek = nil; --������Ϊ1
local currenthour = nil;
local currentminute = nil;
local currentsecond = nil;

--[[
  Ŀǰ֧�� yyyy-mm-dd/yyyy-mm-dd hh:mm:ss ��ʽ
--]]
function dateutils.getCurrentDate(pattern)
local t = os.date("*t",os.time())
  for k,v in pairs(t) do
    if k == "year" then
      currentyear = v
    elseif k == "month" then 
      currentmonth = v
    elseif k == "day" then
      currentday = v
    elseif k == "wday" then
      currentweek = v
    elseif k == "hour" then
      currenthour = v
    elseif k == "min" then
      currentminute = v
    elseif k == "sec" then
      currentsecond = v
    end
  end    
  if pattern == "yyyy-mm-dd" then
    return currentyear .. "-" .. currentmonth .. "-" .. currentday
  elseif pattern == "yyyy-mm-dd hh:mm:ss" then
    return currentyear .. "-" .. currentmonth .. "-" .. currentday .. " " .. currenthour .. ":" .. currentminute .. ":" .. currentsecond 
  end
end

function dateutils.getCurrentWeek()
  local t = os.date("*t",os.time())
  for k,v in pairs(t) do
    if k == "wday" then
      currentweek = v
      break
    end
  end
  if (currentweek == 1) then
      currentweek = "������"; 
    elseif (currentweek == 2) then
      currentweek = "����һ"; 
  elseif (currentweek == 3) then
    currentweek = "���ڶ�"; 
  elseif (currentweek == 4) then
    currentweek = "������"; 
  elseif (currentweek == 5) then
    currentweek = "������"; 
  elseif (currentweek == 6) then
    currentweek = "������"; 
  elseif (currentweek == 7) then
      currentweek = "������"; 
  end
  return currentweek
end

--[[
�������ڲ�ֵ
@param from �ϴ�����
@param to ��С����
@pattern ���ڸ�ʽ yyyy-mm-dd
os.time{year=Y, month=M, day=D, hour=H,min=MM,sec=SS}
--]]
function dateutils.countBetDate(from,to,pattern)
  if pattern == "yyyy-mm-dd" then
      if from == nil or to == nil or pattern == "" or pattern == nil then 
        return 0
      end
    local fromt = stringutils.split(from,"-")
    local tot = stringutils.split(to,"-")
    local fromtime = os.time{year=fromt[1], month=fromt[2], day=fromt[3]}
    local totime = os.time{year=tot[1], month=tot[2], day=tot[3]}  
    return (fromtime - totime)
  end
  return 0
end

--[[
�Ƚ����ڲ�ֵ
@param from ����1
@param to ����2
@pattern ���ڸ�ʽ yyyy-mm-dd
os.time{year=Y, month=M, day=D, hour=H,min=MM,sec=SS}
--]]
function dateutils.compare(from,to,pattern)
  if pattern == "yyyy-mm-dd" then
      if from == nil or to == nil or pattern == "" or pattern == nil then 
        return nil
      end
    local fromt = stringutils.split(from,"-")
    local tot = stringutils.split(to,"-")
    local fromtime = os.time{year=fromt[1], month=fromt[2], day=fromt[3]}
    local totime = os.time{year=tot[1], month=tot[2], day=tot[3]}  
    if (fromtime - totime) > 0 then
      return 1
    elseif (fromtime - totime) < 0 then
      return -1
    elseif (fromtime - totime) == 0 then
      return 0
    end
  end
  return nil
end
--���ڲ��Գ���ִ��ʱ��
function dateutils.getClock()
  return os.clock()
end

return dateutils