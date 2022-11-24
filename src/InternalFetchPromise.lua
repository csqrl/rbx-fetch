--!strict
local HttpService = game:GetService("HttpService")

local T = require(script.Parent["init.d"])
local Promise = require(script.Parent.Promise)

type RequestAsyncOptionsGeneric<METHODS, BODY> = {
	Url: string,
	Method: METHODS,
	Headers: T.Dictionary<T.Primitive, T.Primitive>?,
	Body: BODY,
}

---@diagnostic disable-next-line: redefined-type
type RequestAsyncOptions =
	RequestAsyncOptionsGeneric<T.RequestMethodsNoBodySupported?, nil>
	| RequestAsyncOptionsGeneric<T.RequestMethodBodySupported, string?>

local function internalFetchPromise(options: RequestAsyncOptions): Promise.Promise
	return Promise.new(function(resolve, reject)
		local success, response = pcall(function()
			return HttpService:RequestAsync(options)
		end)

		if not success then
			reject(response)
			return
		end

		resolve(response)
	end)
end

return internalFetchPromise
