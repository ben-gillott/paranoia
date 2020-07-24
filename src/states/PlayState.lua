--[[
Comment
]]


PlayState = Class{__includes = BaseState}

local gboard
local gplayer
--Check the offset of the board and if it is out of bounds
--TODO: In prog - use offsets to get death

--Coordinates that are at the center of the screen rn
local i = 3
local j = 3
-- local offsetLimit = 2
-- local offsetX = 0
-- local offsetY = 0

--TODO:
TileGap = 3
TileSize = 20
InitBoardX = 120
InitBoardY = 30

local dangerLevel = 20 --0 to 100 in percent chance of a tile changing on move

function PlayState:enter()
    --Create the 
    gboard = Board(TileGap, TileSize, InitBoardX, InitBoardY)
    --Create the player object at the center
    gplayer = Player("normal", InitBoardX+3*TileGap+3.5*TileSize, InitBoardY+3*TileGap+3.5*TileSize)

    --TODO: Manual danger testing
    gboard:manualDanger(1,5)
end

function PlayState:update(dt)    
    gboard:updateTargets()
    
    gboard:update(dt)
    --#Get keyboard movement
    if love.keyboard.wasPressed('w') then
        self:moveBoard("up")
    elseif love.keyboard.wasPressed('s') then
        self:moveBoard("down")
    elseif love.keyboard.wasPressed('a') then
        self:moveBoard("left")
    elseif love.keyboard.wasPressed('d') then
        self:moveBoard("right")
    end


    --check OOB
    if gboard:isOOB() then --is off the board, fall off
        gplayer:setState("dead")
        print("OOB")
    end
    --Check if on danger 
    if gboard:onDanger() then --is on board but on danger tile
        gplayer:setState("dead")
        print("Collided")
    end

    --for testing
    if (not gboard:onDanger()) and (not gboard:isOOB()) then
        gplayer:setState("normal")
    end

end

--Move the board in a direction
function PlayState:moveBoard(dir)
    if dir == "up" then
        gboard:move("up")
    elseif dir == "down" then
        gboard:move("down")
    elseif dir == "left" then
        gboard:move("left")
    elseif dir == "right" then
        gboard:move("right")
    end

end

function PlayState:render()
    gboard:render()
    gplayer:render()
end