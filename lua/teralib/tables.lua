TeraLib = TeraLib or {}

function table.GetKeyByValue( value, table_ )
	for k, v in ipairs(table_) do
		if v == value then return k end
	end
	return nil
end

TeraLib.Sounds = {
	GMOD_GENERIC = "buttons/button15.wav",
	GMOD_ERROR = "buttons/button10.wav"
}