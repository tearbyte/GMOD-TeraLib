TeraLib = TeraLib or {}
TeraLib.vgui = TeraLib.vgui or {}
TeraLib.vgui.PresetData = TeraLib.vgui.PresetData or {presets = {}}
TeraLib.vgui.BasicPresetData = {}
TeraLib.vgui.windows = TeraLib.vgui.windows or {}
TeraLib.vgui.Notifications = {}

local scrw, scrh = ScrW(), ScrH()

surface.CreateFont('TeraLibResizableFont', 
	{
		font = 'Roboto-Bold',
		size = ScrH() * 0.013,
		weight = 5550
	}
)

local function save_colors( base, base2, btn, hover, frac, scrp, scrh, sel, en, dis )
	TeraLib.vgui.Base = base or TeraLib.vgui.Base
	TeraLib.vgui.SecondBase = base2 or TeraLib.vgui.SecondBase
	TeraLib.vgui.ButtonColor = btn or TeraLib.vgui.ButtonColor
	TeraLib.vgui.Hover = hover or TeraLib.vgui.Hover
	TeraLib.vgui.Fraction = frac or TeraLib.vgui.Fraction
	TeraLib.vgui.ScrollPanelColor = scrp or TeraLib.vgui.ScrollPanelColor
	TeraLib.vgui.ScrollHead = scrh or TeraLib.vgui.ScrollHead
	TeraLib.vgui.Selection = sel or TeraLib.vgui.Selection
	TeraLib.vgui.Enable = en or TeraLib.vgui.Enable
	TeraLib.vgui.Disable = dis or TeraLib.vgui.Disable

	TeraLib.vgui.PresetData.cur = {
		Base = TeraLib.vgui.Base,
		SecondBase = TeraLib.vgui.SecondBase,
		ButtonColor = TeraLib.vgui.ButtonColor,
		Hover = TeraLib.vgui.Hover,
		Fraction = TeraLib.vgui.Fraction,
		ScrollPanelColor = TeraLib.vgui.ScrollPanelColor,
		ScrollHead = TeraLib.vgui.ScrollHead,
		Selection = TeraLib.vgui.Selection,
		Enable = TeraLib.vgui.Enable,
		Disable = TeraLib.vgui.Disable
	}

	file.Write('teralib_settings.json', util.TableToJSON(TeraLib.vgui.PresetData, true))
end

local function reload_colors()
	TeraLib.vgui.Base = Color(48, 56, 65)
	TeraLib.vgui.SecondBase = Color(68, 76, 85)
	TeraLib.vgui.ButtonColor = Color(90, 97, 96)
	TeraLib.vgui.Hover = Color(109, 115, 121)
	TeraLib.vgui.Fraction = Color(116, 190, 83)
	TeraLib.vgui.ScrollPanelColor = Color(58, 66, 75, 150)
	TeraLib.vgui.ScrollHead = Color(80, 87, 86, 150)
	TeraLib.vgui.Selection = Color(193, 109, 60)
	TeraLib.vgui.Enable = Color(7, 190, 232)
	TeraLib.vgui.Disable = Color(33, 41, 50)

	if !file.Exists('teralib_settings.json', 'DATA') then return end

	local data = util.JSONToTable(file.Read('teralib_settings.json', 'DATA'))

	if !data then return end

	TeraLib.vgui.Base =	data.cur.Base
	TeraLib.vgui.SecondBase = data.cur.SecondBase
	TeraLib.vgui.ButtonColor = data.cur.ButtonColor
	TeraLib.vgui.Hover = data.cur.Hover
	TeraLib.vgui.Fraction = data.cur.Fraction
	TeraLib.vgui.ScrollPanelColor = data.cur.ScrollPanelColor
	TeraLib.vgui.ScrollHead = data.cur.ScrollHead
	TeraLib.vgui.Selection = data.cur.Selection
	TeraLib.vgui.Enable = data.cur.Enable or TeraLib.vgui.Enable
	TeraLib.vgui.Disable = data.cur.Disable or TeraLib.vgui.Disable
	TeraLib.vgui.PresetData = data

	hook.Run('TeraLib_Update_VGUI')

end

-- Sublime Text Preset
local preset = {
	name = 'Sublime Text 3',
	Base = Color(48, 56, 65),
	SecondBase = Color(68, 76, 85),
	ButtonColor = Color(90, 97, 96),
	Hover = Color(109, 115, 121),
	Fraction = Color(116, 190, 83),
	ScrollPanelColor = Color(58, 66, 75, 150),
	ScrollHead = Color(80, 87, 86, 150),
	Selection = Color(193, 109, 60),
	Enable = Color(7, 190, 232),
	Disable = Color(33, 41, 50)
}

table.insert(TeraLib.vgui.BasicPresetData, preset)

