local level_mt = {}
local level = {}
local tile = require("tile")


function level.new(options)
	options = options or {}
	local self = setmetatable({},{__index=level_mt})
	
	self.data = {}
	self.xsize = options.xsize or 50
	self.ysize = options.ysize or 10
	self.w = self.xsize
	self.h = self.ysize

	self:generate()


	return self
end



function level_mt:generate()
	for i=1, self.w do
		for j=1, self.h do
			if(j==1 or j== self.h or i==1 or i==self.w) then
				self:setTile(i, j, tile.new(tile.id.wall, 0))
			else
				if(math.random()*100 >3) then
					self:setTile(i, j, tile.new(tile.id.floor, 0))
				else
					self:setTile(i, j, tile.new(tile.id.wall, 0))
				end
			end
		end
	end


end


function level_mt:setTile(x, y, tile)
	x = ((x-1)%self.w)+1
	y = ((y-1)%self.h)+1
	self.data[ (x-1) + (y-1) * self.w + 1  ] = tile
end

function level_mt:getTile(x, y)
	x = ((x-1)%self.w)+1
	y = ((y-1)%self.h)+1
	return self.data[ (x-1) + (y-1) * self.w + 1  ] or tile.new(tile.id.wall, -1)
end

return level