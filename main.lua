--------------------------------------------------------------------------------
-- main.lua
-- author: keith w. thompson

MOAISim.openWindow ( "ld26", 1280, 720 )

viewport = MOAIViewport.new ()
viewport:setSize ( 1280, 720 )
viewport:setScale ( 1280, -720 )

layer = MOAILayer2D.new ()
layer:setViewport ( viewport )
layer:setClearColor (0.2, 0.2, 0.2, 1.0)
MOAISim.pushRenderPass ( layer )

gfxQuad = MOAIGfxQuad2D.new ()
gfxQuad:setRect ( -10, -10, 10, 10 )

prop = MOAIProp2D.new ()
prop:setDeck ( gfxQuad )
layer:insertProp ( prop )