function TeraLib.vgui.Settings()

	TeraLib.vgui.window = TeraLib.vgui.Window { isdraggable = true, anim = TVLIKE, size = {x = scrw * 0.4286, y = scrh * 0.5714}, text = TeraLib.lang.GetPhrase( 'TeraLib.Settings' ), center = true, upper_frame_height = 20 }
	local setting_list = TeraLib.vgui.PropertySheetVertical { parent = TeraLib.vgui.window, list = 100, button_size = 20 }

	local backplate = vgui.Create('DPanel', setting_list.canvas)
	backplate:Dock(FILL)
	backplate:SetBackgroundColor(TeraLib.vgui.Base)

	local basecolor1, basecolor2, buttoncolor, hovercolor, fractioncolor, scrollpanel, scrollhead, selectioncolor, enablecolor, disablecolor
	-- This is LOCAL settings. Like colors (in future with game settings... Maybe)
	local settings_tab = TeraLib.vgui.ScrollPanel { parent = backplate, dock = FILL }

	-- Base color section
	--local basecolor1_l, basecolor2_l = vgui.Create('DLabel', settings_tab), vgui.Create('DLabel', settings_tab)
	TeraLib.vgui.Label{ parent = settings_tab, size = {x = 220, y = 15}, pos = {x = 10, y = 70}, text = TeraLib.lang.GetPhrase( 'TeraLib.BaseColor' ) }
	TeraLib.vgui.Label{ parent = settings_tab, size = {x = 220, y = 15}, pos = {x = 250, y = 70}, text = TeraLib.lang.GetPhrase( 'TeraLib.SecondColor' ) }
	--basecolor1_l:SetSize(220, 15) basecolor2_l:SetSize(220, 15)
	--basecolor1_l:SetPos(10, 70) basecolor2_l:SetPos(250, 70)
	--basecolor1_l:SetText(TeraLib.lang.GetPhrase( 'TeraLib.BaseColor' )) basecolor2_l:SetText(TeraLib.lang.GetPhrase( 'TeraLib.SecondColor' ))

	local reset = TeraLib.lang.GetPhrase( 'reset' )
	local basecolor1_c, basecolor2_c = vgui.Create('DColorMixer', settings_tab), vgui.Create('DColorMixer', settings_tab)
	basecolor1_c:SetSize(220, 170) 						basecolor2_c:SetSize(220, 170)
	basecolor1_c:SetPos(10, 90) 						basecolor2_c:SetPos(250, 90)
	basecolor1_c:SetPalette(false) 						basecolor2_c:SetPalette(false)
	basecolor1_c:SetAlphaBar(false)						basecolor2_c:SetAlphaBar(false)
	basecolor1_c:SetColor(TeraLib.vgui.Base) 		basecolor2_c:SetColor(TeraLib.vgui.SecondBase)
	function basecolor1_c:ValueChanged( color )
		basecolor1 = color
	end
	function basecolor2_c:ValueChanged( color )
		basecolor2 = color
	end
	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 180, y = 240}, size = {x = 60, y = 15}, text = reset, dock = nil, DoClick = function() basecolor1_c:SetColor(TeraLib.vgui.Base) end } 
	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 420, y = 240}, size = {x = 60, y = 15}, text = reset, dock = nil, DoClick = function() basecolor2_c:SetColor(TeraLib.vgui.SecondBase) end }

	-- Button color section
	local buttoncolor_l, hovercolor_l = vgui.Create('DLabel', settings_tab), vgui.Create('DLabel', settings_tab)
	buttoncolor_l:SetSize(220, 15) hovercolor_l:SetSize(220, 15)
	buttoncolor_l:SetPos(10, 280) hovercolor_l:SetPos(250, 280)
	buttoncolor_l:SetText(TeraLib.lang.GetPhrase( 'TeraLib.ButtonColor' )) hovercolor_l:SetText(TeraLib.lang.GetPhrase( 'TeraLib.HoverColor' ))

	local buttoncolor_c, hovercolor_c = vgui.Create('DColorMixer', settings_tab), vgui.Create('DColorMixer', settings_tab)
	buttoncolor_c:SetSize(220, 170) 					hovercolor_c:SetSize(220, 170)
	buttoncolor_c:SetPos(10, 300) 						hovercolor_c:SetPos(250, 300)
	buttoncolor_c:SetPalette(false) 					hovercolor_c:SetPalette(false)
	buttoncolor_c:SetColor(TeraLib.vgui.ButtonColor) 	hovercolor_c:SetColor(TeraLib.vgui.Hover)
	function buttoncolor_c:ValueChanged( color )
		buttoncolor = color
	end
	function hovercolor_c:ValueChanged( color )
		hovercolor = color
	end
	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 180, y = 450}, size = {x = 60, y = 15}, text = reset, dock = nil, DoClick = function() buttoncolor_c:SetColor(TeraLib.vgui.ButtonColor) end } 
	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 420, y = 450}, size = {x = 60, y = 15}, text = reset, dock = nil, DoClick = function() hovercolor_c:SetColor(TeraLib.vgui.Hover) end }

	-- Continue to button
	local buttonfraction_l, buttonselection_l = vgui.Create('DLabel', settings_tab), vgui.Create('DLabel', settings_tab)
	buttonfraction_l:SetSize(220, 15) buttonselection_l:SetSize(220, 15)
	buttonfraction_l:SetPos(10, 490) buttonselection_l:SetPos(250, 490)
	buttonfraction_l:SetText(TeraLib.lang.GetPhrase( 'TeraLib.Fraction' )) buttonselection_l:SetText(TeraLib.lang.GetPhrase( 'TeraLib.Selection' ))

	local buttonfraction_c, buttonselection_c = vgui.Create('DColorMixer', settings_tab), vgui.Create('DColorMixer', settings_tab)
	buttonfraction_c:SetSize(220, 170) 					buttonselection_c:SetSize(220, 170)
	buttonfraction_c:SetPos(10, 510) 					buttonselection_c:SetPos(250, 510)
	buttonfraction_c:SetPalette(false) 					buttonselection_c:SetPalette(false)
	buttonfraction_c:SetColor(TeraLib.vgui.Fraction)	buttonselection_c:SetColor(TeraLib.vgui.Selection)
	function buttonfraction_c:ValueChanged( color )
		fractioncolor = color
	end
	function buttonselection_c:ValueChanged( color )
		selectioncolor = color
	end
	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 180, y = 660}, size = {x = 60, y = 15}, text = reset, dock = nil, DoClick = function() buttonfraction_c:SetColor(TeraLib.vgui.Fraction) end } 
	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 420, y = 660}, size = {x = 60, y = 15}, text = reset, dock = nil, DoClick = function() buttonselection_c:SetColor(TeraLib.vgui.Selection) end } 

	local buttonenable_l, buttondisable_l = vgui.Create('DLabel', settings_tab), vgui.Create('DLabel', settings_tab)
	buttonenable_l:SetSize(220, 15) buttondisable_l:SetSize(220, 15)
	buttonenable_l:SetPos(10, 700) buttondisable_l:SetPos(250, 700)
	buttonenable_l:SetText(TeraLib.lang.GetPhrase( 'TeraLib.CheckBoxEnable' )) buttondisable_l:SetText(TeraLib.lang.GetPhrase( 'TeraLib.CheckBoxDisable' ))

	local buttonenable_c, buttondisable_c = vgui.Create('DColorMixer', settings_tab), vgui.Create('DColorMixer', settings_tab)
	buttonenable_c:SetSize(220, 170) 					buttondisable_c:SetSize(220, 170)
	buttonenable_c:SetPos(10, 720) 						buttondisable_c:SetPos(250, 720)
	buttonenable_c:SetPalette(false) 					buttondisable_c:SetPalette(false)
	buttonenable_c:SetColor(TeraLib.vgui.Enable)		buttondisable_c:SetColor(TeraLib.vgui.Disable)
	function buttonenable_c:ValueChanged( color )
		enablecolor = color
	end
	function buttondisable_c:ValueChanged( color )
		disablecolor = color
	end
	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 180, y = 870}, size = {x = 60, y = 15}, text = reset, dock = nil, DoClick = function() buttonenable_c:SetColor(TeraLib.vgui.Enable) end } 
	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 420, y = 870}, size = {x = 60, y = 15}, text = reset, dock = nil, DoClick = function() buttondisable_c:SetColor(TeraLib.vgui.Disable) end } 

	-- Scroll panel color section
	local scrollpanel_l, scrollhead_l = vgui.Create('DLabel', settings_tab), vgui.Create('DLabel', settings_tab)
	scrollpanel_l:SetSize(220, 15) scrollhead_l:SetSize(220, 15)
	scrollpanel_l:SetPos(10, 910) scrollhead_l:SetPos(250, 910)
	scrollpanel_l:SetText(TeraLib.lang.GetPhrase( 'TeraLib.ScrollPanel' )) scrollhead_l:SetText(TeraLib.lang.GetPhrase( 'TeraLib.ScrollHead' ))

	local scrollpanel_c, scrollhead_c = vgui.Create('DColorMixer', settings_tab), vgui.Create('DColorMixer', settings_tab)
	scrollpanel_c:SetSize(220, 170) 					scrollhead_c:SetSize(220, 170)
	scrollpanel_c:SetPos(10, 930) 						scrollhead_c:SetPos(250, 930)
	scrollpanel_c:SetPalette(false) 					scrollhead_c:SetPalette(false)
	scrollpanel_c:SetColor(TeraLib.vgui.ScrollPanelColor) scrollhead_c:SetColor(TeraLib.vgui.ScrollHead)
	function scrollpanel_c:ValueChanged( color )
		scrollpanel = color
	end
	function scrollhead_c:ValueChanged( color )
		scrollhead = color
	end
	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 180, y = 1080}, size = {x = 60, y = 15}, text = reset, dock = nil, DoClick = function() buttoncolor_c:SetColor(TeraLib.vgui.ScrollPanelColor) end } 
	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 420, y = 1080}, size = {x = 60, y = 15}, text = reset, dock = nil, DoClick = function() hovercolor_c:SetColor(TeraLib.vgui.ScrollHead) end }

	local function colors() 
		save_colors( basecolor1, basecolor2, buttoncolor, hovercolor, fractioncolor, scrollpanel, scrollhead, selectioncolor, enablecolor, disablecolor )
		hook.Run('TeraLibReloadGUI')
	end

	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 10, y = 40}, size = {x = 100, y = 20}, text = TeraLib.lang.GetPhrase( 'TeraLib.SaveColors' ), dock = nil, DoClick = colors }

	-- Preset system
	local presets = TeraLib.vgui.ComboBox { parent = settings_tab, pos = {x = 10, y = 10}, size = {x = 210, y = 20} }

	local update_presets = function(setoption)
		presets:Clear()
		presets:AddChoice(TeraLib.lang.GetPhrase( 'TeraLib.BuiltInPresets' ))
		presets:AddChoices(TeraLib.vgui.BasicPresetData)
		presets:AddSpacer()
		presets:AddChoice(TeraLib.lang.GetPhrase( 'TeraLib.UserPresets' ))
		presets:AddChoices(TeraLib.vgui.PresetData.presets)
		presets:ChooseOptionID(setoption or 2)
	end

	update_presets()

	--presets.OnSelect = onselect

	local load_preset = function()
		local id = presets:GetSelectedID()
		local name, _ = presets:GetSelected()
		if id - 1 <= #TeraLib.vgui.BasicPresetData then
			data = TeraLib.vgui.BasicPresetData[id - 1]
		elseif id - 2 <= #TeraLib.vgui.BasicPresetData + table.Count(TeraLib.vgui.PresetData.presets) then
			data = TeraLib.vgui.PresetData.presets[name]
		end
		if !data then return end
		basecolor1_c:SetColor(data.Base)
		basecolor2_c:SetColor(data.SecondBase)
		buttoncolor_c:SetColor(data.ButtonColor)
		hovercolor_c:SetColor(data.Hover)
		buttonfraction_c:SetColor(data.Fraction)
		scrollpanel_c:SetColor(data.ScrollPanelColor)
		scrollhead_c:SetColor(data.ScrollHead)
		buttonselection_c:SetColor(data.Selection)
		buttonenable_c:SetColor(data.Enable)
		buttondisable_c:SetColor(data.Disable)
	end 

	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 230, y = 10}, size = {x = 100, y = 20}, text = TeraLib.lang.GetPhrase( 'TeraLib.LoadPreset' ), dock = nil, DoClick = load_preset }

	local function set_preset()
		load_preset()
		colors()
	end

	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 340, y = 10}, size = {x = 100, y = 20}, text = TeraLib.lang.GetPhrase( 'TeraLib.LoadPresetAndReset' ), dock = nil, DoClick = set_preset }

	local function save_preset()
		local name, data = presets:GetSelected()
		local id = presets:GetSelectedID()

		data = {
			name = name,
			Base = basecolor1_c:GetColor() or TeraLib.vgui.Base,
			SecondBase = basecolor2_c:GetColor() or TeraLib.vgui.SecondBase,
			ButtonColor = buttoncolor_c:GetColor() or TeraLib.vgui.ButtonColor,
			Hover = hovercolor_c:GetColor() or TeraLib.vgui.Hover,
			Fraction = buttonfraction_c:GetColor() or TeraLib.vgui.Fraction,
			ScrollPanelColor = scrollpanel_c:GetColor() or TeraLib.vgui.ScrollPanelColor,
			ScrollHead = scrollhead_c:GetColor() or TeraLib.vgui.ScrollHead,
			Selection = buttonselection_c:GetColor() or TeraLib.vgui.Selection,
			Enable = buttonenable_c:GetColor() or TeraLib.vgui.Enable,
			Disable = buttondisable_c:GetColor() or TeraLib.vgui.Disable
		} or data

		TeraLib.vgui.PresetData.presets[data.name] = data
		save_colors()
		update_presets(id)
	end

	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 230, y = 40}, size = {x = 100, y = 20}, text = TeraLib.lang.GetPhrase( 'TeraLib.SavePreset' ), dock = nil, DoClick = save_preset }

	local function remove_preset( self )
		local name, _ = presets:GetSelected()
		TeraLib.vgui.PresetData.presets[tonumber(name) or name] = nil
		save_colors()
		update_presets()
	end

	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 120, y = 40}, size = {x = 100, y = 20}, text = TeraLib.lang.GetPhrase( 'TeraLib.RemovePreset' ), dock = nil, DoClick = remove_preset }

	local function create_preset()
		local wind = TeraLib.vgui.Window {center = true, donthide = true, isdraggable = true, size = {x = 500, y = 120}, text = TeraLib.lang.GetPhrase( 'TeraLib.NewPreset' ), upper_frame_height = 20 }
		function wind.parent:Hide() wind.parent:Remove() end

		table.insert(TeraLib.vgui.windows, wind)

		local textentry = TeraLib.vgui.TextEntry {parent = wind, placeholder = TeraLib.lang.GetPhrase( 'TeraLib.InsertName' ), size = {x = 400, y = 20}, pos = {x = 50, y = 20} }

		local function new_preset()
			local name = textentry:GetText()
			if name == '' then wind:Remove() return end
			TeraLib.vgui.PresetData.presets[name] = {
				name = name,
				Base = TeraLib.vgui.Base,
				SecondBase = TeraLib.vgui.SecondBase,
				ButtonColor = TeraLib.vgui.ButtonColor,
				Hover = TeraLib.vgui.Hover,
				Fraction = TeraLib.vgui.Fraction,
				ScrollPanelColor = TeraLib.vgui.ScrollPanelColor,
				ScrollHead = TeraLib.vgui.ScrollHead,
				Selection = TeraLib.vgui.Selection,
				Enable = TeraLib.vgui.Enable,
				Disable =  TeraLib.vgui.Disable,
			}

			update_presets()

			wind:Remove()
		end

		TeraLib.vgui.ColorableButton {parent = wind, pos = {x = 200, y = 60}, size = {x = 100, y = 20}, text = TeraLib.lang.GetPhrase( 'TeraLib.Create' ), DoClick = new_preset }

	end

	TeraLib.vgui.ColorableButton {parent = settings_tab, pos = {x = 340, y = 40}, size = {x = 100, y = 20}, text = TeraLib.lang.GetPhrase( 'TeraLib.NewPreset' ), dock = nil, DoClick = create_preset }

	local about_panel = vgui.Create('DPanel', setting_list.canvas)
	about_panel:SetBackgroundColor(TeraLib.vgui.Base)
	TeraLib.vgui.PoweredBy { parent = about_panel }
	local text = TeraLib.vgui.Label { parent = about_panel, dock = FILL, dockmargin = {7, 7, 7, 7}, text = TeraLib.lang.GetPhrase( 'TeraLib.Explanation' ), alignment = 7 }

	local buttons = {
		{text = TeraLib.lang.GetPhrase( 'TeraLib.vgui' ), tab = settings_tab},
		{text = TeraLib.lang.GetPhrase( 'TeraLib.About' ), tab = about_panel},
		default_tab = 1
	}

	setting_list:SetSheets(buttons)

	hook.Run('TeraLibGUIReady', TeraLib.vgui.window)

