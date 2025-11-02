require "lib.moonloader"
local imgui = require "imgui"
local inicfg = require('inicfg')
local encoding = require "encoding"
UTF8 = encoding.UTF8
encoding.default = 'CP1251'
local on = imgui.ImBool(false)
local sw, sh = getScreenResolution()
local dialogid = sampGetCurrentDialogId()
local mainIni = inicfg.load(
	{
		config =
		{
			Автоеда = false,
			Способ = 0,
			Процент = tonumber(1)
		}
	},
'AutoEat.ini')
local autoeat = imgui.ImBool(mainIni.config.Автоеда)
local eatmethod = imgui.ImInt(mainIni.config.Способ)
local eatpercent = imgui.ImInt(mainIni.config.Процент)
local method = 
	{
		UTF8'Чипсы',
		UTF8'Рыба',
		UTF8'Оленина',
		UTF8'Мешок с мясом',
		UTF8'Еда с холодильника',
		UTF8'Еда с семейной квартиры'
	}
	
if not doesFileExist('moonloader/config/AutoEat.ini') then
	inicfg.save(mainIni, 'AutoEat.ini')
end

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then
		return
	end
	while not isSampAvailable() do
		wait(100)
	end
	sampAddChatMessage('{00FF00}[AutoEat] {FFFFFF}Script loaded - {FF0000}/autoeat',-1)
	sampRegisterChatCommand('autoeat', aeaton)
	while true do
		wait(0)
		if on.v == false then
			imgui.Process = false
		end
		apply_custom_style()
		if sampTextdrawIsExists(2061) then
			_, _, eat, _ = sampTextdrawGetBoxEnabledColorAndSize(2061)
			eat = (eat - imgui.ImVec2(sampTextdrawGetPos(2061)).x) * 1.83
			if math.floor(eat) < eatpercent.v then
				if autoeat.v then
					if eatmethod.v == 0 then
						wait(500)
						sampSendChat('/cheeps')
						wait(3500)
					end
					if eatmethod.v == 1 then
						wait(500)
						sampSendChat('/jfish')
						wait(3500)
					end
					if eatmethod.v == 2 then
						wait(500)
						sampSendChat('/jmeat')
						wait(3500)
					end
					if eatmethod.v == 3 then
						wait(500)
						sampSendChat('/meatbag')
						wait(3500)
					end
					if eatmethod.v == 4 then
						wait(1000)
						sampSendChat('/home')
						wait(900)
						sampSendDialogResponse(7238, 1, 0, false) -- 0 - Дом по списку (при необходимости, меняйте на соответствующий пункт)
						wait(900)
						sampSendDialogResponse(174, 1, 1, false)
						wait(900)
						sampSendDialogResponse(2431, 1, 2, false)
						wait(900)
						sampSendDialogResponse(185, 1, 6, false) -- 6 - Комплексный обед в холодильнике (при необходимости, меняйте на соответствующий пункт)
						sampCloseCurrentDialogWithButton(0)
						-- Нумерация с 0 начинается, если будете менять в тех двух пунктах.
					end
					if eatmethod.v == 5 then
						setVirtualKeyDown(18, true)
						wait(1000)
						setVirtualKeyDown(18, false)
						wait(900)
						sampSendDialogResponse(1825, 1, 6, false)
					end
				end
			end
		end
	end
end

function imgui.OnDrawFrame()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(400, 150), imgui.Cond.FirstUseEver)
	imgui.Begin('AutoEat', on, imgui.WindowFlags.NoResize)
	imgui.Checkbox(UTF8'Автоеда', autoeat)
	if autoeat.v then
		imgui.Combo(UTF8'Выбор способа еды', eatmethod, method, -1)
		imgui.Text(UTF8'Процент сытости, при котором кушать:')
		imgui.SliderInt(UTF8'', eatpercent, 1, 99)
	end
	imgui.SetCursorPos(imgui.ImVec2(255,123))
	if imgui.Button(UTF8'Сохранить настройки') then
		mainIni.config.Автоеда = autoeat.v
		mainIni.config.Способ = eatmethod.v
		mainIni.config.Процент = eatpercent.v
		inicfg.save(mainIni, 'AutoEat.ini')
		sampAddChatMessage('{00FF00}[AutoEat] {FFFFFF}Настройки сохранены', -1)
	end
	imgui.End()
end

function aeaton()
	on.v = not on.v
	imgui.Process = on.v
end

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2
    style.WindowPadding = ImVec2(6, 4)
    style.WindowRounding = 5.0
    style.ChildWindowRounding = 5.0
    style.FramePadding = ImVec2(5, 2)
    style.FrameRounding = 5.0
    style.ItemSpacing = ImVec2(7, 5)
    style.ItemInnerSpacing = ImVec2(1, 1)
    style.TouchExtraPadding = ImVec2(0, 0)
    style.IndentSpacing = 6.0
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 5.0
    style.GrabMinSize = 20.0
    style.GrabRounding = 2.0
    style.WindowTitleAlign = ImVec2(0.5, 0.5)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.28, 0.30, 0.35, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.16, 0.18, 0.22, 1.00)
    colors[clr.ChildWindowBg]          = ImVec4(0.19, 0.22, 0.26, 1)
    colors[clr.PopupBg]                = ImVec4(0.05, 0.05, 0.10, 0.90)
    colors[clr.Border]                 = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]                = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.FrameBgHovered]         = ImVec4(0.22, 0.25, 0.30, 1.00)
    colors[clr.FrameBgActive]          = ImVec4(0.22, 0.25, 0.29, 1.00)
    colors[clr.TitleBg]                = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.19, 0.22, 0.26, 0.59)
    colors[clr.MenuBarBg]              = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.20, 0.25, 0.30, 0.60)
    colors[clr.ScrollbarGrab]          = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.49, 0.63, 0.86, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.49, 0.63, 0.86, 1.00)
    colors[clr.ComboBg]                = ImVec4(0.20, 0.20, 0.20, 0.99)
    colors[clr.CheckMark]              = ImVec4(0.90, 0.90, 0.90, 0.50)
    colors[clr.SliderGrab]             = ImVec4(1.00, 1.00, 1.00, 0.30)
    colors[clr.SliderGrabActive]       = ImVec4(0.80, 0.50, 0.50, 1.00)
    colors[clr.Button]                 = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.ButtonHovered]          = ImVec4(0.49, 0.62, 0.85, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.49, 0.62, 0.85, 1.00)
    colors[clr.Header]                 = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.HeaderHovered]          = ImVec4(0.22, 0.24, 0.28, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.22, 0.24, 0.28, 1.00)
    colors[clr.Separator]              = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.SeparatorHovered]       = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.SeparatorActive]        = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.ResizeGripHovered]      = ImVec4(0.49, 0.61, 0.83, 1.00)
    colors[clr.ResizeGripActive]       = ImVec4(0.49, 0.62, 0.83, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.CloseButtonHovered]     = ImVec4(0.50, 0.63, 0.84, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.16, 0.18, 0.22, 0.76)
end