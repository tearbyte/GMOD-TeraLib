
TeraLib.DB = { Registered = {}, Types = { SQLite = 1, MySQL = 2 } }

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

function TeraLib.DB:GetType()
	return self.Type
end

local hasMySQLoo = util.IsBinaryModuleInstalled( 'mysqloo' )
TeraLib.PrintLoad( 'MySQLoo is ' .. ( hasMySQLoo and '' or 'NOT ') .. 'installed' )

if hasMySQLoo then
	TeraLib.PrintLoad( 'Connecting MySQLoo driver...' )
	TeraLib.DB._activeDBDriver = include( 'teralib/server/db/mysqloo.lua' )
	goto setType
end

--[[local hasTMySQL = util.IsBinaryModuleInstalled( 'tmysql' ) -- I... Why did I even put it here? I don't use tmysql
TeraLib.PrintLoad( 'TMySQL is ' .. ( hasMySQLoo and '' or 'NOT') .. ' installed' )
if hasTMySQL then
	TeraLib.PrintLoad( 'Connecting TMySQL driver...' )
	TeraLib.PrintLoad( 'Loading TMySQL...' )
	goto setType
end]]

TeraLib.PrintLoad( 'Fallback to built-in SQL...' )
TeraLib.DB._activeDBDriver = include( 'teralib/server/db/sqlite.lua' )

::setType::
-- 1 = SQLite, 2 = MySQL
TeraLib.DB.Type = TeraLib.DB._activeDBDriver._type
TeraLib.PrintLoad( 'SQL driver type loaded: ' .. ( TeraLib.DB:GetType() == TeraLib.DB.Types.SQLite and 'SQLite' or 'MySQL' ) )