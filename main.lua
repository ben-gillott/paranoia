--[[
    GD50
    Breakout Remake

    Game template setup by : Colton Ogden (cogden@cs50.harvard.edu)
    Author: 

]]

require 'src/Dependencies'

--[[
    Called just once at the beginning of the game; used to set up
    game objects, variables, etc. and prepare the game world.
]]
function love.load()
    -- set love's default filter to "nearest-neighbor", which essentially
    -- means there will be no filtering of pixels (blurriness), which is
    -- important for a nice crisp, 2D look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())

    -- set the application title bar
    love.window.setTitle('Paranoia')

    -- initialize our nice-looking retro text fonts
    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
    }
    love.graphics.setFont(gFonts['small'])

    -- load up the graphics we'll be using throughout our states
    gTextures = {
        ['particle'] = love.graphics.newImage('graphics/particle.png'),
        ['background'] = love.graphics.newImage('graphics/background.png')
    }

    -- Quads we will generate for all of our textures; Quads allow us
    -- to show only part of a texture and not the entire thing
    gFrames = {
        -- ['arrows'] = GenerateQuads(gTextures['arrows'], 24, 24),
    }
    
    -- initialize our virtual resolution, which will be rendered within our
    -- actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- set up our sound effects; later, we can just index this table and
    -- call each entry's `play` method
    gSounds = {
        --TODO: Load music here
        -- ['music'] = love.audio.newSource('sounds/music.wav')
    }

    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end,
    }
    gStateMachine:change('play', {
        --TODO: First state params would go here
    })

    -- TODO: play music outside of all states and set it to looping
    -- gSounds['music']:play()
    -- gSounds['music']:setLooping(true)

    -- a table we'll use to keep track of which keys have been pressed this
    -- frame, to get around the fact that LÖVE's default callback won't let us
    -- test for input from within other functions
    love.keyboard.keysPressed = {}
end

--[[
    Called whenever we change the dimensions of our window, as by dragging
    out its bottom corner, for example. In this case, we only need to worry
    about calling out to `push` to handle the resizing. Takes in a `w` and
    `h` variable representing width and height, respectively.
]]
function love.resize(w, h)
    push:resize(w, h)
end

--[[
    Called every frame, passing in `dt` since the last frame. `dt`
    is short for `deltaTime` and is measured in seconds. Multiplying
    this by any changes we wish to make in our game will allow our
    game to perform consistently across all hardware; otherwise, any
    changes we make will be applied as fast as possible and will vary
    across system hardware.
]]
function love.update(dt)
    -- this time, we pass in dt to the state object we're currently using
    gStateMachine:update(dt)

    -- reset keys pressed
    love.keyboard.keysPressed = {}
end

--[[
    A callback that processes key strokes as they happen, just the once.
    Does not account for keys that are held down, which is handled by a
    separate function (`love.keyboard.isDown`). Useful for when we want
    things to happen right away, just once, like when we want to quit.
]]
function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

--[[
    A custom function that will let us test for individual keystrokes outside
    of the default `love.keypressed` callback, since we can't call that logic
    elsewhere by default.
]]
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

--[[
    Called each frame after update; is responsible simply for
    drawing all of our game objects and more to the screen.
]]
function love.draw()
    -- begin drawing with push, in our virtual resolution
    push:apply('start')

    -- background should be drawn regardless of state, scaled to fit our
    -- virtual resolution
    local backgroundWidth = gTextures['background']:getWidth()
    local backgroundHeight = gTextures['background']:getHeight()

    love.graphics.draw(gTextures['background'], 
        -- draw at coordinates 0, 0
        0, 0, 
        -- no rotation
        0,
        -- scale factors on X and Y axis so it fills the screen
        VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))
    
    -- use the state machine to defer rendering to the current state we're in
    
    gStateMachine:render()
    
    push:apply('end')
end
