local Router = {}
  function Router:new(request)
    local instance = {routes = request}
    setmetatable(instance,{__index = self})
    return instance
  end

  function Router:peek()
    print(self.routes.name)
  end
return Router