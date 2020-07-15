--[[
Comment
]]


PlayState = Class{__includes = BaseState}

local gboard
local gplayer
--Check the offset of the board and if it is out of bounds
--TODO: use offsets to get death
local offsetLimit = 2
local offsetX = 0
local offsetY = 0

TileGap = 3
TileSize = 20
InitBoardX = 120
InitBoardY = 30

local dangerLevel = 20 --0 to 100 in percent chance of a tile changing on move

function PlayState:enter()
    gboard = Board(TileGap, TileSize, InitBoardX, InitBoardY)
    gplayer = Player("normal", InitBoardX+3*TileGap+3.5*TileSize, InitBoardY+3*TileGap+3.5*TileSize)
end

function PlayState:update(dt)    
    gboard:updateTargets()
    gboard:update(dt)

    --Get keyboard movement
    if love.keyboard.wasPressed('w') then
        self:moveBoard("up")
    elseif love.keyboard.wasPressed('s') then
        self:moveBoard("down")
    elseif love.keyboard.wasPressed('a') then
        self:moveBoard("left")
    elseif love.keyboard.wasPressed('d') then
        self:moveBoard("right")
    end
end

--Move the board in a direction
function PlayState:moveBoard(dir)
    if dir == "up" then
        if offsetY <= offsetLimit then
            gboard:move("up")
            offsetY = offsetY + 1
        end
    elseif dir == "down" then
        if offsetY >= -offsetLimit then
            gboard:move("down")
            offsetY = offsetY - 1
        end
    elseif dir == "left" then
        if offsetX >= -offsetLimit then
            gboard:move("left")
            offsetX = offsetX - 1
        end
    elseif dir == "right" then
        if offsetX <= offsetLimit then
            gboard:move("right")
            offsetX = offsetX + 1
        end
    end

    gboard:addDanger(dangerLevel)
end


function PlayState:render()
    gboard:render()
    gplayer:render()
end