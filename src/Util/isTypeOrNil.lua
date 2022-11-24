--!strict
local function isTypeOrNil<T>(value: T, typeName: string, errorTemplate: string?): boolean
	local valueType = typeof(value)

	return value == nil or valueType == typeName,
		errorTemplate and errorTemplate:format(typeName, tostring(value), valueType) or nil
end

return isTypeOrNil
