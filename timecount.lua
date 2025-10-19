script_name("PlayTime Tracker")
script_author("Infernos")
script_version("1.3")

local playtime = { total_seconds = 0, session_seconds = 0 }
local file_path = getGameDirectory() .. "\\moonloader\\playtime.json"
local font = nil

function loadData()
    local f = io.open(file_path, "r")
    if f then
        local data = f:read("*a")
        f:close()
        local t = load("return " .. data)()
        if t and t.total_seconds then playtime.total_seconds = t.total_seconds end
    end
end

function saveData()
    local f = io.open(file_path, "w")
    if f then
        f:write(string.format("{ total_seconds = %d }", playtime.total_seconds))
        f:close()
    end
end

function formatTime(sec)
    local h = math.floor(sec / 3600)
    local m = math.floor((sec % 3600) / 60)
    local s = sec % 60
    return string.format("%02d:%02d:%02d", h, m, s)
end

function main()
    repeat wait(0) until isSampAvailable()
    loadData()
    sampAddChatMessage("[PlayTime] Timer started!", 0x00FF00)
    font = renderCreateFont("Arial", 10, 5) -- create a font

    local lastTick = os.clock()

    while true do
        wait(0)

        local text = string.format("Session: %s | Total: %s",
            formatTime(playtime.session_seconds), formatTime(playtime.total_seconds))
        renderFontDrawText(font, text, 20, 430, 0xFFFFFFFF)

        if os.clock() - lastTick >= 1 then
            playtime.session_seconds = playtime.session_seconds + 1
            playtime.total_seconds = playtime.total_seconds + 1
            saveData()
            lastTick = os.clock()
        end
    end
end

function onScriptTerminate(s, quitGame)
    if s == thisScript() then
        saveData()
        sampAddChatMessage("[PlayTime] Time saved.", 0x00FF00)
        if font then renderReleaseFont(font) end
    end
end
