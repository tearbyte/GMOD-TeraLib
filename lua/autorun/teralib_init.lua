local function load(path, client)
	if CLIENT and not client then return end
	if SERVER and client then AddCSLuaFile( 'teralib/' .. path .. '.lua' ) end
	if SERVER and path:find('client') then return end
	include( 'teralib/' .. path .. '.lua' )
end

local function ljust(str, length, padChar)
	padChar = padChar or ' '
	return str .. string.rep(padChar, math.max(0, length - #str))
end

local client_patches = {
	'globals',
	'lang',
	'net',
	'vgui',
	'draw'
}

local server_patches = {
	'globals',
	'net'
}

local shared_patches = {
	'enums',
	'tables',
	'util'
}

TeraLib = {}

function TeraLib.PrintLoad( str )
	print( '| ' .. ljust( str, 50 ) .. '|' )
end

print( '/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ TeraLib Loading ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\')
if SERVER then
	resource.AddWorkshop( '3013984464' )

	TeraLib.PrintLoad( 'Loading SERVERSIDE files...' )

	for k, v in pairs( server_patches ) do
		TeraLib.PrintLoad( 'server/' .. v .. '.lua' )
		load( 'server/' .. v, false )
	end

	TeraLib.PrintLoad( '' )
end

TeraLib.PrintLoad( ( CLIENT and 'Loading' or 'Sending' ) ..' CLIENTSIDE files...' )
for k, v in pairs( client_patches ) do
	TeraLib.PrintLoad( 'client/' .. v .. '.lua' )
	load( 'client/' .. v, true )
end

TeraLib.PrintLoad( '' )
TeraLib.PrintLoad( 'Loading SHARED files...' )
for k, v in pairs( shared_patches ) do
	TeraLib.PrintLoad( v .. '.lua' )
	load( v, true )
end

print( '\\_________________ TeraLib ready! __________________/')