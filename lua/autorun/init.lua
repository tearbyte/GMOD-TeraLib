if SERVER then
	print('{TeraLib initiating serverside...}')
	print('{Loading SERVERSIDE files...}')
	for k, v in pairs(file.Find('teralib/server/*', 'LUA')) do
		include('teralib/server/' .. v)
		print(v)
	end
	print('{Loading SHARED files...}')
	for k, v in pairs(file.Find('teralib/*', 'LUA')) do
		include('teralib/' .. v)
		AddCSLuaFile('teralib/' .. v)
		print(v)
	end
	print('{Sending CLIENT files to clientside...}')
	for k, v in pairs(file.Find('teralib/client/*', 'LUA')) do
		AddCSLuaFile('teralib/client/' .. v)
	end
	print('{TeraLib has done loading!}')
else
	print('{TeraLib initiating clientside...}')
	print('{Loading CLIENTSIDE files...}')
	for k, v in pairs(file.Find('teralib/client/*', 'LUA')) do
		include('teralib/client/' .. v)
		print(v)
	end
	print('{Loading SHARED files...}')
	for k, v in pairs(file.Find('teralib/*', 'LUA')) do
		include('teralib/' .. v)
		print(v)
	end
	print('{TeraLib has done loading!}')
end