end

function TeraLib.vgui.ComboBox( data )
	local combobox = vgui.Create( 'DComboBox', data.parent )
	combobox:SetSortItems(data.sort)
	if data.dockmargin then combobox:DockMargin(data.dockmargin[1], data.dockmargin[2], data.dockmargin[3], data.dockmargin[4]) end
	if data.dock then combobox:Dock(data.dock) end
	if data.dockpadding then combobox:DockPadding(data.dockpadding[1], data.dockpadding[2], data.dockpadding[3], data.dockpadding[4]) end
	if data.size then combobox:SetSize(data.size.x, data.size.y) end
	if data.pos then combobox:SetPos(data.pos.x, data.pos.y) end
	combobox:SetFont(data.font or 'TeraLibResizableFont')
	local color = data.color or TeraLib.vgui.SecondBase
	combobox:SetColor(Color(255 - color.r, 255 - color.g, 255 - color.b))

	function combobox:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, color)
	end
	
	function combobox:AddChoices( data )
		for _, opt in pairs(data) do
			combobox:AddChoice(opt.name, opt.data or opt)
		end
	end

	if data.options then combobox:AddChoices(data.options) end

	if data.OnSelect then combobox.OnSelect = data.OnSelect end

	return combobox

end

function TeraLib.vgui.TextEntry( data )

	local textentry = vgui.Create( 'DTextEntry', data.parent )
	if data.dock then textentry:Dock(data.dock) end
	if data.dockmargin then textentry:DockMargin(data.dockmargin[1], data.dockmargin[2], data.dockmargin[3], data.dockmargin[4]) end
	if data.size then textentry:SetSize(data.size.x, data.size.y) end
	if data.pos then textentry:SetPos(data.pos.x, data.pos.y) end
	textentry:SetEditable(true)
	if data.font then textentry:SetFont(data.font) end
	if data.placeholder then textentry:SetPlaceholderText(data.placeholder) end

	return textentry
