local Promise = require(script.Parent.Parent.Promise)

export type Promise = typeof(Promise.new(function() end))

return Promise
