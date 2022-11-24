--!strict
local T = require(script.Parent["init.d"])
local trim = require(script.Parent.Util.trim)

local HEADERS_INVALID_CHARACTERS = "[^a-z0-9%-#$%&'*+.^_`|~]"

local function normalizeHeaderName(name: any): string
	if typeof(name) ~= "string" then
		name = tostring(name)
	end

	if name:match(HEADERS_INVALID_CHARACTERS) or trim(name) == "" then
		error(("Invalid character in header field name %q: %q"):format(name, name:match(HEADERS_INVALID_CHARACTERS)), 2)
	end

	return name:lower()
end

local function normalizeHeaderValue(value: any): string
	if typeof(value) ~= "string" then
		value = tostring(value)
	end

	return value
end

local function normalize(headers: T.Dictionary<any, any>): T.Dictionary<string, string>
	local headersType = typeof(headers)

	if headersType == "nil" then
		return {}
	end

	if headersType ~= "table" then
		error(("Expected table for headers, got %q (%s)"):format(typeof(headers), tostring(headers)), 2)
	end

	local normalizedHeaders = {}

	for name, value in headers do
		normalizedHeaders[normalizeHeaderName(name)] = normalizeHeaderValue(value)
	end

	return normalizedHeaders
end

return {
	normalizeHeaderName = normalizeHeaderName,
	normalizeHeaderValue = normalizeHeaderValue,
	normalize = normalize,
}