end

function TeraLib.vgui.PoweredBy( data )
	data = data or {}
	data.dock = data.dock or BOTTOM
	data.background = data.background or TeraLib.vgui.Base
	local frame = vgui.Create('DPanel', data.parent)
	frame:Dock(data.dock)
	frame:SetSize(1, 70)
	frame:DockPadding(3, 3, 3, 3)
	frame:DockMargin(5, 5, 5, 5)
	frame:SetBackgroundColor(TeraLib.vgui.SecondBase)
	frame.image = TeraLib.vgui.Image {parent = frame, dock = LEFT, dockmargin = {3, 3, 3, 3}, image = "teralib/logo", size = {64, 64}}
	frame.text = TeraLib.vgui.Label {parent = frame, dock = TOP, dockmargin = {0, 3, 3, 3}, text = TeraLib.lang.GetPhrase( "TeraLib.poweredby" ), font = data.font}--"Powered by TeraLib"}
	frame.button = TeraLib.vgui.ColorableButton {parent = frame, fraction_on_hover = true, fraction_type = SIDETOCENTER, dock = BOTTOM, font = data.font, dockmargin = {0, 3, 3, 3}, text = TeraLib.lang.GetPhrase( "TeraLib.download" ), DoClick = function() gui.OpenURL('https://steamcommunity.com/sharedfiles/filedetails/?id=3013984464') end} -- "Download"
	return frame
end

function TeraLib.vgui.Label( data )
	local label = vgui.Create('DLabel', data.parent)
	label:SetText(data.text or '')
	if data.size then label:SetSize(data.size.x, data.size.y) end
	if data.pos then label:SetPos(data.pos.x, data.pos.y) end
	if data.font then label:SetFont(data.font) else label:SetFont('TeraLibResizableFont') end
	if data.alignment then label:SetContentAlignment(data.alignment) end
	if data.dock then label:Dock(data.dock) end
	if data.dockmargin then label:DockMargin(data.dockmargin[1], data.dockmargin[2], data.dockmargin[3], data.dockmargin[4]) end
	return label
end

function TeraLib.vgui.Image( data )
	local image = vgui.Create('DImage', data.parent)
	if data.dock then image:Dock(data.dock) end
	if data.dockmargin then image:DockMargin(data.dockmargin[1], data.dockmargin[2], data.dockmargin[3], data.dockmargin[4]) end
	if data.image then image:SetImage(data.image) end
	if data.material then image:SetMaterial(data.material) end
	return image
end

