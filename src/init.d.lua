---@diagnostic disable: undefined-type
--!strict
export type Dictionary<K, V> = { [K]: V }
export type Array<T> = Dictionary<number, T>

export type TableLike = Dictionary<any, any>

export type Primitive = string | number | boolean

export type SignalLike = RBXScriptSignal | {
	Connect: (callback: (...any) -> ...any) -> (Dictionary<string, any> & {
		Disconnect: (...any) -> ...any,
	}),
}

export type RequestMethodsNoBodySupported = "GET" | "TRACE" | "OPTIONS" | "HEAD" | "CONNECT"
export type RequestMethodBodySupported = "POST" | "PUT" | "PATCH" | "DELETE"

type FetchOptionsHelper<METHODS, BODY> = {
	method: METHODS,
	headers: Dictionary<any, any>?,
	body: BODY,
	credentials: ("omit" | "include")?,
	-- cookieJar: CookieJar?,
	cache: ("default" | "no-cache" | "reload" | "force-cache" | "only-if-cached")?,
	-- cacheImpl: CacheImplementation?,
	referrer: string?,
	referrerPolicy: (
		"no-referrer"
		| "no-referrer-when-downgrade"
		| "origin"
		| "origin-when-cross-origin"
		| "same-origin"
		| "strict-origin"
		| "strict-origin-when-cross-origin"
		| "unsafe-url"
	)?,
	integrity: string?,
	signal: SignalLike?,
}

---@diagnostic disable-next-line: redefined-type
export type FetchOptions =
	FetchOptionsHelper<RequestMethodsNoBodySupported?, nil>
	| FetchOptionsHelper<RequestMethodBodySupported, any?>

return {
	RequestMethodsNoBodySupported = {
		"GET",
		"TRACE",
		"OPTIONS",
		"HEAD",
		"CONNECT",
	},
	RequestMethodBodySupported = {
		"POST",
		"PUT",
		"PATCH",
		"DELETE",
	},
}
