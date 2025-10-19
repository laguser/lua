-- 📞 Auto CallID (no ImGui)
-- Author: Infernos
-- MoonLoader 0.26.5 compatible

script_name("Auto CallID")
script_author("Infernos")
script_version("1.1")

require "lib.moonloader"
local sampev = require "lib.samp.events"
local vkeys = require "vkeys"
local ffi = require "ffi"
local encoding = require "encoding"
encoding.default = "CP1251"
u8 = encoding.UTF8

-- 🔊 WinAPI beep
ffi.cdef [[ bool Beep(unsigned int freq, unsigned int dur); ]]
local function beep(freq, dur)
    pcall(function() ffi.C.Beep(freq or 600, dur or 120) end)
end

-- simple on-screen text
local font = renderCreateFont("Arial", 12, 8)
local textToDraw, textTimer = "", 0

local function showText(msg, time)
    textToDraw = msg
    textTimer = os.clock() + (time or 2.5)
end

function onRender()
    if textToDraw ~= "" and os.clock() < textTimer then
        local sw, sh = getScreenResolution()
        renderFontDrawText(font, textToDraw, sw/2 - 80, sh - 180, 0xFFFFFFFF)
    end
end

-- state
local TAG = "{33CCFF}[AutoCall]{FFFFFF}"
local PHONEBOOK_DIALOG_TITLE = "Телефонная книга"
local waiting_for_number, phone_number, need_to_call = false, nil, false
local need_close_dialog, need_esc_after_number, in_call = false, false, false

-- helpers
local function pressKey(key, delay)
    setVirtualKeyDown(key, true) wait(40)
    setVirtualKeyDown(key, false) wait(delay or 80)
end
local function pressEsc() pressKey(vkeys.VK_ESCAPE, 100) end
local function notify(text, col)
    sampAddChatMessage(TAG .. " " .. text, col or -1)
    showText(u8(text))
end

-- main
function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end

    sampRegisterChatCommand("callid", cmd_callid)
    notify("Loaded! Use /callid [id]")
    addEventHandler("onWindowMessage", function(msg,wparam,lparam)
        if msg == 0xF then onRender() end
    end)

    while true do
        wait(0)
        if need_close_dialog then wait(200) pressKey(vkeys.VK_RETURN) need_close_dialog = false end
        if need_esc_after_number then wait(200) pressEsc() need_esc_after_number = false end

        if need_to_call and phone_number then
            wait(400)
            sampSendChat("/call " .. phone_number)
            notify("📞 Calling: " .. phone_number, 0x00FF00)
            beep(900,120)
            in_call, need_to_call, phone_number = true, false, nil
            wait(500) pressEsc()
        end

        -- cancel on N
        if in_call and isKeyDown(vkeys.VK_N) then
            sampSendChat("/h")
            notify("❌ Call cancelled.", 0xFF3333)
            beep(400,180)
            in_call = false
            wait(400)
        end
    end
end

-- command
function cmd_callid(param)
    local id = tonumber(param)
    if not id then notify("Usage: /callid [player_id]") return end
    waiting_for_number, phone_number, need_to_call, need_close_dialog, need_esc_after_number, in_call =
        true, nil, false, false, true, false
    notify("🔍 Searching number for ID: " .. id, 0x00FFFF)
    beep(700,100)
    sampSendChat("/number " .. id)
end

-- events
function sampev.onShowDialog(id, style, title)
    if waiting_for_number and title == PHONEBOOK_DIALOG_TITLE then
        need_close_dialog = true
        return false
    end
    return true
end

function sampev.onServerMessage(color, text)
    if not text then return true end
    if waiting_for_number then
        local num = text:match("%{33CCFF%}(%d+)")
        if num and #num >= 3 and #num <= 8 then
            phone_number, waiting_for_number, need_to_call = num, false, true
            notify("✅ Found number: " .. num, 0x00FF00)
            beep(1000,100)
            return false
        end
    end
    return true
end
