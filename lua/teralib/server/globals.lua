TeraLib = TeraLib or {}

function TeraLib.Notify(ply, type, text, name, time)
	if !time then time = 0 end
	if !name then name = '' end
	net.Start('teralib_notify')
		net.WriteBit(1)
		net.WriteString(type)
		net.WriteString(text)
		net.WriteString(name)
		net.WriteInt(time, 32)
	net.Send(ply)
end

function TeraLib.Chat( ply, text, color )
	color = color or Color(152,212,255)
	net.Start('teralib_notify')
		net.WriteBit(0)
		net.WriteString(text)
		net.WriteColor(color)
	net.Send(ply)
end