function TeraLib.vgui.ColorableButton( data )
	data.alignment = 5
	local button = TeraLib.vgui.Label(data)
	button:SetMouseInputEnabled(true)
	button.fraction = 0
	if data.DoClick then button.DoClick = data.DoClick end

	function button:SetEnabled( enable )
		self.enabled = enable
		if enable then
			if self.oldclick then self.DoClick = self.oldclick end
			self.color = data.button_color or TeraLib.vgui.ButtonColor
			self.hover_color = data.hover_color or TeraLib.vgui.Hover
		else
			self.oldclick = self.DoClick
			self.DoClick = function() end
			self.color = data.button_color or TeraLib.vgui.ButtonColor
			self.color = {r = self.color.r - 20, g = self.color.g - 20, b = self.color.b - 20}
			self.hover_color = self.color
		end
	end

	button:SetEnabled(data.disable and !data.disable or true)

	button.fraction_color = data.fraction_color or TeraLib.vgui.Fraction
	button.selection_color = data.select_color or TeraLib.vgui.Selection

	button_types = {
		-- Normal button
		{
			paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, self.color) end,
			hover = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, self.hover_color) end,
			selection = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, self.selection_color) end
		},
		-- Nobgcolor (Like only outlines, no filling)
		{
			paint = function(self, w, h)
				surface.DrawOutlinedRect(0, 0, w, h)
			end,
			hover = function(self, w, h)
				surface.DrawOutlinedRect(0, 0, w, h)
			end,
			selection = function(self, w, h) surface.DrawOutlinedRect(0, 0, w, h) end
		}
	}

	button_paints = {
		-- LEFTTORIGHT
		function(self, w, h) draw.RoundedBox(0, 0, 0, w * self.fraction, h, self.fraction_color) end,
		function(self, w, h) 
			draw.RoundedBox(0, 0, 0, w * 0.5 * self.fraction, h, self.fraction_color)
			draw.RoundedBox(0, w * (1 - self.fraction * 0.5), 0, w * 0.5 * self.fraction, h, self.fraction_color)
		end,
		function(self, w, h)
			draw.RoundedBox(0, w * 0.5, 0, w * 0.5 * self.fraction, h, self.fraction_color)
			draw.RoundedBox(0, w * 0.5 * (1 - self.fraction) + 1, 0, (w + 1) * 0.5 * self.fraction, h, self.fraction_color)
		end,
		function(self, w, h) draw.RoundedBox(0, 0, h * (1 - self.fraction), w, h * self.fraction, self.fraction_color) end,
		function(self, w, h)
			draw.RoundedBox(0, w * self.fraction - w * .5, 0, w * 0.33, h, self.fraction_color)
			self.fraction = (self.fraction + FrameTime() * 1.2) % 1.5
		end
	}

	button_transparent_paints = {
		function(self, w, h)
			surface.DrawLine(0, 0, w * self.fraction, 0)
			surface.DrawLine(0, h - 1, w * self.fraction, h - 1)
			if self.fraction != 0 then surface.DrawLine(0, 0, 0, h) end
			if self.fraction == 1 then surface.DrawLine(w - 1, 0, w - 1, h) end
		end,
		function(self, w, h) 
			surface.DrawLine(0, 0, w * 0.5 * self.fraction, 0)
			surface.DrawLine(0, h - 1, w * 0.51 * self.fraction, h - 1)
			surface.DrawLine(w, 0, w * (1 - 0.51 * self.fraction), 0)
			surface.DrawLine(w, h - 1, w * (1 - 0.5 * self.fraction), h - 1)
			if self.fraction != 0 then
				surface.DrawLine(0, 0, 0, h)
				surface.DrawLine(w - 1, 0, w - 1, h)
			end
		end,
		function(self, w, h)
			surface.DrawLine(w * 0.5, 0, w * 0.5 * (1 - self.fraction), 0)
			surface.DrawLine(w * 0.5, h - 1, w * 0.5 * (1 - self.fraction), h - 1)
			surface.DrawLine(w * 0.5, h - 1, w * 0.5 + w * 0.5 * self.fraction, h - 1)
			surface.DrawLine(w * 0.5, 0, w * 0.5 + w * 0.5 * self.fraction, 0)
			if self.fraction == 1 then
				surface.DrawLine(0, 0, 0, h)
				surface.DrawLine(w - 1, 0, w - 1, h)
			end
		end,
		function(self, w, h)
			surface.DrawLine(0, h, 0, h * (1 - button.fraction))
			surface.DrawLine(w - 1, h, w - 1, h * (1 - button.fraction))
			if self.fraction == 1 then
				surface.DrawLine(0, 0, w, 0)
			end
			if self.fraction != 0 then
				surface.DrawLine(0, h - 1, w, h - 1)
			end
		end,
	}

	local type = button_types[data.nobgcolor and 2 or 1]
	if !data.fraction_type and data.fraction_on_hover then data.fraction_type = 1 end

	button.hover_paint = type.hover
	button.basic_paint = type.paint
	button.selection_paint = type.selection

	button.fraction_paint = data.type and data.type > 1 and button_transparent_paints[data.fraction_type or 1] or button_paints[data.fraction_type or 1]

	function button:Think()

		local speed = FrameTime() * 2

		local hover = self:IsHovered()
		if hover and self.enabled then self:SetCursor('hand')
		elseif hover and !self.enabled then self:SetCursor('no') end

		if !data.fraction_on_hover then return end
		if hover and self.fraction < 1 then
			self.fraction = self.fraction + speed
		elseif !hover and data.fraction_type > 0 and self.fraction > 0 then
			self.fraction = self.fraction - speed
		end

		if self.fraction > 1 then self.fraction = 1 end
		if self.fraction < 0  then self.fraction = 0 end

	end

	if data.think then button.Think = data.think end

	function button:Paint(w, h)
		local hover = self:IsHovered()
		if hover then
			surface.SetDrawColor(self.hover_color)
			self:hover_paint(w, h)
		else
			surface.SetDrawColor(self.color) 
			self:basic_paint(w, h)
		end
		if self.select then
			surface.SetDrawColor(self.selection_color)
			self:selection_paint(w, h)
		end
		if data.fraction_type == nil then return end
		surface.SetDrawColor(self.fraction_color)
		self:fraction_paint(w, h)
	end

	return button
end

