local tile_mt = {}
local tile = {}

tile.id = {
	floor = 0,
	wall = 1,
	gelee = 2
}


function tile.new (id, group)
	local self = setmetatable({},{__index=tile_mt})
	self.id = id or tile.id.wall
	self.group = group

	return self
end

return tile