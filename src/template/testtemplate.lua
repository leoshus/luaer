local template = require "template"
local view = template.new "view.html"
view.message = "Hello World!"
view:render()

template.render("view.html",{message="Hello,World!"})