function TeraLib.vgui.Switch( data )
	data.type = data.type or 1
	if data.type > 2 then data.size = {x = data.height * 2, y = data.height}
	else data.size = {x = data.height, y = data.height} end
	local button = TeraLib.vgui.ColorableButton( data )

	button.active = data.active or false
	button.butpos = 0

	button.OnToggle = data.OnToggle

	data.active_color = data.nobgcolor and TeraLib.vgui.Hover or (data.active_color or TeraLib.vgui.Enable)
	data.inactive_color = data.nobgcolor and TeraLib.vgui.SecondBase or (data.inactive_color or TeraLib.vgui.Disable)

	function button:DoClick()
		self.active = !self.active
		if self.OnToggle then self:OnToggle(self.active) end
	end

	function button:Think()
		if self:IsHovered() then self:SetCursor('hand')	end
		if self.active and self.butpos < 0.5 then self.butpos = self.butpos + 0.05
		elseif !self.active and self.butpos > 0 then self.butpos = self.butpos - 0.05 end
		if self.butpos > 0.5 then self.butpos = 0.5
		elseif self.butpos < 0 then self.butpos = 0 end
		local butpos = self.butpos * 2
		self.active_color = {r = data.active_color.r * butpos + data.inactive_color.r * (1 - butpos), g = data.active_color.g * butpos + data.inactive_color.g * (1 - butpos), b = data.active_color.b * butpos + data.inactive_color.b * (1 - butpos)}
	end

	local paints = {
		function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, self.active_color) end,
		function(self, w, h) draw.RoundedBox(h * 0.5, 0, 0, w, h, self.active_color) end,
		function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, self.active_color)
			draw.RoundedBox(0, h * 0.05 + self.butpos * w, h * 0.05, h * 0.9, h * 0.9, data.button_color or TeraLib.vgui.ButtonColor)
		end,
		function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, data.color or TeraLib.vgui.SecondBase)
			draw.RoundedBox(0, h * 0.05 + self.butpos * w, h * 0.05, h * 0.9, h * 0.9, data.button_color or TeraLib.vgui.ButtonColor)
			draw.RoundedBox(0, h * 0.15 + self.butpos * w, h * 0.15, h * 0.7, h * 0.7, self.active_color)
		end,
		function(self, w, h)
			draw.RoundedBox(h * 0.5, 0, 0, w, h, self.active_color)
			draw.RoundedBox(h * 0.5, h * 0.05 + self.butpos * w, h * 0.05, h * 0.9, h * 0.9, data.button_color or TeraLib.vgui.ButtonColor)
		end,
		function(self, w, h)
			draw.RoundedBox(h * 0.5, 0, 0, w, h, data.color or TeraLib.vgui.SecondBase)
			draw.RoundedBox(h * 0.5, h * 0.05 + self.butpos * w, h * 0.05, h * 0.9, h * 0.9, data.button_color or TeraLib.vgui.ButtonColor)
			draw.RoundedBox(h * 0.5, h * 0.15 + self.butpos * w, h * 0.15, h * 0.7, h * 0.7, self.active_color)
		end,
	}

	button.Paint = paints[data.type or 1]

end

function TeraLib.vgui.Window( data )
	local panel = vgui.Create('EditablePanel')
	if data.size then panel:SetSize(data.size.x, data.size.y) end
	if data.pos then panel:SetPos(data.pos.x, data.pos.y) end
	if data.center then panel:Center() data.pos = {} data.pos.x, data.pos.y = panel:LocalToScreen() end
	panel.size = {panel:GetSize()}
	panel.pos = data.pos
	panel.center = data.center
	panel.anim_time = data.anim_time
	if !data.nopopup then panel:MakePopup() end

	local anims = {
		{Anim = function(self)
			local frt = FrameTime() / (self.anim_time ~= nil and self.anim_time or 0.6)
			local size = {self:GetSize()}
			if self.open then
				self:Show()
				if size[1] < self.size[1] then size[1] = size[1] + self.size[1] * frt end
				if size[2] < self.size[2] then size[2] = size[2] + self.size[2] * frt end
			else
				if size[1] > 0 then size[1] = size[1] - self.size[1] * frt end
				if size[2] > 0 then size[2] = size[2] - self.size[2] * frt end
			end
			if size[1] < 0 then size[1] = 0 end
			if size[2] < 0 then size[2] = 0 end
			if size[1] == self.size[1] and size[2] == self.size[2] then return end
			if size[1] == 0 and size[2] == 0 then self:Hide() end
			self:SetSize(size[1], size[2])
			if self.pos then self:SetPos(self.pos.x, self.pos.y) end
			if self.center then self:Center() end
		end},
		{Anim = function(self)
			local frt = FrameTime() / (self.anim_time ~= nil and self.anim_time or 0.6)
			local size = {self:GetSize()}
			if self.open then
				self:Show()
				if size[1] < self.size[1] then size[1] = size[1] + self.size[1] * frt * 2 end
				if size[2] < self.size[2] then size[2] = size[2] + self.size[2] * frt * 2 end
				if size[1] > self.size[1] then size = self.size end
			else
				if size[2] > 0 and size[2] >= 4 then size[2] = size[2] - self.size[2] * frt * 2 end
				if size[2] < 4 then size[2] = 4 end
				if size[1] > 0 and size[2] <= 4 then size[1] = size[1] - self.size[1] * frt * 1.5 end
			end
			if size[1] == self.size[1] and size[2] == self.size[2] then return end
			self:SetSize(size[1], size[2])
			if size[1] == 0 and size[2] == 4 then self:Hide() end
			if self.pos then self:SetPos(self.pos.x, self.pos.y) end
			if self.center then self:Center() end
		end
		}
	}

	local draw_window = vgui.Create('DPanel', panel)
	if !data.color then data.color = TeraLib.vgui.Base end
	draw_window:Dock(FILL)
	draw_window:SetBackgroundColor(data.color)
	local wind_x, wind_y = panel:GetSize()

	table.insert(TeraLib.vgui.windows, panel)

	local upf_x, upf_y = 0, 0
	local marg_x, marg_y = 0, 0

	if !data.noupperframe then
		-- Upper panel with close button and title
		panel.upper_frame = vgui.Create('DPanel', panel)
		panel.upper_frame:SetSize(wind_x, data.upper_frame_height or wind_y / 15)
		panel.upper_frame:Dock(TOP)
		panel.upper_frame:SetBackgroundColor(data.upper_frame_color or TeraLib.vgui.SecondBase)
		upf_x, upf_y = panel.upper_frame:GetSize()

		-- Title
		marg_x, marg_y = upf_x * 0.01 > 2 and upf_x * 0.01 or 2, upf_y * .2 - 4
		panel.title = TeraLib.vgui.Label{ parent = panel.upper_frame, dock = LEFT, dockmargin = {marg_x, marg_y, 2, marg_y}, size = {x = upf_x * 0.6, y = upf_y - 4}, font = data.font, text = data.text or '', alignment = 4}
	end

	-- Main workspace
	local window = vgui.Create('DPanel', panel)
	window:SetBackgroundColor({r = 0, g = 0, b = 0, a = 0})
	window:Dock(FILL)
	window:SetSize(data.size.x - marg_x, data.size.y)
	window.size = {data.size.x - marg_x, data.size.y}
	window.parent = draw_window
	function window:Hide() panel:Hide() end
	function window:Show() panel:Show() end
	function window:Remove() panel:Remove() end

	if !data.noupperframe then
		-- Close button
		draw_window.close_button = TeraLib.vgui.ColorableButton {parent = panel.upper_frame, text = 'X', font = data.font, size = {x = upf_y, y = upf_y}, dock = RIGHT, DoClick = function() window:Hide() end }
	end

	if data.anim then
		window.Show = function(self) panel.open = true panel:Think() end
		window.Hide = function(self) panel.open = false end
		panel.Anim = anims[data.anim].Anim
	end

 	panel.Think = function(self)
    	if self.Anim then self:Anim() end
    end

	if !data.isdraggable then
		if !data.donthide then window:Hide() end 
		return window 
	end

    local bDragging = false
    local offsetX, offsetY = 0, 0

    panel.upper_frame.OnMousePressed = function(self, keyCode)
        if keyCode == MOUSE_LEFT then
        	self:SetCursor('sizeall')
            local x, y = self:ScreenToLocal(gui.MousePos())
            offsetX, offsetY = x, y
            bDragging = true
        end
    end

    panel.upper_frame.OnMouseReleased = function(self) self:SetCursor('arrow') bDragging = false end

    panel.Think = function(self)
    	if self.Anim then self:Anim() end
        if bDragging then
            local x, y = gui.MousePos()
            self:SetPos(x - offsetX, y - offsetY)
        end
    end

   	if !data.donthide then window:Hide() end 

	return window
