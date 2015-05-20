local flan_mt = {}
local flan = {}



function flan.new( id, group )
	local self = setmetatable({},{__index=flan_mt})

	
	self.group = group

	return self
end

return flan