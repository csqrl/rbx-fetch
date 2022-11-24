--!strict
local T = require(script.Parent.Parent["init.d"])

local isEmpty = require(script.Parent.isEmpty)

local function isArray(value: T.TableLike): boolean
	if typeof(value) ~= "table" then
		return false
	end

	if isEmpty(value) then
		return true
	end

	return #value > 0
end

return isArray
