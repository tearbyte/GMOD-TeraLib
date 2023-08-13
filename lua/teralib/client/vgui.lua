TeraLib.vgui = {}

function TeraLib.vgui.Base( element, data )
	if data.text then element:SetText(data.text) end
	if data.label then element:SetLabel(data.label) end
 	if data.font then element:SetFont(data.font) end
 	if data.background then element:SetBackgroundColor(data.background) element:SetDrawBackground(true) end
 	if data.color then element:SetColor(data.color) end
	if data.dock then for _, v in ipairs(data.dock) do element:Dock(v) end end
	if data.size then element:SetSize(data.size[1], data.size[2]) else element:SetSize(50, 20) end
	if data.pos then element:SetPos(pos[1], pos[2]) end
	if data.center then element:Center() end
	if data.dockmargin then element:DockMargin(data.dockmargin[1], data.dockmargin[2], data.dockmargin[3], data.dockmargin[4]) end
end

function TeraLib.vgui.PoweredBy( data )
	local panel = TeraLib.vgui.Panel( data )
	TeraLib.vgui.Image {parent = panel, dock = {LEFT}, dockmargin = {3, 3, 3, 3}, image = "teralib/logo", size = {64, 64}}
	TeraLib.vgui.Label {parent = panel, dock = {TOP}, dockmargin = {0, 3, 3, 3}, text = data.poweredby}
	TeraLib.vgui.Button {parent = panel, dock = {BOTTOM}, dockmargin = {0, 3, 3, 3}, text = data.download, doclick = function() gui.OpenURL('https://steamcommunity.com/sharedfiles/filedetails/?id=3013984464') end}
end

function TeraLib.vgui.Frame( data )
	local frame = vgui.Create('DFrame', data.parent)
	TeraLib.vgui.Base( frame, data )
	if data.popup then panel:MakePopup() end
	return frame
end	

function TeraLib.vgui.Panel( data )
	local panel = vgui.Create('DPanel', data.parent)
	TeraLib.vgui.Base( panel, data )
	return panel
end

function TeraLib.vgui.Label( data )
	local label = vgui.Create('DLabel', data.parent)
	TeraLib.vgui.Base( label, data )
	return label
end

function TeraLib.vgui.Button( data )
	local button = vgui.Create('DButton', data.parent)
	TeraLib.vgui.Base( button, data )
	if data.doclick then button.DoClick = data.doclick end
	return button
end

function TeraLib.vgui.CButton( data )
	local button = vgui.Create('DButton', data.parent)
	TeraLib.vgui.Base( button, data )
	if data.doclick then button.DoClick = data.doclick end
	return button
end

function TeraLib.vgui.CheckLabel( data )
	local check = vgui.Create('DCheckBoxLabel', data.parent)
	TeraLib.vgui.Base( check, data )
	if data.onchange then check.OnChange = data.onchange end
	return check
end

function TeraLib.vgui.List( data )
	local list = vgui.Create('DListView', data.parent)
	TeraLib.vgui.Base( list, data )
	for _, v in ipairs(data.columns) do list:AddColumn(v) end
	if data.onrowselected then list.OnRowSelected = data.onrowselected end
	if data.doclick then list.DoDoubleClick = data.doclick end
	if data.onrightclick then list.OnRowRightClick = data.onrightclick end
	return list
end

function TeraLib.vgui.Image( data )
	local image = vgui.Create('DImage', data.parent)
	TeraLib.vgui.Base( image, data )
	if data.image then image:SetImage(data.image) end
	if data.material then image:SetMaterial(data.material) end
	return image
end