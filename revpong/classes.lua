-------------------------------------------------------------------------------------------------------
--Class Boundary --------------------------------------------------------------------------------------
boundary = {}
boundary.new = function(x1, y1, x2, y2, name)
	local self = {}
	self.b = love.physics.newBody(world, 0, 0, "static")
	self.s = love.physics.newEdgeShape(x1, y1, x2, y2)
	self.f = love.physics.newFixture(self.b, self.s)
	self.f:setUserData(name)
	
	self.draw = function()
		love.graphics.line(x1, y1, x2, y2)
	end
	
	return self
end
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--Class Ball ------------------------------------------------------------------------------------------
ball = {}
ball.new = function(x, y, name,offset)
	local self = {}
	self.b = love.physics.newBody(world, x, y, "dynamic")
	--self.b:setGravityScale(0)
	--self.b:setInertia(0)
	--self.b:setLinearDamping(0)
	self.b:setLinearVelocity(300, -300)
	--self.b:setMass(0)
	self.b:isBullet()
	self.s = love.physics.newCircleShape(love.graphics.getWidth()*love.graphics.getHeight()/11664)
	self.f = love.physics.newFixture(self.b, self.s)
	self.f:setFriction(0)
	--self.f:setRestitution(1)
	self.f:setUserData(name)
	
	self.update = function()
		if love.keyboard.isDown("right") then
			self.b:applyForce(1500, 0)
		elseif love.keyboard.isDown("left") then
			self.b:applyForce(-1500, 0)
		end
		if love.keyboard.isDown("up") then
			self.b:applyForce(0, -1500)
		elseif love.keyboard.isDown("down") then
			self.b:applyForce(0, 1500)
		end
		if gravity then
			self.b:setGravityScale(3)
			self.f:setRestitution(0.5)
		else
			self.b:setGravityScale(0)
			self.f:setRestitution(1)
		end
	end
	
	self.draw = function()
		love.graphics.circle("line", self.b:getX(), self.b:getY(), self.s:getRadius(), love.graphics.getWidth()*love.graphics.getHeight()/11664)
		if drawText then
			love.graphics.print(name.." - linear velocity = "..self.b:getLinearVelocity().." | angular velocity = "..self.b:getAngularVelocity(), 10, love.graphics.getHeight()-love.graphics.getHeight()*.1-offset)
		end
	end
	
	return self
end
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------