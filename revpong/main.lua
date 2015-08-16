require "classes"


function love.load()
	--Create World ---------------------------------------------------------------------------------------- 
    world = love.physics.newWorld(0, 200, true)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	-------------------------------------------------------------------------------------------------------
    
	
	--Create Boundaries -----------------------------------------------------------------------------------
	boundaries     = {
	boundaryLeft   = boundary.new(0, 0, 0, love.graphics.getHeight(), "Left Boundary"),
	boundaryRight  = boundary.new(love.graphics.getWidth(), 0, love.graphics.getWidth(), love.graphics.getHeight(), "Right Boundary"),
	boundaryTop    = boundary.new(0, 0, love.graphics.getWidth(), 0, "Top Boundary"),
	boundaryBottom = boundary.new(0, love.graphics.getHeight()-love.graphics.getHeight()*.1, love.graphics.getWidth(), love.graphics.getHeight()-love.graphics.getHeight()*.1, "Bottom Boundary")
	}
	-------------------------------------------------------------------------------------------------------
	
	
	--Create Balls ----------------------------------------------------------------------------------------
	balls = {
	one   = ball.new(100, 100, "ball 1",45),
	}
	-------------------------------------------------------------------------------------------------------


	--Debug -----------------------------------------------------------------------------------------------
    text       = ""
    text2      = "MOVEMENT: UP,DOWN,LEFT,RIGHT | GRAVITY: SPACE | DEBUG: ~"
	persisting = 0    -- use this to store the state of repeated callback calls
	drawText = false
	gravity = false
	-------------------------------------------------------------------------------------------------------
end


function love.update(dt)
	--Update World ----------------------------------------------------------------------------------------
    world:update(dt)
	-------------------------------------------------------------------------------------------------------
	
	
	--Update Balls ----------------------------------------------------------------------------------------
	for i, v in next, balls do
		v.update()
	end
	-------------------------------------------------------------------------------------------------------

	
	--Debug -----------------------------------------------------------------------------------------------
    if string.len(text) > 768 then    -- clean up when 'text' gets too long
        text = ""
    end
	function love.keypressed(key)
		if key == "`" then
			if drawText then
				drawText = false
			else
				drawText = true
			end
		end
		if key == " " then
			if gravity then
				gravity = false
			else
				gravity = true
			end
		end
	end
	-------------------------------------------------------------------------------------------------------
end


function love.draw()
	--Draw Boundaries -------------------------------------------------------------------------------------
	for i, v in next, boundaries do
		v.draw()
	end
	-------------------------------------------------------------------------------------------------------
	
	
	--Draw Balls ------------------------------------------------------------------------------------------
	for i, v in next, balls do
		v.draw()
	end
	-------------------------------------------------------------------------------------------------------
	
	
	--Debug -----------------------------------------------------------------------------------------------
    if drawText then
		love.graphics.print(text, 10, 10)
	end
	love.graphics.print(text2, 10, love.graphics.getHeight()-love.graphics.getHeight()*.1+5)
	-------------------------------------------------------------------------------------------------------
end


--Collision Callbacks -------------------------------------------------------------------------------------
function beginContact(a, b, coll)
	--Debug -----------------------------------------------------------------------------------------------
    x,y = coll:getNormal()
    text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
	-------------------------------------------------------------------------------------------------------
end

function endContact(a, b, coll)
	--Debug -----------------------------------------------------------------------------------------------
    persisting = 0
    text = text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
	-------------------------------------------------------------------------------------------------------
end

function preSolve(a, b, coll)
	--Debug -----------------------------------------------------------------------------------------------
    if persisting == 0 then    -- only say when they first start touching
        text = text.."\n"..a:getUserData().." touching "..b:getUserData()
    elseif persisting < 20 then    -- then just start counting
        text = text.." "..persisting
    end
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
	-------------------------------------------------------------------------------------------------------
end

function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
end
-----------------------------------------------------------------------------------------------------------