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

print( '/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ TeraLib Loading ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\')
if SERVER then
	resource.AddWorkshop( '3013984464' )

	print( '| Loading SERVERSIDE files...                       |' )

	for k, v in pairs( server_patches ) do
		load( 'server/' .. v, false )
		print( '| ' .. ljust( 'server/' .. v .. '.lua', 50 ) .. '|' )
	end

	print( '|                                                   |')
end

print( '| ' .. ( CLIENT and 'Loading' or 'Sending' ) ..' CLIENTSIDE files...                       |' )
for k, v in pairs( client_patches ) do
	load( 'client/' .. v, true )
	print( '| ' .. ljust( 'client/' .. v .. '.lua', 50 ) .. '|' )
end

print( '|                                                   |')
print( '| Loading SHARED files...                           |' )
for k, v in pairs( shared_patches ) do
	load( v, true )
	print( '| ' .. ljust( v .. '.lua', 50 ) .. '|' )
end

print( '\\_________________ TeraLib ready! __________________/')