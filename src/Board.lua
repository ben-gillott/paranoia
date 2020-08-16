
Board = Class{}

-- local map = {}

local centerI = 3
local centerJ = 3

function Board:init(tile_gapIn, tile_sizeIn, cx, cy)
    --TODO: Update values from params
    self.tile_gap = tile_gapIn
    self.tile_size = tile_sizeIn
    self.corner_x = cx
    self.corner_y = cy
    self.map = {}
    Board:resetCenter()
    
    for i=1,5 do
        self.map[i] = {}
        for j=1,5 do
            self.map[i][j] = Tile(self.tile_size, "safe", self.corner_x + (self.tile_gap+self.tile_size)*i, self.corner_y + (self.tile_gap+self.tile_size)*j)
        end
    end
end

function Board:resetCenter()
    centerI = 3
    centerJ = 3
end

function Board:getI()
    return centerI
end

function Board:getJ()
    return centerJ
end


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

function Board:move(dir)
    local shiftDist = self.tile_gap + self.tile_size

    if dir == "up" then
        self.corner_y = self.corner_y - shiftDist
        centerJ = centerJ+1 --center goes down in board
    elseif dir == "down" then
        self.corner_y = self.corner_y + shiftDist
        centerJ = centerJ-1 --center moves up in board
    elseif dir == "left" then
        self.corner_x = self.corner_x - shiftDist
        centerI = centerI + 1 --center moves right in board
    elseif dir == "right" then
        self.corner_x = self.corner_x + shiftDist
        centerI = centerI - 1 --center moves left in baord
    end
end

function Board:isOOB()
    return centerI < 1 or centerI > 5 or centerJ < 1 or centerJ > 5
end

function Board:onDanger()
    if not Board:isOOB() then
        return self.map[centerI][centerJ]:onDanger()
    else
        return false --No tiles if outside
    end
end

function Board:enemyIsOOB(i,j)
    return i < 1 or i > 5 or j < 1 or j > 5
end

function Board:enemyOnDanger(i,j)
    if not Board:enemyIsOOB(i,j) then
        return self.map[i][j]:onDanger()
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