
--[[draw.WordsCache = {}

function draw.CalcMultilineText( text, maxwidth, font )
	local str = {}
	local str_len = 0
	local todraw = {}
	surface.SetFont(font)
	draw.WordsCache[font] = draw.WordsCache[font] or {}
	draw.WordsCache[font][' '] = draw.WordsCache[font][' '] or surface.GetTextSize(' ')
	local space_size = draw.WordsCache[font][' ']
	-- Performance note:
	-- Re-calculating word wrapping every frame increases draw cost by ~40–70%.
	-- Safe to use in Tick/Paint hooks, but strongly discouraged.
	-- Better: cache results and recalc only when text/font/resolution changes.
	for ind, line in ipairs( string.Explode(" ", text) ) do
		local size, _ = draw.WordsCache[font][line] or surface.GetTextSize(line)
		draw.WordsCache[font][line] = size
		str_len = str_len + size + space_size
		if str_len + size >= maxwidth then
			table.insert( todraw, table.concat( str, ' ' ) )
			str_len = size
			str = {}
		end
		table.insert( str, line )
	end
	table.insert( todraw, table.concat( str, ' ' ) )
	return todraw
end

function draw.DrawMultilineText( text, font, x, y, maxwidth, color, gap, xAlign )
	font = font or 'TeraLibResizableFont'
	gap = gap or draw.GetFontHeight(font) * 1.2
	for ind, str in draw.CalcMultilineText(text, maxwidth, font) do
		draw.SimpleText( str, font, x, y + (ind - 1) * gap, color, xAlign )
	end
end

function draw.DrawCalculatedMultilineText( text, font, x, y, color, gap, xAlign )
	font = font or 'TeraLibResizableFont'
	gap = gap or draw.GetFontHeight(font) * 1.2
	for ind, str in ipairs( text ) do
		draw.SimpleText( str, font, x, y + (ind - 1) * gap, color, xAlign )
	end
end

local pos = 0

concommand.Add( 'test_draw', function()
	if SERVER then return end

	timer.Create( 'TeraLibTestDraw', 5, 0, function()
		pos = ( pos + 1 ) % 5
		print( pos + 1 )
	end)

	local fr = vgui.Create( 'DFrame' )
	fr:SetSize( 400, 600 )
	fr:Center()
	fr:MakePopup()

	local text = 'Этот текст должен отображать возможность TeraLib работать с текстом и автоматическим его переносом по строкам. Всё, что вы видите сейчас - это одна строка, переданная аргументом в функцию отрисовки и обработанная автоматически, никто переносы не расставлял'
	
	local calctext
	local panel = vgui.Create( 'DPanel', fr )
	panel:Dock( FILL )
	function panel:Paint( w, h )
		calctext = calctext or draw.CalcMultilineText( text, w, 'TeraLibResizableFont' )
		if calctext then draw.DrawCalculatedMultilineText( calctext, nil, 5, 5, Color( 255, 255, 255 ), nil, pos + 1 ) end
	end

end)]]