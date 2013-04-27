--------------------------------------------------------------------------------
-- main.lua
-- author: keith w. thompson

MOAISim.openWindow ( "ld26", 1280, 720 )

viewport = MOAIViewport.new ()
viewport:setSize ( 1280, 720 )
viewport:setScale ( 1280, -720 )

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
-- Quad
--
--[[
box = MOAIGfxQuad2D.new ()
box:setTexture ( "square.png" )
--box:setTexture ( "circle.png" )
box:setRect ( -1, -1, 1, 1 )
box:setUVRect ( 0, 0, 1, 1 )

player = MOAIProp2D.new ()
player:setDeck ( box )
player:setScl ( 10, 10 )
layer:insertProp ( player )
--]]


--
-- Squares
--

function square_onDraw ( index, xOff, yOff, xFlip, yFlip )
  MOAIGfxDevice.setPenColor (0.66, 0.66, 0.33, 1)
  MOAIGfxDevice.setPenWidth ( 2 )
--  MOAIDraw.drawLine {-16, -16, 16, -16, 16, 16, -16, 16, -16, -16}
  MOAIDraw.drawRect ( -16, -16, 16, 16 )
end

squareDeck = MOAIScriptDeck.new ()
--scriptDeck:setTexture ( "moai.png" )
squareDeck:setRect ( -16, -16, 16, 16 )
squareDeck:setDrawCallback ( square_onDraw )

--
-- Circles
--

function circle_onDraw ( index, xOff, yOff, xFlip, yFlip )
  MOAIGfxDevice.setPenColor ( 0.33, 0.66, 0.66, 1 )
  MOAIGfxDevice.setPenWidth ( 2 )
  MOAIDraw.drawCircle ( 0, 0, 16, 32 )
end

circleDeck = MOAIScriptDeck.new ()
circleDeck:setRect ( -16, -16, 16, 16 )
circleDeck:setDrawCallback ( circle_onDraw )


--
-- Triangles
--

function triangle_onDraw ( index, xOff, yOff, xFlip, yFlip )
  MOAIGfxDevice.setPenColor (0.66, 0.33, 0.66, 1)
  MOAIGfxDevice.setPenWidth ( 2 )
  MOAIDraw.drawLine {-16, 16, 0, -16, 16, 16, -16, 16}
end

triangleDeck = MOAIScriptDeck.new ()
triangleDeck:setRect ( -16, -16, 16, 16 )
triangleDeck:setDrawCallback ( triangle_onDraw )


--
-- Scene
--

box = MOAIProp2D.new ()
box:setDeck ( squareDeck )
box:setLoc ( -64.0, 0.0 )
--lines:setScl ( 10, 10 )
layer:insertProp ( box )

ball = MOAIProp2D.new ()
ball:setDeck ( circleDeck )
ball:setLoc ( 0.0, 0.0 )
--lines:setScl ( 10, 10 )
layer:insertProp ( ball )

spike = MOAIProp2D.new ()
spike:setDeck ( triangleDeck )
spike:setLoc ( 64.0, 0.0 )
--lines:setScl ( 10, 10 )
layer:insertProp ( spike )

--
-- Main loop
--
mainThread = MOAIThread.new ()
mainThread:run (
  function ()
    while true do
      coroutine.yield ()
    end
  end
)

