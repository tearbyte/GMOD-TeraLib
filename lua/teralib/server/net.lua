TeraLib = TeraLib or {}
TeraLib.net = net

util.AddNetworkString('teralib_notify')

function TeraLib.net.BroadcastPlayers()
	local players = {}
	for _, ply in pairs(player.GetAll()) do
		if ply:IsAdmin() then table.insert(players, ply) end
	end
	net.SendOmit(players)
end

function TeraLib.net.BroadcastAdmins()
	local players = {}
	for _, ply in pairs(player.GetAll()) do
		if !ply:IsAdmin() then table.insert(players, ply) end
	end
	net.SendOmit(players)
end

function TeraLib.net.BroadcastSuperAdmins()
	local players = {}
	for _, ply in pairs(player.GetAll()) do
		if !ply:IsSuperAdmin() then table.insert(players, ply) end
	end
	net.SendOmit(players)
end