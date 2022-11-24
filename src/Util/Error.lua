--!strict
local Error = {}

Error.__index = Error

type ErrorOptions = {
	type: string?,
}

Error.Type = table.freeze({
	ArgumentError = "ArgumentError",
	HttpError = "HttpError",
	RobloxError = "RobloxError",
})

function Error.new(message: string, options: ErrorOptions)
	local self = setmetatable({}, Error)

	options = options or {}

	self.message = message
	self.type = options.type or "Error"

	return self
end

function Error.is(value: any): boolean
	return type(value) == "table" and getmetatable(value) == Error
end

function Error:__tostring(): string
	return ("%s: %s"):format(self.type, self.message)
end

return table.freeze(Error)
