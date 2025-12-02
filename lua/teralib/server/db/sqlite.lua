
local DRIVER = include( 'teralib/server/db/base.lua' )

DRIVER._type = 1

function DRIVER:New( config )
	local obj = {}
	return setmetatable( obj, self )
end

function DRIVER:Connect()
	print( 'TeraLib: SQLite is always ready' )
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
	return resp
end

function DRIVER:Escape( str )
	return sql.SQLStr( str )
end

sql.m_strError = nil -- This is required to invoke __newindex

setmetatable( sql, { __newindex = function( table, k, v )
	if ( k == "m_strError" and v and #v > 0 ) then
		print( 'TeraLib ERROR: Query failed to execute - ' .. v )
	end
end } )

return DRIVER