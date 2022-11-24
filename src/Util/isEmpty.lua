--!strict
local T = require(script.Parent.Parent["init.d"])

local function isEmpty(value: T.TableLike): boolean
	return typeof(value) == "table" and next(value) == nil
end

return isEmpty
