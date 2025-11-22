
require( 'mysqloo' )
local _driver = mysqloo

local DRIVER = {}
DRIVER.__index = DRIVER

function DRIVER:New( config )
	local obj = {
		host = config.host,
		user = config.user,
		pass = config.pass,
		database = config.database,
		port = config.port
	}

	return setmetatable( obj, self )
end

function DRIVER:Connect()
	self.connection = _driver.connect( self.host, self.user, self.pass, self.database, self.port )

	self.connection.onConnectionFailed = function( db, data )
		error( 'TeraLib: Database connection error: ' .. data )
	end
	self.connection.onConnected = function()
		print( 'TeraLib: DB Connectivity established. Instance: ' .. self.connection:hostInfo() )
	end

	self.connection:setAutoReconnect( true )
	self.connection:connect()
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

		return "'" .. self:Escape( tostring( v ) ) .. "'"
	end)

	return q
end

function DRIVER:KAQuery( query, args, callback, attempts ) -- Keepalive query, tries a few times because sometime DB conn succ

	if args then query = self:BuildQuery( query, args ) end
	
	attempts = attempts or 1
	local query_ = self.connection:query( query )
	query_.onError = function( query_, err, sql )
		if attempts > 5 then
			print( 'TeraLib ERROR: Query (' .. query .. ') failed to execute - ' .. err )
			if isfunction( callback ) then callback( err, sql ) end
			return
		end
		timer.Simple( 0, function()
			self:KAQuery( query, nil, callback, attempts + 1 ) -- Yeah, query is sanitized for next iteration
		end)
	end

	function query_.onSuccess( query_, results )
		if not isfunction( callback ) then return end	
		callback( results )
	end

	query_:start()
	return query_
end

function DRIVER:Query( query, args, callback )

	if args then query = self:BuildQuery( query, args ) end

	local query_ = self.connection:query( query )
	
	function query_.onError(query_, err, sql)
		print( 'TeraLib ERROR: Query (' .. query .. ') failed to execute - ' .. err )
		if not isfunction( callback ) then return end
		
		callback( err, sql )
	end

	function query_.onSuccess(query_, results)
		if not isfunction( callback ) then return end
		
		callback( results )
	end

	query_:start()
	return query_
end

function DRIVER:QuerySync( query, ... ) -- Really. Don't use that. This is just for cases when you're too lazy to rewrite your code
	print( 'TeraLib WARNING: QueryWait called! This will work but it may freeze your server!')
	print( 'TeraLib WARNING: Avoid use QueryWait, instead use Query or KAQuery!')

	debug.Trace() -- Just in case if you forgot where it is

	-- Again. You can. But you SHOULDN'T

	local args = {...}
	query = self:BuildQuery( query, args )

	local data, lastid, affected, time
	local query_

	query_ = self.connection:query( query )

	function query_.onError(query_, err, sql)
		print( 'TeraLib ERROR: Query (' .. query .. ') failed to execute - ' .. err )
	end

	query_:start()
	query_:wait(true)

	return query_:getData()
end

function DRIVER:Disconnect()
	self.connection:disconnect( true )
end

function DRIVER:Escape( str )
	return self.connection:escape( str )
end

function DRIVER:CreateTransaction()
	return self.connection:CreateTransaction()
end

return DRIVER