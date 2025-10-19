script_properties('work-in-pause')
script_name('AutoReconnect')
script_author('infernos')
script_version('1.1')

local inicfg = require 'inicfg'
local imgui = require 'imgui'
local encoding = require 'encoding'
local events = require 'samp.events'

encoding.default = 'CP1251'
u8 = encoding.UTF8

function utf8(text)
    return u8:decode(text)
end

function table.copy(original)
    if type(original) ~= 'table' then
        return original
    end

    local copy = {}
    for key, value in pairs(original) do
        copy[key] = table.copy(value)
    end
    
    return copy
end

local DEFAULT_CONFIG = {
    main = {
        enabled = true,
        silent = false
    },
    closed = {
        enabled = true,
        hours = 0,
        minutes = 0,
        seconds = 0
    },
    lost = {
        enabled = true,
        hours = 0,
        minutes = 0,
        seconds = 0
    },
    password = {
        enabled = true,
        hours = 0,
        minutes = 0,
        seconds = 0
    },
    rejected = {
        enabled = true,
        hours = 0,
        minutes = 0,
        seconds = 0
    },
    banned = {
        enabled = true,
        hours = 0,
        minutes = 0,
        seconds = 0
    }
}

local config = inicfg.load(table.copy(DEFAULT_CONFIG))

local configImguiFields = {
    main = {
        enabled = imgui.ImBool,
        silent = imgui.ImBool
    },
    closed = {
        enabled = imgui.ImBool,
        hours = imgui.ImInt,
        minutes = imgui.ImInt,
        seconds = imgui.ImInt
    },
    lost = {
        enabled = imgui.ImBool,
        hours = imgui.ImInt,
        minutes = imgui.ImInt,
        seconds = imgui.ImInt
    },
    password = {
        enabled = imgui.ImBool,
        hours = imgui.ImInt,
        minutes = imgui.ImInt,
        seconds = imgui.ImInt
    },
    rejected = {
        enabled = imgui.ImBool,
        hours = imgui.ImInt,
        minutes = imgui.ImInt,
        seconds = imgui.ImInt
    },
    banned = {
        enabled = imgui.ImBool,
        hours = imgui.ImInt,
        minutes = imgui.ImInt,
        seconds = imgui.ImInt
    }
}

function assignImguiFields(target, fields)
    for k, v in pairs(fields) do
        local targetValue = target[k]
        if type(targetValue) == 'table' and type(v) == 'table' then
            assignImguiFields(targetValue, v)
        else
            target[k] = v(targetValue)
        end
    end

    return target
end

function unassignImguiFields(target, fields)
    for k, v in pairs(fields) do
        local targetValue = target[k]
        if type(targetValue) == 'table' and type(v) == 'table' then
            unassignImguiFields(targetValue, v)
        else
            target[k] = target[k].v
        end
    end

    return target
end

assignImguiFields(config, configImguiFields)

function saveConfig()
    local copy = table.copy(config)
    unassignImguiFields(copy, configImguiFields)
    local ok, err = pcall(inicfg.save, copy)
    if ok then
        msg('Настройки сохранены!')
    else
        msg('Ошибка сохранения настроек: ' .. tostring(err))
    end
end

function resetConfigTable(target, default, fields)
    for k, _ in pairs(target) do
        local found = false
        local defaultValue = default[k]
        
        for j, _ in pairs(fields) do
            if k == j then
                found = true
                break
            end
        end

        if found then
            local targetValue = target[k]
            local fieldsValue = fields[k]
            if type(targetValue) == 'table' and type(fieldsValue) == 'table' then
                resetConfigTable(targetValue, defaultValue, fieldsValue)
            else
                target[k].v = defaultValue
            end
        else
            target[k] = defaultValue
        end
    end

    return target
end

function resetConfig()
    resetConfigTable(config, DEFAULT_CONFIG, configImguiFields)
    saveConfig()
end

function msg(text)
    if isSampAvailable() then
        if not config.main.silent.v then
            sampAddChatMessage(utf8('{ebd300}[' .. script.this.name .. '] {ffffff}' .. text), -1)
        end
    else
        print(utf8(text):gsub('{.-}', ''))
    end
end

local mainWindowState = imgui.ImBool(false)
local font = nil
local task = nil

local EVENTS = {
    {
        key = 'closed',
        title = 'Server closed the connection',
        listener = 'onConnectionClosed'
    },
    {
        key = 'lost',
        title = 'Lost connection to the server',
        listener = 'onConnectionLost'
    },
    {
        key = 'password',
        title = 'Wrong server password',
        listener = 'onConnectionPasswordInvalid'
    },
    {
        key = 'rejected',
        title = 'Unacceptable NickName', -- CONNECTION REJECTED: Unacceptable NickName
        listener = 'onConnectionRejected'
    },
    {
        key = 'banned',
        title = 'You are banned from this server',
        tooltip = { '[!]', 'Известно о странной работе этого события на Arizona RP с лаунчера,\nгде в НЕКОТОРЫХ случаях используется встроенное автоподключение.\nСледовательно, могут возникать конфликты с ' .. script.this.name .. '.\n\nРекомендуется ставить задержку на перезаход выше 0.' },
        listener = 'onConnectionBanned'
    }
}

local TIME_UNITS = {
    {
        key = 'hours',
        name = 'Часы',
        text = ' час.',
        max = 23
    },
    {
        key = 'minutes',
        name = 'Минуты',
        text = ' мин.',
        max = 59
    },
    {
        key = 'seconds',
        name = 'Секунды',
        text = ' сек.',
        max = 59
    }
}