end

function TeraLib.vgui.ScrollPanel( data )
	local scrollpanel = vgui.Create( "DScrollPanel", data.parent )
	local scrollline = scrollpanel:GetVBar()
	if data.dockmargin then scrollpanel:DockMargin(data.dockmargin[1], data.dockmargin[2], 20, data.dockmargin[4]) end
	if data.dock then scrollpanel:Dock(data.dock) end
	if data.dockpadding then scrollpanel:DockPadding(data.dockpadding[1], data.dockpadding[2], data.dockpadding[3], data.dockpadding[4]) end
	if data.size then scrollpanel:SetSize(data.size.x, data.size.y) end
	if data.pos then scrollpanel:SetPos(data.pos.x, data.pos.y) end

	local offset, canvassize = 0

	local oldonvscroll = scrollpanel.OnVScroll

	function scrollpanel:OnVScroll( scroll )
		_, canvassize = self:GetCanvas():GetSize()
		offset = -scroll / canvassize
		oldonvscroll(self, scroll)
	end

	function scrollline:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, data.line_bkg_color or TeraLib.vgui.ScrollPanelColor)
		if data.showpos then
			draw.RoundedBox(0, 0, 0, w, h * offset + 20, data.fraction_color or TeraLib.vgui.Fraction)
		end
	end

	scrollline.btnUp:SetImage("icon16/bullet_arrow_up.png")
	scrollline.btnDown:SetImage("icon16/bullet_arrow_down.png")

	function scrollline.btnUp:Paint(w, h)
		if self:IsHovered() then
			draw.RoundedBox(0, 0, 0, w, h, data.button_color or TeraLib.vgui.Hover)
		else
			draw.RoundedBox(0, 0, 0, w, h, data.button_color or TeraLib.vgui.ButtonColor)
		end
	end

	function scrollline.btnDown:Paint(w, h)
		if self:IsHovered() then
			draw.RoundedBox(0, 0, 0, w, h, data.button_color or TeraLib.vgui.Hover)
		else
			draw.RoundedBox(0, 0, 0, w, h, data.button_color or TeraLib.vgui.ButtonColor)
		end
	end

	function scrollline.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, data.button_color or TeraLib.vgui.ScrollHead)
	end

	return scrollpanel
end

