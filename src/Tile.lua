Tile = Class{}

local spd = 2;

function Tile:init(tile_size, state, x, y)
    -- simple positional and dimensional variables
    self.tile_size = tile_size
    self.state = state
    self.x = x
    self.y = y
    self.t_y = y
    self.t_x = x
end

function Tile:setState(stateIn)
    self.state = stateIn
end

function Tile:onDanger()
    if self.state == "danger" then
        return true
    end
    return false
end

function Tile:setTarget(tx, ty)
    self.t_y = ty
    self.t_x = tx
end

function Tile:update(dt)
    --Lerp xy towards target
    self.x = Tile:lerp(self.x, self.t_x, Tile:ease(dt))
    self.y = Tile:lerp(self.y, self.t_y, Tile:ease(dt))
end

function Tile:lerp(from, to, t)
    return t < 0.5 and from + (to-from)*t or to + (from-to)*(1-t)
end

function Tile:ease(t)
    return (0.35-t)
end

function Tile:render()
    -- love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin],self.x, self.y)
    --TODO: draw self based on current state, xy and dimensions
    if self.state == "safe" then
        --Render normal tile
        love.graphics.setColor(0,255,0)
        love.graphics.rectangle('fill', self.x, self.y, self.tile_size, self.tile_size)
    elseif self.state == "danger" then
        --Render danger tile
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle('fill', self.x, self.y, self.tile_size, self.tile_size)
    end
end