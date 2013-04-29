--------------------------------------------------------------------------------
-- title.lua
-- author: keith w. thompson

function titleScreen ()
  local text = MOAITextBox.new ()
  text:setString ( "PRESS SPACE" )
  text:setFont ( font )
  text:setColor ( 0.9, 0.9, 0.9, 1.0 )
  text:setTextSize ( 32 )
  text:setRect ( -128, 8, 128, 72 )
  text:setAlignment ( MOAITextBox.CENTER_JUSTIFY, MOAITextBox.CENTER_JUSTIFY )
  layers[LAYER_MAIN]:insertProp ( text )

  local box = makeShape ( SHAPE_SQUARE )
  box:setLoc ( -64.0, -32.0 )
  box:setScl ( 16, 16 )
  box:setColor ( 0.22, 0.22, 0.5 )
  layers[LAYER_MAIN]:insertProp ( box )

  local ball = makeShape ( SHAPE_CIRCLE )
  ball:setLoc ( 0.0, -32.0 )
  ball:setScl ( 16, 16 )
  ball:setColor ( 0.22, 0.5, 0.22 )
  layers[LAYER_MAIN]:insertProp ( ball )

  local spike = makeShape ( SHAPE_TRIANGLE )
  spike:setLoc ( 64.0, -32.0 )
  spike:setScl ( 16, 16 )
  spike:setColor ( 0.5, 0.22, 0.22 )
  layers[LAYER_MAIN]:insertProp ( spike )
end

