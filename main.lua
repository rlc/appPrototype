--appPrototype
--v0.1 30 Aug 2012 - init
function love.load()
  window = {}
  window.w, window.h = love.graphics.getWidth(), love.graphics.getHeight()
  
  button = {}
  button.__index = button
  button.list = {}
  function button:new(x, y, w, h, label)
    local buttonPrototype = {
      x = x or 0;
      y = y or 0;
      w = w or 60;
      h = h or 25;
      label = label or "button";
      isDown = false;
    }
    button.list[#button.list+1] = setmetatable(buttonPrototype, self)
    return button.list[#button.list]
  end
  function button:drawInstance(dx, dy)
    if not self.isDown then
      love.graphics.setColor(150, 150, 150, 255)
      love.graphics.rectangle("fill", self.x + dx, self.y + dy, self.w, self.h)
    else
      love.graphics.setColor(200, 50, 50, 150)
      love.graphics.rectangle("fill", self.x + dx, self.y + dy, self.w, self.h)
    end
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(self.label, self.x + dx, self.y + dy + self.h/2 - 15/2, self.x + dx + self.w, "center")
  end
  function button:draw(dx, dy)
    local dx, dy = dx or 0, dy or 0--variable validation should be done on the topmost level
    for i, b in ipairs(self.list) do
      b:drawInstance(dx, dy)
    end
  end
  function button:isInside(mx, my)
    return (
      mx > self.x and
      mx < self.x + self.w and
      my > self.y and
      my < self.y + self.h
    )
  end
  function button:updateInstance(mx, my)
    
  end
  function button:update()
    --mouse event related update
      --mouse button assignment
      --lmb: touch
      --rmb: edit mode - move
    local mx, my = love.mouse.getPosition()
    if love.mouse.isDown("l") then
      for i, b in ipairs(self.list) do
        if b:isInside(mx, my) then
          b.isDown = true
        else
          b.isDown = false
        end
      end
    elseif not love.mouse.isDown("l") then
      for i, b in ipairs(self.list) do
        b.isDown = false
      end
    end
  end
  function button:mousepressed(key, mx, my)
    
  end

  button1 = button:new(15, 30)
end

function love.update(dt)
  local mx, my = love.mouse.getPosition()
  button:update()
end

function love.draw()
  button:draw()
end

function love.keypressed(key)
  if key == "escape" then
    love.event.push("q")
  end
end

function love.mousepressed(key, mx, my)
  button:mousepressed(key, mx, my)
end