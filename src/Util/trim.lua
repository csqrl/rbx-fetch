--!strict
local function trim(str: string): string
	return str:gsub("^%s*(.-)%s*$", "%1")
end

return trim