function stringifyTime(item)
    local array = {}
    for _, v in ipairs(TIME_UNITS) do
        if item[v.key].v > 0 then
            table.insert(array, tostring(item[v.key].v) .. v.text)
        end
    end
    return table.concat(array, ' ')
end

for _, v in ipairs(EVENTS) do
    events[v.listener] = function()
        local item = config[v.key];
        if not config.main.enabled.v or not item.enabled.v then return end
        terminateTask()
        local h, m, s = item.hours.v, item.minutes.v, item.seconds.v
        local cooldown = ((h * 3600) + (m * 60) + s) * 1000
        local message = v.title
        if cooldown > 0 then message = message .. ' | Ожидаем ' .. stringifyTime(item) end
        msg(message)
        task = lua_thread.create(function()
            wait(cooldown)
            sampSetGamestate(1)
            msg('Время перезаходить')
            task = nil
        end)
    end
end

function terminateTask()
    if task ~= nil then
        task:terminate()
        task = nil
        msg('Задача завершена')
    end
end

function events.onConnectionRequestAccepted()
    terminateTask()
end

function main()
    while not isSampAvailable() do wait(0) end

    loadFont()
    
    sampRegisterChatCommand('arcn', function()
        mainWindowState.v = not mainWindowState.v
    end)
    
    msg('Скрипт загружен! Используйте {e3d97d}/arcn')
    
    while true do
        wait(0)
        imgui.Process = mainWindowState.v
    end
end

function loadFont()
    local fontPath = 'C:\\Windows\\Fonts\\tahoma.ttf'
    local fontSize = 16.0
    local io = imgui.GetIO()
    if doesFileExist(fontPath) then
        font = io.Fonts:AddFontFromFileTTF(fontPath, fontSize, nil, io.Fonts:GetGlyphRangesCyrillic())
        if font ~= nil then
            return
        end
    end
    font = io.Fonts:AddFontDefault(nil, io.Fonts:GetGlyphRangesCyrillic())
    msg('Шрифт Tahoma не найден, используется шрифт по умолчанию')
end

function imgui.OnDrawFrame()
    if not mainWindowState.v then return end

    local function tooltip(text, tooltip)
        imgui.Text(text)
        if imgui.IsItemHovered() then
            imgui.SetTooltip(tooltip)
        end
    end
    
    imgui.SetNextWindowSize(imgui.ImVec2(632.5, 315), imgui.Cond.FirstUseEver)
    imgui.Begin(script.this.name .. ' v' .. script.this.version .. ' | ' .. table.concat(script.this.authors, ', '), mainWindowState, imgui.WindowFlags.NoResize)
    
    imgui.BeginChild('##settings', imgui.ImVec2(0, 235), true)
    
    imgui.Checkbox('##enabled', config.main.enabled)
    imgui.SameLine()
    imgui.Text('Включен')
    imgui.SameLine()
    tooltip('[?]', 'Если включено, то скрипт будет автоматически\nперезаходить при отсоединении от сервера.')

    imgui.Checkbox('##silent', config.main.silent)
    imgui.SameLine()
    imgui.Text('Скрывать сообщения')
    imgui.SameLine()
    tooltip('[?]', 'Если включено, то все сообщения скрипта будут скрыты.')

    if config.main.enabled.v then 
        imgui.Spacing()
        imgui.Separator()
        imgui.Spacing()
        imgui.Columns(4, nil, false)

        imgui.AlignTextToFramePadding()
        imgui.Text('Перезаходить, если:')

        for _, event in ipairs(EVENTS) do
            imgui.AlignTextToFramePadding()
            imgui.Checkbox('##' .. event.key, config[event.key].enabled)
            imgui.SameLine()
            imgui.Text(event.title)
            if event.tooltip ~= nil then
                imgui.SameLine()
                tooltip(unpack(event.tooltip))
            end
        end

        for i, unit in ipairs(TIME_UNITS) do
            imgui.NextColumn()
            imgui.SetColumnOffset(i, imgui.GetWindowWidth() - 5 - (90) * (#TIME_UNITS - i + 1))
            imgui.AlignTextToFramePadding()
            imgui.Text(unit.name)
            for _, event in ipairs(EVENTS) do
                if config[event.key].enabled.v then
                    imgui.PushItemWidth(80)
                    imgui.InputInt('##' .. event.key .. '_' .. unit.key, config[event.key][unit.key])
                    imgui.PopItemWidth()

                    if config[event.key][unit.key].v < 0 then
                        config[event.key][unit.key].v = 0
                    end
                    
                    if config[event.key][unit.key].v > unit.max then
                        config[event.key][unit.key].v = unit.max
                    end
                else
                    imgui.AlignTextToFramePadding()
                    imgui.Spacing()
                end
            end 
        end
    end
    
    imgui.EndChild()
    
    imgui.Spacing()
    
    if imgui.Button('Сохранить настройки', imgui.ImVec2(200, 30)) then
        saveConfig()
    end
    
    imgui.SameLine()
    
    if imgui.Button('Сбросить настройки', imgui.ImVec2(200, 30)) then
        resetConfig()
    end
    
    imgui.SameLine()

    -- Флаг обязателен во избежание проблем
    local pushed = false

    if task == nil then
        imgui.PushStyleVar(imgui.StyleVar.Alpha, imgui.GetStyle().Alpha * 0.7)
        pushed = true
    end
    
    if imgui.Button('Завершить задачу', imgui.ImVec2(200, 30)) and task ~= nil then
        terminateTask()
    end
    
    if pushed then
        imgui.PopStyleVar()
    end
    
    imgui.End()
end

function onScriptTerminate(script, quitGame)
    if script == thisScript() then
        saveConfig()
    end
end
