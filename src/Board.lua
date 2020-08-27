
Board = Class{}

function Board:init(tile_gapIn, tile_sizeIn, cx, cy)
    --TODO: Update values from params
    self.tile_gap = tile_gapIn
    self.tile_size = tile_sizeIn
    self.corner_x = cx
    self.corner_y = cy
    self.map = {}
    
    for i=1,5 do
        self.map[i] = {}
        for j=1,5 do
            self.map[i][j] = Tile(self.tile_size, "safe", self.corner_x + (self.tile_gap+self.tile_size)*i, self.corner_y + (self.tile_gap+self.tile_size)*j)
        end
    end
end


-- function Board:tileScore()
--     local count = 0
--     for i=1,5 do
--         for j=1,5 do
--             if not (self.map[i][j]:onSafe()) then
--                 count = count+1
--             end
--         end
--     end
--     return count
-- end

function Board:update(dt)
    for i=1,5 do
        for j=1,5 do
            -- print(self.tile_gap)
            self.map[i][j]:update(dt)
        end
    end
end


function Board:addRandomDanger()
    --Get a random i and j from 1 to 5 inclusive
    local randomI = math.ceil(math.random(1,5))
    local randomJ = math.ceil(math.random(1,5))
    self.map[randomI][randomJ]:setState("danger")
end


function Board:manualDanger(iIn,jIn)
    if(iIn > 0 and iIn < 6 and jIn > 0 and jIn < 6)then
        self.map[iIn][jIn]:setState("danger")
    end
end

function Board:manualSafe(i,j)
    if(i > 0 and i < 6 and j > 0 and j < 6)then
        self.map[i][j] = Tile(self.tile_size, "safe", self.corner_x + (self.tile_gap+self.tile_size)*i, self.corner_y + (self.tile_gap+self.tile_size)*j)
    end
end

function Board:manualFalling(iIn,jIn)
    if(iIn > 0 and iIn < 6 and jIn > 0 and jIn < 6)then
        self.map[iIn][jIn]:setState("falling")
    end
end

function Board:isOOB(i,j)
    return i < 1 or i > 5 or j < 1 or j > 5
end

function Board:onDanger(i,j)
    if not Board:isOOB(i,j) then
        return self.map[i][j]:onDanger()
    else
        return false --No tiles if outside
    end
end

function Board:onFalling(i,j)
    if not Board:isOOB(i,j) then
        return self.map[i][j]:onFalling()
    else
        return false --No tiles if outside
    end
end


function Board:setCorner(cx, cy)
    self.corner_y = cx
    self.corner_x = cy
end

function Board:getCornerX()
    return self.corner_x
end

function Board:getCornerY()
    return self.corner_y
end

function Board:updateTargets()
    for i=1,5 do
        for j=1,5 do
            -- print(self.tile_gap)
            self.map[i][j]:setTarget(self.corner_x + (self.tile_gap+self.tile_size)*i, self.corner_y + (self.tile_gap+self.tile_size)*j)
        end
    end
end

function Board:render()
    for i=1,5 do
        for j=1,5 do
            self.map[i][j]:render()
        end
    end
end