function TeraLib.vgui.PropertySheetVertical( data )
	
	data.list_pos = data.list_pos or LEFT
	if !data.size then
		data.size = {}
		data.size.x, data.size.y = data.parent:GetSize()
	end

	local newparent = vgui.Create('DPanel', data.parent)
	newparent:Dock(FILL)
	newparent:SetBackgroundColor(data.color or TeraLib.vgui.Base)

	local list_size = {x = data.list or (data.size.x * data.percent or 0.2), y = data.size.y}
	local canvas_size = {x = data.size.x - list_size.x or (data.size.x * (1 - data.percent or 0.8)), y = data.size.y}

	local list_panel = vgui.Create('DPanel', newparent)
	list_panel:SetBackgroundColor(data.list_color or TeraLib.vgui.SecondBase)
	list_panel:Dock(data.list_pos)
	list_panel:DockMargin(3, 3, 2, 3)
	list_panel:SetSize(list_size.x, list_size.y)

	newparent.list = TeraLib.vgui.ScrollPanel { parent = list_panel }
	newparent.list:Dock(FILL)

	newparent.canvas = vgui.Create('DPanel', newparent)

	newparent.canvas:SetBackgroundColor(data.canvas_color or TeraLib.vgui.SecondBase)
	newparent.canvas:Dock(FILL)
	newparent.canvas:DockMargin(1, 3, 3, 3)

	newparent.canvas.title = TeraLib.vgui.Label { parent = newparent.canvas, dock = TOP, alignment = 4, dockmargin = {8, 3, 3, 5}, text = TeraLib.lang.GetPhrase( 'TeraLib.ClickToOpen' )}

	function newparent:SetTitle(text)
		self.canvas.title:SetText(text or '')
	end

	function newparent.canvas:OnActiveTabChanged(title, tab)
		if self.activetab then self.activetab:Hide() end
		newparent:SetTitle(title or '')
		self.activetab = tab
		self.activetab:Dock(FILL)
		tab:Show()
	end

	local doclick = function(self)
		for i = 1, #newparent.list.buttons do
			newparent.list.buttons[i].select = false
		end
		self.select = true
		newparent.canvas:OnActiveTabChanged(self:GetText(), self.tab)
	end

	function newparent:SetSheets(buttons)
		self.list.buttons = {}

		self.list:Clear()
		self:SetTitle(TeraLib.lang.GetPhrase( 'TeraLib.ClickToOpen' ))

		for i = 1, #buttons do
			local button_data = buttons[i]
			local button = TeraLib.vgui.ColorableButton { size = {x = list_size.x, y = data.button_size or 20}, dockmargin = {0, 0, 0, 3}, text = button_data.text or '', icon = button_data.icon, dock = TOP, DoClick = button_data.doclick or doclick }
			button.num = i
			button.tab = button_data.tab
			button.tab:Hide()
			self.list.buttons[i] = button
			self.list:AddItem(button)
		end

		if buttons.default_tab then
			newparent.canvas:OnActiveTabChanged(buttons[buttons.default_tab].text, buttons[buttons.default_tab].tab)
			self.list.buttons[buttons.default_tab].select = true
		end
	end

	function newparent:AddSheets(buttons)

		for i = 1, #buttons do
			local button_data = buttons[i]
			local button = TeraLib.vgui.ColorableButton { size = {x = list_size.x, y = data.button_size or 20}, dockmargin = {0, 0, 0, 3}, text = button_data.text or '', icon = button_data.icon, dock = TOP, DoClick = doclick, fraction_type = 1, fraction_color = data.select_color or TeraLib.vgui.Selection }
			button.num = #self.list.buttons + i
			button.tab = button_data.tab
			button.tab:Hide()
			self.list.buttons[#self.list.buttons + i] = button
			self.list:AddItem(button)
		end

	end

	return newparent

end

function TeraLib.vgui.RemoveNotification( index )
	TeraLib.vgui.Notifications[data.title] = nil
end

function TeraLib.vgui.Notify( data )
	surface.PlaySound('TeraLib/notify.mp3')

	data.title = data.title or TeraLib.lang.GetPhrase('<title>')

	local panel = vgui.Create('DPanel', TeraLib.vgui.NotifyPanel)

	panel:SetSize(TeraLib.vgui.NotifyPanel.basicsize.x, TeraLib.vgui.NotifyPanel.basicsize.y)
	panel:SetBackgroundColor(data.color or TeraLib.vgui.Base)
	panel:Dock(TOP)
	panel.offset = 0
	panel.stop_retract = true

	function panel:Think()
		local speed = FrameTime() * 150
		--local speed = TeraLib.vgui.NotifyPanel.basicsize.y / fps
		if self.offset >= TeraLib.vgui.NotifyPanel.basicsize.y then self.offset = TeraLib.vgui.NotifyPanel.basicsize.y self.stop_extend = true end
		if !self.stop_extend then
			self.offset = self.offset + speed
			TeraLib.vgui.NotifyPanel.offset = TeraLib.vgui.NotifyPanel.offset - speed
		end
		if self.offset <= 0 then self.stop_retract = true end
		if !self.stop_retract then
			self.offset = self.offset - speed
			TeraLib.vgui.NotifyPanel.offset = TeraLib.vgui.NotifyPanel.offset + speed
		end
		self:SetSize(TeraLib.vgui.NotifyPanel.basicsize.x, self.offset)
		if self.offset <= 0 then
			self:Remove()
		end
	end

	data.delay = data.delay or 5

	if data.notimer then
		if TeraLib.vgui.Notifications[data.title] then
			TeraLib.vgui.Notifications[data.title].stop_retract = false
		end
		TeraLib.vgui.ColorableButton { parent = panel, fraction_type = 5, dock = BOTTOM }
		TeraLib.vgui.Notifications[data.title] = panel
	else
		local button = TeraLib.vgui.ColorableButton { parent = panel, fraction_type = 1, dock = BOTTOM, think = function(self)
			self.fraction = 1 - (panel.timer - CurTime()) / data.delay
		end }
		panel.timer = CurTime() + data.delay
		timer.Simple(data.delay, function() if !IsValid(panel) then return end panel.stop_retract = false end)
	end

	if data.icon or data.avatar then
		local panel = vgui.Create('DPanel', panel)
		panel:Dock(LEFT)
		panel:SetSize(TeraLib.vgui.NotifyPanel.basicsize.y - 20, TeraLib.vgui.NotifyPanel.basicsize.y - 20)
		--print(TeraLib.vgui.NotifyPanel.basicsize.y - 20)
		panel:SetBackgroundColor(Color(0, 0, 0, 0))
		panel:DockMargin(8, 8, 8, 8)

		local image
		if data.icon then
			image = vgui.Create('DImage', panel)
			image:SetImage(data.image)
		else
			image = vgui.Create('AvatarImage', panel)
			if isnumber(data.avatar) then image:SetSteamID(data.avatar)
			else image:SetPlayer(data.avatar, 128)
			end
		end
		image:Dock(FILL)
	end

	TeraLib.vgui.Label { parent = panel, text = data.text, dock = FILL, dockmargin = {8, 8, 8, 8}, alignment = 7 }
	--text:SetText(data.text)
	--text:Dock(FILL)
	--text:DockMargin(8, 8, 8, 8)
	--text:SetContentAlignment(7)

end

local function ShowSettings()
	TeraLib.vgui.window:Show()
end

local function CreateNotifyPanel()
	local notifypanel = vgui.Create('DPanel')
	TeraLib.vgui.NotifyPanel = notifypanel
	TeraLib.vgui.windows[#TeraLib.vgui.windows + 1] = notifypanel

	notifypanel.basicpos = {x = scrw * .75, y = scrh}
	notifypanel.basicsize = {x = scrw * .22, y = 100}
	notifypanel.offset = 0

	notifypanel:SetPos(notifypanel.basicpos.x, notifypanel.basicpos.y)
	notifypanel:SetSize(notifypanel.basicsize.x, notifypanel.basicsize.y)
	local color = table.Copy(TeraLib.vgui.Base)
	color.a = 105
	notifypanel:SetBackgroundColor(color)

	function notifypanel:Think()
		self:SetSize(self.basicsize.x, self.basicsize.y - self.offset)
		self:SetPos(self.basicpos.x, self.basicpos.y + self.offset)
	end
end

list.Set("DesktopWindows", 'teralib', {
	title		= 'TeraLib',
	icon		= 'materials/teralib/logo.png',
	width		= 1,
	height		= 1,
	onewindow	= false,
	init		= ShowSettings
})

local function TeraLibLoadGUI()
	scrw, scrh = ScrW(), ScrH()
	reload_colors()
	for i = 1, #TeraLib.vgui.windows do
		local wind = TeraLib.vgui.windows[i]
		if ispanel(wind) then wind:Remove() end
	end
	TeraLib.vgui.windows = {}
	TeraLib.vgui.Settings()

	CreateNotifyPanel()
end

concommand.Add('teralib_reload_gui', TeraLibLoadGUI)

hook.Add('OnScreenSizeChanged', 'TeraLibLoadGUI', TeraLibLoadGUI)
hook.Add('InitPostEntity', 'TeraLibLoadGUI', TeraLibLoadGUI)
hook.Add('TeraLibReloadGUI', 'TeraLibLoadGUI', TeraLibLoadGUI)

hook.Add('ShutDown', 'TeraLibSaveData', save_colors)