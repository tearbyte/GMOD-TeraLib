local DRIVER = {}
DRIVER.__index = DRIVER

function DRIVER:New( config )
	local obj = {}
	return setmetatable( obj, self )
end

function DRIVER:Connect()
end

function DRIVER:BuildQuery( query, args )
	local count = 0

	if #args < select( 2, query:gsub( '?', '' ) ) then
		print( 'TeraLib WARNING: BuildQuery: Not enough arguments for placeholders!' )
	end

	local q = query:gsub( '?', function()
		count = count + 1
		local v = args[count]

		if v == nil then return 'NULL' end
		if isnumber( v ) then return tostring( v ) end
		if isbool( v ) then return v and '1' or '0' end

		return self:Escape( tostring( v ) )
	end)

	return q
end

function DRIVER:KAQuery( query, args, callback )
	self:Query( query, args, callback )
end

function DRIVER:Query( query, args, callback )
	local query_ = self:QuerySync( query, unpack( args or {} ) )
	
	if isfunction( callback ) then
		callback( query_ )
	end
end

function DRIVER:QuerySync( query, ... )
	-- Well, for SQLite in GMOD there's nothing else than just 'querysync'
	local query = self:BuildQuery( query, { ... } )
	local resp = sql.Query( query )
	print( query, resp )
	return resp
end

function DRIVER:Disconnect()
end

function DRIVER:Escape( str )
	return sql.SQLStr( str )
end

function DRIVER:CreateTransaction()
	
	return
end

return DRIVER