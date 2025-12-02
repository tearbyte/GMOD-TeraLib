local DRIVER = {}
DRIVER.__index = DRIVER

function DRIVER:New() -- This will FOR SURE be replaced, if everything is alright
	error( 'TeraLib ERROR: No SQL driver connected. How did you even do that?')
end

function DRIVER:Connect()
end

function DRIVER:MakeTable( table_name, fields, checkexists )

	local isMySQL = self._type == TeraLib.DB.Types.MySQL
	local values = ''
	local len = #fields
	for ind, data in pairs( fields ) do
		local type = TeraLib.DB.DataTypes[ self._type ][ data.type ] or data.type
		local default = TeraLib.DB.DataTypes[ self._type ][ data.default ] or data.default

		local value = self:Escape( data.name ) .. ' ' .. type .. ( data.len ~= nil and isMySQL and ( '(' .. data.len .. ')' ) or '' ) .. ' '
		if data.unsigned then value = value .. 'UNSIGNED ' end
		if not data.nullable then value = value .. 'NOT NULL ' end
		if data.unique then value = value .. 'UNIQUE ' end
		if data.autoincrement and isMySQL then value = value .. 'AUTO_INCREMENT ' end
		if data.primarykey then value = value .. 'PRIMARY KEY ' end
		if default then value = value .. 'DEFAULT ' .. data.default .. ' ' end

		values = values .. value .. ( len > ind and ',' or '' )
	end

	self:KAQuery( 'CREATE TABLE ' .. ( checkexists and 'IF NOT EXISTS ' or ' ' ) .. table_name .. '(' .. values .. ');' )

end

function DRIVER:BuildQuery( query, args )
	local count = 0

	if #args < select( 2, query:gsub( '%?', '' ) ) then
		print( 'TeraLib WARNING: BuildQuery: Not enough arguments for placeholders!' )
	end

	local q = query:gsub( '%?', function()
		count = count + 1
		local v = args[count]

		if v == nil then return 'NULL' end
		if isnumber( v ) then return tostring( v ) end
		if isbool( v ) then return v and '1' or '0' end

		return self:Escape( tostring( v ), true )
	end)

	return q
end

function DRIVER:KAQuery()
end

function DRIVER:Query()
end

function DRIVER:QuerySync()
end

function DRIVER:QueryMany( query, args, callback )

	local queries = { TeraLib.DB.DataTypes[ self._type ].BeginWord }
	for _, row in ipairs(args) do
		table.insert( queries, self:BuildQuery( query, row ) .. ';' )
	end
	table.insert( queries, 'COMMIT;' )

	local queryString = table.concat( queries, ' ' )

	self:KAQuery( queryString, nil, callback )
end

function DRIVER:Disconnect()
end

function DRIVER:Escape()
end

function DRIVER:CreateTransaction()
	return
end

return DRIVER