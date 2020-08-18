Tile = Class{}

local spd = 2;
local fallcountdownValue = 4;

function Tile:init(tile_start_size, state, x, y)
    -- simple positional and dimensional variables
    self.tile_start_size = tile_start_size
    self.tile_size = tile_start_size
    self.fallcountdown = fallcountdownValue
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

function Tile:onFalling()
    if self.state == "falling" then
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

    if self.state == "falling" then
        if self.fallcountdown <= 1 then
            self.state = "danger"
            self.tile_size = 0
            self.fallcountdown = 0
            --Reset
            -- self.tile_size = self.tile_start_size
            -- self.fallcountdown = fallcountdownValue
        else
            self.fallcountdown = self.fallcountdown - 1*dt
            self.tile_size = (self.fallcountdown/fallcountdownValue)*self.tile_start_size
        end
    end



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
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle('fill', self.x, self.y, self.tile_size, self.tile_size)
    elseif self.state == "falling" then
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle('fill', self.x + (self.tile_start_size-self.tile_size)/2, self.y + (self.tile_start_size-self.tile_size)/2, self.tile_size, self.tile_size)
    elseif self.state == "danger" then
        
    end
end