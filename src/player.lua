local player_mt = {}
local player = {}

function player.new()
	self = setmetatable({}, {__index = player_mt})
	
	self.x = 2*tileSize+tileSize/2
	self.y = 9*tileSize+tileSize/2
	self.name = "floda"
	self.speed = 10
	self.ySpeed = 0 
    self.gravSecond = 1.5
	self.startJump = self.y
	self.isGrounded = true
	return self
end



return player
