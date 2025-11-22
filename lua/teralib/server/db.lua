
TeraLib.DB = { Registered = {} }

function TeraLib.DB:GetDriver()
	return self._activeDBDriver
end

function TeraLib.DB:Register( name, body )
	self.Registered[ name ] = body
end

function TeraLib.DB:Get( name )
	return self.Registered[ name ]
end

function TeraLib.DB:New( db_data )
	local db = self._activeDBDriver:New( db_data )
	db:Connect()
	return db
end

local hasMySQLoo = util.IsBinaryModuleInstalled( 'mysqloo' )
TeraLib.PrintLoad( 'MySQLoo is ' .. ( hasMySQLoo and '' or 'NOT ') .. 'installed' )

if hasMySQLoo then
	TeraLib.PrintLoad( 'Connecting MySQLoo driver...' )
	TeraLib.DB._activeDBDriver = include( 'teralib/server/db/mysqloo.lua' )
	return
end

--[[local hasTMySQL = util.IsBinaryModuleInstalled( 'tmysql' ) -- I... Why did I even put it here? I don't use tmysql
TeraLib.PrintLoad( 'TMySQL is ' .. ( hasMySQLoo and '' or 'NOT') .. ' installed' )

if hasTMySQL then
	TeraLib.PrintLoad( 'Loading TMySQL...' )
end]]

TeraLib.PrintLoad( 'Fallback to built-in SQL...' )
TeraLib.DB._activeDBDriver = include( 'teralib/server/db/sqlite.lua' )