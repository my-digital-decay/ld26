--------------------------------------------------------------------------------
-- main.lua
-- author: keith w. thompson

MOAISim.openWindow ( "ld26", 1280, 720 )

viewport = MOAIViewport.new ()
viewport:setSize ( 1280, 720 )
viewport:setScale ( 1280, -720 )

--dofile "fonts.lua"
dofile "shapes.lua"
dofile "player.lua"
dofile "input.lua"

--
-- Frontend
--

--
-- Backend
--

--
-- Font
--

layer = MOAILayer2D.new ()
layer:setViewport ( viewport )
layer:setClearColor (0.2, 0.2, 0.2, 1.0)
MOAISim.pushRenderPass ( layer )

bitmapFont = MOAIFont.new ()
bitmapFont:loadFromBMFont ( '../fonts/04b_03bx08.fnt' )

staticTextbox = MOAITextBox.new ()
staticTextbox:setString ( "0 1 2 3 4 5 6 7 8 9" )
staticTextbox:setFont ( bitmapFont )
staticTextbox:setTextSize ( 8 )
staticTextbox:setRect ( -150, 0, 150, 130 )
staticTextbox:setAlignment ( MOAITextBox.CENTER_JUSTIFY, MOAITextBox.CENTER_JUSTIFY )
--staticTextbox:setYFlip ( true )
layer:insertProp ( staticTextbox )

staticTextbox2 = MOAITextBox.new ()
staticTextbox2:setString ( "0 1 2 3 4 5 6 7 8 9" )
staticTextbox2:setFont ( bitmapFont )
staticTextbox2:setTextSize ( 64 )
staticTextbox2:setRect ( -150, 130, 150, 260 )
staticTextbox2:setAlignment ( MOAITextBox.CENTER_JUSTIFY, MOAITextBox.CENTER_JUSTIFY )
--staticTextbox2:setYFlip ( true )
layer:insertProp ( staticTextbox2 )


--
-- Scene
--

box = makeShape ( SHAPE_SQUARE )
box:setLoc ( -64.0, 0.0 )
box:setScl ( 16, 16 )
box:setColor ( 0.22, 0.22, 0.5 )
layer:insertProp ( box )

ball = makeShape ( SHAPE_CIRCLE )
ball:setLoc ( 0.0, 0.0 )
ball:setScl ( 16, 16 )
ball:setColor ( 0.22, 0.5, 0.22 )
layer:insertProp ( ball )

spike = makeShape ( SHAPE_TRIANGLE )
spike:setLoc ( 64.0, 0.0 )
spike:setScl ( 16, 16 )
spike:setColor ( 0.5, 0.22, 0.22 )
layer:insertProp ( spike )


time = MOAITimer.new ()
time:setSpan (0, 100)
time:start ()

--
-- Main loop
--
mainThread = MOAIThread.new ()
mainThread:run (
  function ()
    while true do
--      printf("mainThread: %f\n", time:getTime())
      coroutine.yield ()
    end
  end
)

player = createPlayer()
