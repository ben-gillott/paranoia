Tile = Class{}

local fallcountdownValue = 3
local scaleFactor = 4.25/10 --22
local offset = -1
function Tile:init(tile_start_size, state, x, y)
    -- simple positional and dimensional variables
    self.tile_start_size = tile_start_size
    self.tile_size = tile_start_size*scaleFactor
    self.fallcountdown = fallcountdownValue
    self.state = state
    self.x = x
    self.y = y
    self.t_y = y
    self.t_x = x
    self.scale = scaleFactor
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
        if self.fallcountdown <= 1.5 then
            self.state = "danger"
            self.tile_size = 0
            self.fallcountdown = 0
            --Reset
            -- self.tile_size = self.tile_start_size
            -- self.fallcountdown = fallcountdownValue
        else
            self.fallcountdown = self.fallcountdown - 1*dt
            self.scale = (self.fallcountdown/fallcountdownValue)*scaleFactor
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
    if not (self.state == "danger") then
        -- local offsetti = (1/self.scale)*self.tile_start_size
        local offsetti = (self.tile_start_size)*(fallcountdownValue/self.fallcountdown)/2

        love.graphics.draw(gTextures['tile1'], self.x+offsetti/2, self.y+offsetti/2, 0, self.scale, self.scale, offset, offset)
    end
end