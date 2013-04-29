--------------------------------------------------------------------------------
-- main.lua
-- author: keith w. thompson

SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720

MOAISim.openWindow ( "ld26", SCREEN_WIDTH, SCREEN_HEIGHT )

viewport = MOAIViewport.new ()
viewport:setSize ( SCREEN_WIDTH, SCREEN_HEIGHT )
viewport:setScale ( SCREEN_WIDTH, -SCREEN_HEIGHT )

require "utils"
require "splash"
require "title"
require "transition"
require "world"
require "shapes"
require "player"

dofile "input.lua"

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
layers[LAYER_BG]:setClearColor ( 0.0, 0.0, 0.0, 1.0 )
--layers[LAYER_BG]:setClearDepth ( true )

--
-- Font
--
font = MOAIFont.new ()
font:loadFromBMFont ( '../fonts/04b_03bx08.fnt' )


--
-- Main loop
--

GAME_STATE_FRONTEND = 0
GAME_STATE_BACKEND = 1
GAME_STATE_QUIT = 2
game_state = GAME_STATE_FRONTEND
game_state_new = GAME_STATE_FRONTEND

loop = true
function main ()

  splashScreen ()

  layers[LAYER_BG]:setClearColor ( 0.2, 0.2, 0.2, 1.0 )
  titleScreen ()
  do
    local transition = makeTransition( TRANSITION_FADE_OUT )
    transition:setColor ( 0,0,0,1 )
    transition:start ( layers[LAYER_TOP], 0.8 )
  end
--  layers[LAYER_MAIN]:clear ()

  --
  -- Game Loop
  --
  local done = false
  while not done do
--    printf ("mainThread:main - %d\n", game_state)
    if game_state_new ~= game_state then
      if GAME_STATE_FRONTEND == game_state_new then
        if GAME_STATE_BACKEND == game_state then
          player:clear ()
          world:stop ()
          world:clear ()
          layers[LAYER_HUD]:clear ()
        end
        titleScreen ()
      elseif GAME_STATE_BACKEND == game_state_new then
        layers[LAYER_MAIN]:clear ()
        world = makeWorld ()

        levelText = MOAITextBox.new ()
        levelText:setString ( string.format("%d", world.level_id) )
        levelText:setFont ( font )
        levelText:setColor ( 0.9, 0.9, 0.9, 1.0 )
        levelText:setTextSize ( 64 )
        levelText:setRect ( -64, -162, 64, -98 )
        levelText:setAlignment ( MOAITextBox.CENTER_JUSTIFY, MOAITextBox.CENTER_JUSTIFY )
        --levelText:setYFlip ( true )
        layers[LAYER_HUD]:insertProp ( levelText )

        player = createPlayer (SHAPE_SQUARE)

        world:start ()
      elseif GAME_STATE_QUIT == game_state_new then
        done = true
      end
      game_state = game_state_new
    end

    coroutine.yield ()
  end

  os.exit ()
end

mainThread = MOAIThread.new ()
mainThread:run ( main )

