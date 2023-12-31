TeraLib = TeraLib or {}

function TeraLib.Chat( text, color )

	if !color then color = Color(152,212,255) end

	chat.AddText(color, text)

end

function TeraLib.Notify( type, text, name, time )
	if !time then time = 0 end
	if !name then name = '' end

	if type == 'prg' then
		notification.AddProgress(name, text)
		if time > 0 then timer.Simple(time, function ()	notification.Kill(name)	end) end
		return
	end

	local types = {
		gen = {NOTIFY_GENERIC, TeraLib.Sounds.GMOD_GENERIC},
		err = {NOTIFY_ERROR, TeraLib.Sounds.GMOD_ERROR},
		und = {NOTIFY_UNDO, TeraLib.Sounds.GMOD_GENERIC},
		hnt = {NOTIFY_HINT, TeraLib.Sounds.GMOD_GENERIC},
		cln = {NOTIFY_CLEANUP, TeraLib.Sounds.GMOD_GENERIC},
	}

	if types[type] ~= nil then
		local type = types[type]
		notification.AddLegacy(text, type[1], 5)
		surface.PlaySound(type[2])
	end


end