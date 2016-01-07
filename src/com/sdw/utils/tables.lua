--author by shangyd

--readOnly table
function readOnly(t)
  local proxy = {}
  local mt = {
    __index=t,
    __newindex=function() error("you are attemping access the readonly table...") end
  }
  setmetatable(proxy,mt)
  return proxy
end