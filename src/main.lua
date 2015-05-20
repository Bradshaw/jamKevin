function love.load(args)
	math.randomseed(os.time())
	level = require("level")
	tile = require("tile").
	player = require("player")
	tileSize = 20
	
	l = level.new()
	
	
end


function love.update(dt)


end


function love.draw()
	for i=1,l.w do
		for j=1, l.h do
			if l:getTile(i,j).id==tile.id.floor then
				love.graphics.setColor(64, 50, 255)
			elseif l:getTile(i,j).id==tile.id.wall then
				love.graphics.setColor(160, 160, 54)
			end
			love.graphics.rectangle("fill", i*tileSize, j*tileSize, tileSize, tileSize)

		end	
	end


end

function love.keypressed(key)
	
	
end