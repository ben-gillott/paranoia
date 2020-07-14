--[[

]]

Tile = Class{}

local spd = 2;

function Tile:init(tile_size, type, x, y)
    -- simple positional and dimensional variables
    self.tile_size = tile_size
    self.type = type
    self.x = x
    self.y = y
    self.t_y = y
    self.t_x = x
end

function Tile:setTarget(tx, ty)
    self.t_y = ty
    self.t_x = tx
end

function Tile:update(dt)
    --Set directly
    -- self.x = self.t_x
    -- self.y = self.t_y

    --Lerp xy towards target
    -- local mdt = dt*dt
    self.x = Tile:lerpaderp(self.x, self.t_x, Tile:ease(dt))
    self.y = Tile:lerpaderp(self.y, self.t_y, Tile:ease(dt))
end

function Tile:lerpaderp(from, to, t)
    return t < 0.5 and from + (to-from)*t or to + (from-to)*(1-t)
end

function Tile:ease(t)
    return (0.35-t)
end

function Tile:render()
    -- love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin],self.x, self.y)
    --TODO: draw self based on current state, xy and dimensions
    love.graphics.rectangle('fill', self.x, self.y, self.tile_size, self.tile_size)
end