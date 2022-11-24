--!strict
local HttpService = game:GetService("HttpService")

local T = require(script.Parent["init.d"])
local Promise = require(script.Parent.Promise)
local merge = require(script.Parent.Util.merge)

local DEFAULT_OPTIONS: T.FetchOptions = {
	method = "GET",
	headers = {},
	body = nil,
	signal = nil,
}

local function DEFAULT_HEADERS(url: string, options: T.FetchOptions?)
	return {
		["Accept-Encoding"] = "gzip, deflate",
		["Accept"] = "*/*",
		["Connection"] = "close",
		["Content-Length"] = options and #options.body or 0,
		["Host"] = url,
		["User-Agent"] = "rbx-fetch/0.1.0",
	}
end

-- Lightweight wrapper around HttpService:RequestAsync
-- that returns a Promise which can be cancelled with a
-- SignalLike object (`options.signal`).
local function internalFetch(url: string, options: T.FetchOptions?): Promise.Promise
	local abortConnection: T.SignalLike

	local fetchPromise = Promise.new(function(resolve, reject)
		local ok, response = pcall(function()
			return HttpService:RequestAsync({
				Url = url,
				Method = options.method,
				Headers = options.headers,
				Body = options.body,
			})
		end)

		if abortConnection and abortConnection.Connected then
			abortConnection:Disconnect()
		end

		if ok then
			resolve(response)
		else
			reject(response)
		end
	end)

	if options.signal then
		abortConnection = options.signal:Connect(function()
			fetchPromise:cancel()
		end)
	end

	return fetchPromise
end

local function fetch(url: string, options: T.FetchOptions?): Promise.Promise
	options = merge(DEFAULT_OPTIONS, options)
	options.headers = merge(DEFAULT_HEADERS(url, options), options.headers)

	return internalFetch(url, options):andThen(function(response)
		if response.Success then
			return response
		else
			return Promise.reject(response)
		end
	end)
end

return fetch
