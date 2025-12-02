
TeraLib.DB = {
	Registered = {},
	Types = { SQLite = 1, MySQL = 2 },
	-- If we need to transform...
	DataTypes = {
		-- SQLite
		{
			BeginWord = 'BEGIN;',

			INT = 'INTEGER',
			INTEGER = 'INTEGER',
			TINYINT = 'INTEGER',
			SMALLINT = 'INTEGER',
			MEDIUMINT = 'INTEGER',
			BIGINT = 'INTEGER',
			YEAR = 'INTEGER',
			INT1 = 'INTEGER',
			INT2 = 'INTEGER',
			INT3 = 'INTEGER',
			INT4 = 'INTEGER',
			INT8 = 'INTEGER',

			CHARACTER = 'TEXT',
			VARCHAR = 'TEXT',
			VARYING = 'TEXT',
			NCHAR = 'TEXT',
			NVARCHAR = 'TEXT',
			TEXT = 'TEXT',
			CLOB = 'TEXT',
			DATE = 'TEXT',
			TIME = 'TEXT',
			DATETIME = 'TEXT',
			TIMESTAMP = 'TEXT',
			LONGTEXT = 'TEXT',

			BLOB = 'BLOB',
			LONGBLOB = 'BLOB',
			JSON = 'BLOB',
			BINARY = 'BLOB',

			REAL = 'REAL',
			DOUBLE = 'REAL',
			FLOAT = 'REAL',

			NUMERIC = 'NUMERIC',
			DECIMAL = 'NUMERIC',
			BOOLEAN = 'NUMERIC',
		},
		-- MySQL
		{
			BeginWord = 'START TRANSACTION;',

			BOOL = 'TINYINT',
			BOOLEAN = 'TINYINT',
			CHARACTER = 'VARCHAR',
			FIXED = 'DECIMAL',
			FLOAT4 = 'FLOAT',
			FLOAT8 = 'DOUBLE',
			INT1 = 'TINYINT',
			INT2 = 'SMALLINT',
			INT3 = 'MEDIUMINT',
			INT4 = 'INT',
			INT8 = 'BIGINT',
			LONG = 'MEDIUMTEXT',
			MIDDLEINT = 'MEDIUMINT',
			NUMERIC = 'DECIMAL',
		},
	}
}

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

local hasMySQLoo = false --util.IsBinaryModuleInstalled( 'mysqloo' )
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