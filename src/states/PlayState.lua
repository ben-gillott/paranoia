--[[
Comment
]]


PlayState = Class{__includes = BaseState}

-- local board
-- local player
--Check the offset of the board and if it is out of bounds
--TODO: In prog - use offsets to get death

--Coordinates that are at the center of the screen rn
-- local i = 3
-- local j = 3
-- local offsetLimit = 2
-- local offsetX = 0
-- local offsetY = 0

--TODO:
TileGap = 1
TileSize = 20
InitBoardX = 120
InitBoardY = 30


function PlayState:init()
    self.i = 3
    self.j = 3
    self.board = Board(TileGap, TileSize, InitBoardX, InitBoardY)
    self.player = Player("normal", InitBoardX+3*TileGap+3.5*TileSize, InitBoardY+3*TileGap+3.5*TileSize)
    self.enemies = {}
    
    --TODO: remove, Manual danger testing
    self.enemies[#self.enemies+1] = Enemy(1, 1, "right", TileGap, TileSize, InitBoardX, InitBoardY)
    self.enemies[#self.enemies+1] = Enemy(5, 2, "left", TileGap, TileSize, InitBoardX, InitBoardY)
    self.board:manualDanger(1,5)
end

function PlayState:render()
    self.board:render()
    self.player:render()
    for k,enemy in pairs(self.enemies) do
        enemy:render()
    end
    -- self.enemy:render()
end

function PlayState:update(dt)    
    self.board:updateTargets()
    self.board:update(dt)

    --#Get keyboard movement
    if love.keyboard.wasPressed('w') then
        self:moveBoard("up")
    elseif love.keyboard.wasPressed('s') then
        self:moveBoard("down")
    elseif love.keyboard.wasPressed('a') then
        self:moveBoard("left")
    elseif love.keyboard.wasPressed('d') then
        self:moveBoard("right")
    elseif love.keyboard.wasPressed('r') then
        -- Enemy update
        for k,enemy in pairs(self.enemies) do
            enemy:autoMove(self.board:getCornerX(), self.board:getCornerY())
        end
    end


    --check OOB or danger tile for character
    if self.board:isOOB() or self.board:onDanger() then --is off the board, fall off
        self.player:setState("dead")
    end
    --for testing - reset to alive after death TODO: REMOVE THIS FOR PROD
    if (not self.board:onDanger()) and (not self.board:isOOB()) then
        self.player:setState("normal")
    end
    if self.player:getState() == "dead" then
        gSounds['player_death']:play()
        gStateMachine:change('score', {})
    end


    --Check for enemy death
    for k,enemy in pairs(self.enemies) do
        if self.board:enemyIsOOB(enemy:getI(), enemy:getJ()) or self.board:enemyOnDanger(enemy:getI(), enemy:getJ()) then
            enemy:setState("dead")
        end
        --For testing TODO: REMOVE FOR PROD
        if (not self.board:enemyIsOOB(enemy:getI(), enemy:getJ())) and (not self.board:enemyOnDanger(enemy:getI(), enemy:getJ())) then
            enemy:setState("normal")
        end
    end
    
end


--===========--===========--===========

--Move the board in a direction
function PlayState:moveBoard(dir)
    gSounds['player_move']:play()
    local oppositeDir = "temp"
    if dir == "up" then
        self.board:move("up")
        --TODO apply to array of enemies
        oppositeDir = "down"
    elseif dir == "down" then
        self.board:move("down")
        oppositeDir = "up"
    elseif dir == "left" then
        self.board:move("left")
        oppositeDir = "right"
    elseif dir == "right" then
        self.board:move("right")
        oppositeDir = "left"
    end

    for k, enemy in pairs(self.enemies) do
        enemy:move(oppositeDir, self.board:getCornerX(), self.board:getCornerY())
    end
end

function PlayState:addEnemy()
    self.enemies[#self.enemies+1] = Enemy(1, 1, "right", TileGap, TileSize, InitBoardX, InitBoardY)
end
