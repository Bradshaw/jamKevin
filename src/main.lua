function love.load(args)
	math.randomseed(os.time())
	level = require("level")
	tile = require("tile")
	playerSrc = require("player")
	camera = require("camera")
	soundSpouich = love.audio.newSource("son/spouitch.mp3")
	soundSpouich2 = love.audio.newSource("son/spouitch.mp3")
	flour = love.graphics.newImage("image/floor.png")
	gelay = love.graphics.newImage("image/gelee.png")
	woll = love.graphics.newImage("image/wall.png")
	
	tileSize = 20
	
	player = playerSrc.new()
	player.img = love.graphics.newImage("image/sticky.png")
	
	l = level.new()
	self.shakeX = 0
	self.shakeY = 0
	
end


function love.update(dt)

	if self.shakeY < 0 then
		self.shakeY = math.min(0, self.shakeX+dt/2)
	elseif self.shakeY > 0 then
		self.shakeY = math.max(0, self.shakeX-dt/2)
	end
	if self.shakeX < 0 then
		self.shakeX = math.min(0, self.shakeX+dt/2)
	elseif self.shakeX > 0 then
		self.shakeX = math.max(0, self.shakeX-dt/2)
	end
	
	if love.keyboard.isDown("right") and l:getTile(math.floor(player.x/tileSize)+1,math.floor(player.y/tileSize)).id ~= tile.id.wall  and l:getTile(math.floor(player.x/tileSize)+1,math.floor(player.y/tileSize)).id ~= tile.id.gelee then
		speed = math.min(speed+0.1, 4)
		player.x =  player.x+1+speed
	elseif love.keyboard.isDown("right") and l:getTile(math.floor(player.x/tileSize)+1,math.floor(player.y/tileSize)).id == tile.id.wall or l:getTile(math.floor(player.x/tileSize)+1,math.floor(player.y/tileSize)).id == tile.id.gelee   then
		soundSpouich2:play()
		if  l:getTile(math.floor(player.x/tileSize)+1,math.floor(player.y/tileSize)).id == tile.id.wall then
			l:setTile(math.floor(player.x/tileSize)+1,math.floor(player.y/tileSize),tile.new(tile.id.gelee,0))
		end
	end
	if love.keyboard.isDown("left") and l:getTile(math.floor((player.x)/tileSize)-1,math.floor(player.y/tileSize)).id ~= tile.id.wall and l:getTile(math.floor(player.x/tileSize)-1,math.floor(player.y/tileSize)).id ~= tile.id.gelee then
		speed = math.min(speed+0.1, 4)
		player.x = player.x-1-speed	
	elseif love.keyboard.isDown("left") and l:getTile(math.floor(player.x/tileSize)-1,math.floor(player.y/tileSize)).id == tile.id.wall or l:getTile(math.floor(player.x/tileSize)-1,math.floor(player.y/tileSize)).id == tile.id.gelee then
		soundSpouich2:play()
		if l:getTile(math.floor(player.x/tileSize)-1,math.floor(player.y/tileSize)).id == tile.id.wall then
			l:setTile(math.floor(player.x/tileSize)-1,math.floor(player.y/tileSize),tile.new(tile.id.gelee,0))
		end
	end
	
	if not love.keyboard.isDown("right") and not love.keyboard.isDown("left") then
		speed = 0	
	end
	
	frame =  30*dt
	if player.y < 1 then
		player.ySpeed = 0
	end
	if player.isGrounded==false then
		player.ySpeed =  math.min(20,player.ySpeed + player.gravSecond * frame )
	end
	player.y = player.y + player.ySpeed * frame

	if player.isGrounded== false and l:getTile(math.floor(player.x/tileSize),math.floor(player.y/tileSize)).id == tile.id.wall or l:getTile(math.floor(player.x/tileSize),math.floor(player.y/tileSize)).id == tile.id.gelee then 
		player.y = player.y - player.ySpeed * frame
		player.ySpeed = 0
		player.isGrounded = true
		player.startJump = player.y
		player.y = player.y-tileSize/4
		soundSpouich:stop()
		soundSpouich:play()
		self.shakeX = math.random(-5,5)
		self.shakeY = math.random(-5,5)
		if l:getTile(math.floor(player.x/tileSize),math.floor(player.y/tileSize)+1).id == tile.id.wall then
			l:setTile(math.floor(player.x/tileSize),math.floor(player.y/tileSize)+1,tile.new(tile.id.gelee,0))
		end
		
		
	end
	if player.y < player.startJump-30 then
		player.isGrounded = false
	end
	if l:getTile(math.floor(player.x/tileSize),math.floor(player.y/tileSize)+1).id ~= tile.id.wall and l:getTile(math.floor(player.x/tileSize),math.floor(player.y/tileSize)+1).id ~= tile.id.gelee then
		player.isGrounded = false
	else 
		l:setTile(math.floor(player.x/tileSize),math.floor(player.y/tileSize)+1,tile.new(tile.id.gelee,0))
	end
	
end


function love.draw()
	love.graphics.translate(-player.x+300+self.shakeX, -player.y+300+self.shakeY)
	for i=1,l.w do
		for j=1, l.h do
			if l:getTile(i,j).id==tile.id.floor then
				--love.graphics.setColor(64+j*5, 50+j*5, 255)
				love.graphics.draw(flour, i*tileSize, j*tileSize)
			elseif l:getTile(i,j).id==tile.id.wall then
				--love.graphics.setColor(160, 160, 54)
				love.graphics.draw(woll,  i*tileSize, j*tileSize)
			elseif l:getTile(i,j).id==tile.id.gelee then
				--love.graphics.setColor(40, 98, 9)
				love.graphics.draw(gelay,  i*tileSize, j*tileSize)
			end
			--love.graphics.rectangle("fill", i*tileSize, j*tileSize, tileSize, tileSize)

		end	
	end
	love.graphics.draw(player.img, player.x, player.y)
	
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	elseif key == " " and player.isGrounded then
		if l:getTile(math.floor(player.x/tileSize),math.floor(player.y/tileSize)+1).id == tile.id.gelee then
			player.ySpeed = -14 
		else
			player.ySpeed = -8 
		end
		self.shakeX = math.random(-10,10)
		self.shakeY = math.random(-10,10)
		player.startJump = player.y
	elseif key == "c" then
		print("Tile x : "..math.floor(player.x/tileSize) .. " tile y : "..math.floor(player.y/tileSize).. " type : ".. l:getTile(math.floor(player.x/tileSize),math.floor(player.y/tileSize)).id )
		print(" Gauche : Tile x : "..math.floor(player.x/tileSize)-1 .. " tile y : "..math.floor(player.y/tileSize).. " type : ".. l:getTile(math.floor(player.x/tileSize)-1,math.floor(player.y/tileSize)).id )
		print(" Droite : Tile x : "..math.floor(player.x/tileSize)+1 .. " tile y : "..math.floor(player.y/tileSize).. " type : ".. l:getTile(math.floor(player.x/tileSize)+1,math.floor(player.y/tileSize)).id )

   end
end