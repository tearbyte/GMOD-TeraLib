TeraLib = TeraLib or {}

function TeraLib.Notify(ply, type, text, name, time)
	if !time then time = 0 end
	ply:SendLua('TeraLib.Notify("' .. type .. '","' .. text .. '","' .. name .. '",' .. time .. ')')
end

function TeraLib.Chat( ply, text, color )
	color = color or Color(152,212,255)
	ply:SendLua('TeraLib.Chat( util.JSONToTable(\'' .. util.TableToJSON(color) ..  '\'), "' .. text .. '")')
end

concommand.Add('teralib_test', function( ply )
	--TeraLib.Notify(ply, 'gen', 'HELLO!', 'popa')
	TeraLib.Chat(ply, "Hello~", Color(5, 124, 65))
end)