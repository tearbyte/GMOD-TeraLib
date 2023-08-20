TeraLib = TeraLib or {}
TeraLib.net = {}

net.Receive('teralib_notify', function()
	if net.ReadBit() == 0 then
		TeraLib.Chat( net.ReadString(), net.ReadColor() )
	else
		TeraLib.Notify( net.ReadString(), net.ReadString(), net.ReadString(), net.ReadInt(32) )
	end
end)