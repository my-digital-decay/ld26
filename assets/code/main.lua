--------------------------------------------------------------------------------
-- main.lua
-- author: keith w. thompson

SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720

MOAISim.openWindow ( "ld26", SCREEN_WIDTH, SCREEN_HEIGHT )

viewport = MOAIViewport.new ()
viewport:setSize ( SCREEN_WIDTH, SCREEN_HEIGHT )
viewport:setScale ( SCREEN_WIDTH, -SCREEN_HEIGHT )

dofile "utils.lua"
--dofile "fonts.lua"
dofile "splash.lua"
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
-- Layers
--

LAYER_BG = 1
LAYER_PLX_BG1 = 2
LAYER_PLX_BG2 = 3
LAYER_MAIN = 4
LAYER_PLX_FG1 = 5
LAYER_HUD = 6
LAYER_TOP = 7

layers = {}
for i = 1, LAYER_TOP do
  local lr = MOAILayer2D.new ()
  lr:setViewport ( viewport )
--  lr:setClearColor ()
--  lr:setClearDepth ()
  MOAISim.pushRenderPass ( lr )
  layers[i] = lr
end

layer = layers[LAYER_MAIN]
--layers[LAYER_BG]:setClearColor ( 0.2, 0.2, 0.2, 1.0 )
layers[LAYER_BG]:setClearColor ( 0.0, 0.0, 0.0, 1.0 )
--layers[LAYER_BG]:setClearDepth ( true )

--
-- Main loop
--

loop = true
function main ()

  splashScreen ()

  layers[LAYER_BG]:setClearColor ( 0.2, 0.2, 0.2, 1.0 )
  player = createPlayer()

  --
  -- Font
  --

  font = MOAIFont.new ()
  font:loadFromBMFont ( '../fonts/04b_03bx08.fnt' )

  staticTextbox = MOAITextBox.new ()
  staticTextbox:setString ( "0 1 2 3 4 5 6 7 8 9" )
  staticTextbox:setFont ( font )
  staticTextbox:setTextSize ( 8 )
  staticTextbox:setRect ( -150, 0, 150, 130 )
  staticTextbox:setAlignment ( MOAITextBox.CENTER_JUSTIFY, MOAITextBox.CENTER_JUSTIFY )
  --staticTextbox:setYFlip ( true )
  layer:insertProp ( staticTextbox )

  staticTextbox2 = MOAITextBox.new ()
  staticTextbox2:setString ( "0 1 2 3 4 5 6 7 8 9" )
  staticTextbox2:setFont ( font )
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

  while loop do
--      printf("mainThread: %f\n", time:getTime())
    coroutine.yield ()
  end
end

mainThread = MOAIThread.new ()
mainThread:run ( main )

