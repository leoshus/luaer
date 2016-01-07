local weakList = {}
weakList.wl = {}
setmetatable(weakList.wl,{__mode="v"})

function weakList.get(this,key,update)
  if this.wl[key] then
    return this.wl[key]
  else
    this.wl[key] = update
  end
end

return weakList