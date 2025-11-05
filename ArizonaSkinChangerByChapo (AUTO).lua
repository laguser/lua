local imgui = require('imgui')
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
--imgui.ToggleButton = require('imgui_addons').ToggleButton  
local window = imgui.ImBool(false)
        
local json = getWorkingDirectory()..'\\config\\ARZ_LauncherSkinChangerByChapo_spisok_loshpedov.json'
local list = {}

function jsonSave(jsonFilePath, t)
    file = io.open(jsonFilePath, "w")
    file:write(encodeJson(t))
    file:flush()
    file:close()
end
    
function jsonRead(jsonFilePath)
    local file = io.open(jsonFilePath, "r+")
    local jsonInString = file:read("*a")
    file:close()
    local jsonTable = decodeJson(jsonInString)
    return jsonTable
end

local inicfg = require 'inicfg'
local directIni = 'ARZ_LauncherSkinChangerByChapo_on_kstati_ne_loshped.ini'
local ini = inicfg.load(inicfg.load({
    main = {
        skin = 0,
        fight = 0,
        walk = 0,
    },
}, directIni))
inicfg.save(ini, directIni)

local add_player = {
    nick = imgui.ImBuffer('Nick_Name', 22),
    skin = 0,
}

local skins = {
    {id = 0, name = 'Carl "CJ" Johnson (Main Character)'},
    {id = 1, name = 'The Truth'},
    {id = 2, name = 'Maccer'},
    {id = 3, name = 'Andre'},
    {id = 4, name = 'Barry "Big Bear" Thorne [Thin]'},
    {id = 5, name = 'Barry "Big Bear" Thorne [Big]'},
    {id = 6, name = 'Emmet'},
    {id = 7, name = 'Taxi Driver/Train Driver'},
    {id = 8, name = 'Janitor'},
    {id = 9, name = 'Normal Ped'},
    {id = 10, name = 'Old Woman'},
    {id = 11, name = 'Casino croupier'},
    {id = 12, name = 'Rich Woman'},
    {id = 13, name = 'Street Girl'},
    {id = 14, name = 'Normal Ped'},
    {id = 15, name = 'Mr.Whittaker (RS Haul Owner)'},
    {id = 16, name = 'Airport Ground Worker'},
    {id = 17, name = 'Businessman'},
    {id = 18, name = 'Beach Visitor'},
    {id = 19, name = 'DJ'},
    {id = 20, name = 'Rich Guy (Madd Dogg\'s Manager)'},
    {id = 21, name = 'Normal Ped'},
    {id = 22, name = 'Normal Ped'},
    {id = 23, name = 'BMXer'},
    {id = 24, name = 'Madd Dogg Bodyguard'},
    {id = 25, name = 'Madd Dogg Bodyguard'},
    {id = 26, name = 'Backpacker'},
    {id = 27, name = 'Construction Worker'},
    {id = 28, name = 'Drug Dealer'},
    {id = 29, name = 'Drug Dealer'},
    {id = 30, name = 'Drug Dealer'},
    {id = 31, name = 'Farm-Town inhabitant'},
    {id = 32, name = 'Farm-Town inhabitant'},
    {id = 33, name = 'Farm-Town inhabitant'},
    {id = 34, name = 'Farm-Town inhabitant'},
    {id = 35, name = 'Gardener'},
    {id = 36, name = 'Golfer'},
    {id = 37, name = 'Golfer'},
    {id = 38, name = 'Normal Ped'},
    {id = 39, name = 'Normal Ped'},
    {id = 40, name = 'Normal Ped'},
    {id = 41, name = 'Normal Ped'},
    {id = 42, name = 'Jethro'},
    {id = 43, name = 'Normal Ped'},
    {id = 44, name = 'Normal Ped'},
    {id = 45, name = 'Beach Visitor'},
    {id = 46, name = 'Normal Ped'},
    {id = 47, name = 'Normal Ped'},
    {id = 48, name = 'Normal Ped'},
    {id = 49, name = 'Snakehead (Da Nang)'},
    {id = 50, name = 'Mechanic'},
    {id = 51, name = 'Mountain Biker'},
    {id = 52, name = 'Mountain Biker'},
    {id = 53, name = 'Unknown'},
    {id = 54, name = 'Normal Ped'},
    {id = 55, name = 'Normal Ped'},
    {id = 56, name = 'Normal Ped'},
    {id = 57, name = 'Oriental Ped'},
    {id = 58, name = 'Oriental Ped'},
    {id = 59, name = 'Normal Ped'},
    {id = 60, name = 'Normal Ped'},
    {id = 61, name = 'Pilot'},
    {id = 62, name = 'Colonel Fuhrberger'},
    {id = 63, name = 'Prostitute'},
    {id = 64, name = 'Prostitute'},
    {id = 65, name = 'Kendl Johnson'},
    {id = 66, name = 'Pool Player'},
    {id = 67, name = 'Pool Player'},
    {id = 68, name = 'Priest/Preacher'},
    {id = 69, name = 'Normal Ped'},
    {id = 70, name = 'Scientist'},
    {id = 71, name = 'Security Guard'},
    {id = 72, name = 'Hippy'},
    {id = 73, name = 'Hippy'},
    {id = 74, name = '-'},
    {id = 75, name = 'Prostitute'},
    {id = 76, name = 'Stewardess'},
    {id = 77, name = 'Homeless'},
    {id = 78, name = 'Homeless'},
    {id = 79, name = 'Homeless'},
    {id = 80, name = 'Boxer'},
    {id = 81, name = 'Boxer'},
    {id = 82, name = 'Black Elvis'},
    {id = 83, name = 'White Elvis'},
    {id = 84, name = 'Blue Elvis'},
    {id = 85, name = 'Prostitute'},
    {id = 86, name = 'Ryder with robbery mask'},
    {id = 87, name = 'Stripper'},
    {id = 88, name = 'Normal Ped'},
    {id = 89, name = 'Normal Ped'},
    {id = 90, name = 'Jogger'},
    {id = 91, name = 'Rich Woman'},
    {id = 92, name = 'Rollerskater'},
    {id = 93, name = 'Normal Ped'},
    {id = 94, name = 'Normal Ped'},
    {id = 95, name = 'Normal Ped, Works at or owns Dillimore Gas Station'},
    {id = 96, name = 'Jogger'},
    {id = 97, name = 'Lifeguard'},
    {id = 98, name = 'Normal Ped'},
    {id = 99, name = 'Rollerskater'},
    {id = 100, name = 'Biker'},
    {id = 101, name = 'Normal Ped'},
    {id = 102, name = 'Balla'},
    {id = 103, name = 'Balla'},
    {id = 104, name = 'Balla'},
    {id = 105, name = 'Grove Street Families'},
    {id = 106, name = 'Grove Street Families'},
    {id = 107, name = 'Grove Street Families'},
    {id = 108, name = 'Los Santos Vagos'},
    {id = 109, name = 'Los Santos Vagos'},
    {id = 110, name = 'Los Santos Vagos'},
    {id = 111, name = 'The Russian Mafia'},
    {id = 112, name = 'The Russian Mafia'},
    {id = 113, name = 'The Russian Mafia'},
    {id = 114, name = 'Varios Los Aztecas'},
    {id = 115, name = 'Varios Los Aztecas'},
    {id = 116, name = 'Varios Los Aztecas'},
    {id = 117, name = 'Triad'},
    {id = 118, name = 'Triad'},
    {id = 119, name = 'Johhny Sindacco'},
    {id = 120, name = 'Triad Boss'},
    {id = 121, name = 'Da Nang Boy'},
    {id = 122, name = 'Da Nang Boy'},
    {id = 123, name = 'Da Nang Boy'},
    {id = 124, name = 'The Mafia'},
    {id = 125, name = 'The Mafia'},
    {id = 126, name = 'The Mafia'},
    {id = 127, name = 'The Mafia'},
    {id = 128, name = 'Farm Inhabitant'},
    {id = 129, name = 'Farm Inhabitant'},
    {id = 130, name = 'Farm Inhabitant'},
    {id = 131, name = 'Farm Inhabitant'},
    {id = 132, name = 'Farm Inhabitant'},
    {id = 133, name = 'Farm Inhabitant'},
    {id = 134, name = 'Homeless'},
    {id = 135, name = 'Homeless'},
    {id = 136, name = 'Normal Ped'},
    {id = 137, name = 'Homeless'},
    {id = 138, name = 'Beach Visitor'},
    {id = 139, name = 'Beach Visitor'},
    {id = 140, name = 'Beach Visitor'},
    {id = 141, name = 'Businesswoman'},
    {id = 142, name = 'Taxi Driver'},
    {id = 143, name = 'Crack Maker'},
    {id = 144, name = 'Crack Maker'},
    {id = 145, name = 'Crack Maker'},
    {id = 146, name = 'Crack Maker'},
    {id = 147, name = 'Businessman'},
    {id = 148, name = 'Businesswoman'},
    {id = 149, name = 'Big Smoke Armored'},
    {id = 150, name = 'Businesswoman'},
    {id = 151, name = 'Normal Ped'},
    {id = 152, name = 'Prostitute'},
    {id = 153, name = 'Construction Worker'},
    {id = 154, name = 'Beach Visitor'},
    {id = 155, name = 'Well Stacked Pizza Worker'},
    {id = 156, name = 'Barber'},
    {id = 157, name = 'Hillbilly'},
    {id = 158, name = 'Farmer'},
    {id = 159, name = 'Hillbilly'},
    {id = 160, name = 'Hillbilly'},
    {id = 161, name = 'Farmer'},
    {id = 162, name = 'Hillbilly'},
    {id = 163, name = 'Black Bouncer'},
    {id = 164, name = 'White Bouncer'},
    {id = 165, name = 'White MIB agent'},
    {id = 166, name = 'Black MIB agent'},
    {id = 167, name = 'Cluckin\' Bell Worker'},
    {id = 168, name = 'Hotdog/Chilli Dog Vendor'},
    {id = 169, name = 'Normal Ped'},
    {id = 170, name = 'Normal Ped'},
    {id = 171, name = 'Blackjack Dealer'},
    {id = 172, name = 'Casino croupier'},
    {id = 173, name = 'San Fierro Rifa'},
    {id = 174, name = 'San Fierro Rifa'},
    {id = 175, name = 'San Fierro Rifa'},
    {id = 176, name = 'Barber'},
    {id = 177, name = 'Barber'},
    {id = 178, name = 'Whore'},
    {id = 179, name = 'Ammunation Salesman'},
    {id = 180, name = 'Tattoo Artist'},
    {id = 181, name = 'Punk'},
    {id = 182, name = 'Cab Driver'},
    {id = 183, name = 'Normal Ped'},
    {id = 184, name = 'Normal Ped'},
    {id = 185, name = 'Normal Ped'},
    {id = 186, name = 'Normal Ped'},
    {id = 187, name = 'Businessman'},
    {id = 188, name = 'Normal Ped'},
    {id = 189, name = 'Valet'},
    {id = 190, name = 'Barbara Schternvart'},
    {id = 191, name = 'Helena Wankstein'},
    {id = 192, name = 'Michelle Cannes'},
    {id = 193, name = 'Katie Zhan'},
    {id = 194, name = 'Millie Perkins'},
    {id = 195, name = 'Denise Robinson'},
    {id = 196, name = 'Farm-Town inhabitant'},
    {id = 197, name = 'Hillbilly'},
    {id = 198, name = 'Farm-Town inhabitant'},
    {id = 199, name = 'Farm-Town inhabitant'},
    {id = 200, name = 'Hillbilly'},
    {id = 201, name = 'Farmer'},
    {id = 202, name = 'Farmer'},
    {id = 203, name = 'Karate Teacher'},
    {id = 204, name = 'Karate Teacher'},
    {id = 205, name = 'Burger Shot Cashier'},
    {id = 206, name = 'Cab Driver'},
    {id = 207, name = 'Prostitute'},
    {id = 208, name = 'Su Xi Mu (Suzie)'},
    {id = 209, name = 'Oriental Noodle stand vendor'},
    {id = 210, name = 'Oriental Boating School Instructor'},
    {id = 211, name = 'Clothes shop staff'},
    {id = 212, name = 'Homeless'},
    {id = 213, name = 'Weird old man'},
    {id = 214, name = 'Waitress (Maria Latore)'},
    {id = 215, name = 'Normal Ped'},
    {id = 216, name = 'Normal Ped'},
    {id = 217, name = 'Clothes shop staff'},
    {id = 218, name = 'Normal Ped'},
    {id = 219, name = 'Rich Woman'},
    {id = 220, name = 'Cab Driver'},
    {id = 221, name = 'Normal Ped'},
    {id = 222, name = 'Normal Ped'},
    {id = 223, name = 'Normal Ped'},
    {id = 224, name = 'Normal Ped'},
    {id = 225, name = 'Normal Ped'},
    {id = 226, name = 'Normal Ped'},
    {id = 227, name = 'Oriental Businessman'},
    {id = 228, name = 'Oriental Ped'},
    {id = 229, name = 'Oriental Ped'},
    {id = 230, name = 'Homeless'},
    {id = 231, name = 'Normal Ped'},
    {id = 232, name = 'Normal Ped'},
    {id = 233, name = 'Normal Ped'},
    {id = 234, name = 'Cab Driver'},
    {id = 235, name = 'Normal Ped'},
    {id = 236, name = 'Normal Ped'},
    {id = 237, name = 'Prostitute'},
    {id = 238, name = 'Prostitute'},
    {id = 239, name = 'Homeless'},
    {id = 240, name = 'The D.A'},
    {id = 241, name = 'Afro-American'},
    {id = 242, name = 'Mexican'},
    {id = 243, name = 'Prostitute'},
    {id = 244, name = 'Stripper'},
    {id = 245, name = 'Prostitute'},
    {id = 246, name = 'Stripper'},
    {id = 247, name = 'Biker'},
    {id = 248, name = 'Biker'},
    {id = 249, name = 'Pimp'},
    {id = 250, name = 'Normal Ped'},
    {id = 251, name = 'Lifeguard'},
    {id = 252, name = 'Naked Valet'},
    {id = 253, name = 'Bus Driver'},
    {id = 254, name = 'Biker Drug Dealer'},
    {id = 255, name = 'Chauffeur (Limo Driver)'},
    {id = 256, name = 'Stripper'},
    {id = 257, name = 'Stripper'},
    {id = 258, name = 'Heckler'},
    {id = 259, name = 'Heckler'},
    {id = 260, name = 'Construction Worker'},
    {id = 261, name = 'Cab driver'},
    {id = 262, name = 'Cab driver'},
    {id = 263, name = 'Normal Ped'},
    {id = 264, name = 'Clown (Ice-cream Van Driver)'},
    {id = 265, name = 'Officer Frank Tenpenny (Corrupt Cop)'},
    {id = 266, name = 'Officer Eddie Pulaski (Corrupt Cop)'},
    {id = 267, name = 'Officer Jimmy Hernandez'},
    {id = 268, name = 'Dwaine/Dwayne'},
    {id = 269, name = 'Melvin "Big Smoke" Harris (Mission)'},
    {id = 270, name = 'Sean \'Sweet\' Johnson'},
    {id = 271, name = 'Lance \'Ryder\' Wilson'},
    {id = 272, name = 'Mafia Boss'},
    {id = 273, name = 'T-Bone Mendez'},
    {id = 274, name = 'Paramedic (Emergency Medical Technician)'},
    {id = 275, name = 'Paramedic (Emergency Medical Technician)'},
    {id = 276, name = 'Paramedic (Emergency Medical Technician)'},
    {id = 277, name = 'Firefighter'},
    {id = 278, name = 'Firefighter'},
    {id = 279, name = 'Firefighter'},
    {id = 280, name = 'Los Santos Police Officer'},
    {id = 281, name = 'San Fierro Police Officer'},
    {id = 282, name = 'Las Venturas Police Officer'},
    {id = 283, name = 'County Sheriff'},
    {id = 284, name = 'LSPD Motorbike Cop'},
    {id = 285, name = 'S.W.A.T Special Forces'},
    {id = 286, name = 'Federal Agent'},
    {id = 287, name = 'San Andreas Army'},
    {id = 288, name = 'Desert Sheriff'},
    {id = 289, name = 'Zero'},
    {id = 290, name = 'Ken Rosenberg'},
    {id = 291, name = 'Kent Paul'},
    {id = 292, name = 'Cesar Vialpando'},
    {id = 293, name = 'Jeffery "OG Loc" Martin/Cross'},
    {id = 294, name = 'Wu Zi Mu (Woozie)'},
    {id = 295, name = 'Michael Toreno'},
    {id = 296, name = 'Jizzy B.'},
    {id = 297, name = 'Madd Dogg'},
    {id = 298, name = 'Catalina'},
    {id = 299, name = 'Claude Speed'},
    {id = 300, name = 'Los Santos Police Officer (Without gun holster)'},
    {id = 301, name = 'San Fierro Police Officer (Without gun holster)'},
    {id = 302, name = 'Las Venturas Police Officer (Without gun holster)'},
    {id = 303, name = 'Los Santos Police Officer (Without uniform)'},
    {id = 304, name = 'Los Santos Police Officer (Without uniform)'},
    {id = 305, name = 'Las Venturas Police Officer (Without uniform)'},
    {id = 306, name = 'Los Santos Police Officer'},
    {id = 307, name = 'San Fierro Police Officer'},
    {id = 308, name = 'San Fierro Paramedic (Emergency Medical Technician)'},
    {id = 309, name = 'Las Venturas Police Officer'},
    {id = 310, name = 'Country Sheriff (Without hat)'},
    {id = 311, name = 'Desert Sheriff (Without hat)'},
}
local arzskins = {}

local fightstyles = {
    {name = 'Default', id = 4},
    {name = 'Boxing', id = 5},
    {name = 'Kung Fu', id = 6},
    {name = 'Knee head', id = 7},
    {name = 'Grabkick', id = 15},
    {name = 'Elbows', id = 16},
}

local walkstyles = {
    {name = 'Ролики', handle = 'skate'},
    {name = '(Муж.) Мужчина', handle = 'man'},
    {name = '(Муж.) Дед', handle = 'oldman'},
    {name = '(Муж.) Толстый дед', handle = 'oldfatman'},
    {name = '(Муж.) Толстый мужик', handle = 'fatman'},
    {name = '(Муж.) (ALT) Пробежка', handle = 'shuffle'},
    {name = '(Муж.) Геттовец 1', handle = 'gang1'},
    {name = '(Муж.) Геттовец 2', handle = 'gang2'},
    {name = '(Муж.) (ALT) Пробежка', handle = 'jogger'},
    {name = '(Муж.) (ALT) Пьяный', handle = 'drunkman'},
    {name = '(Муж.) Слепой', handle = 'blindman'},
    {name = '(Муж.) S.W.A.T', handle = 'swat'},

    {name = '(Жен) Женщина', handle = 'woman'},
    {name = '(Жен) (ALT) Пробежка', handle = 'jogwoman'},
    {name = '(Жен) Корзинка', handle = 'shopping'},
    {name = '(Жен) Занятая женщина', handle = 'busywoman'},
    {name = '(Жен) Секси чикса', handle = 'sexywoman'},
    {name = '(Жен) Про (хз че эт)', handle = 'pro'},
    {name = '(Жен) Бабка', handle = 'oldwoman'},
    {name = '(Жен) Толстая телка', handle = 'fatwoman'},
    {name = '(Жен) 300кг фемка', handle = 'oldfatwoman'},
}

function LOAD_LAUNCHER_SKINS() -- from vAcs
    local file = getGameDirectory()..'\\SAMP\\SAMP.ide'
    if doesFileExist(file) then
        arzskins = {}
        local F = io.open(file, r)
        local Text = F:read('*all')
        F:close()

        local pedline = 0
        local lineIndex = 0
        local l_s_count  = 0
        for line in Text:gmatch('[^\n]+') do
            lineIndex = lineIndex + 1
            if line:find('^peds') then
                pedline = lineIndex
            end
            if pedline ~= 0 and lineIndex > pedline then
                if line:find('(%d+), (%w+)') then
                    local id, model = line:match('(%d+), (%w+)') 
                    if tonumber(id) then
                        local model = model..' ('..id..')'
                        --print('NEW LAUNCHER SKIN:', id, model)
                        if tonumber(id) > 311 then
                            table.insert(arzskins, {id = tonumber(id) or 0, name = '(ARZ) '..tostring(model) or 'unknown'})
                            l_s_count = l_s_count + 1
                        end
                    end
                end
            end
        end
        print('Загружено '..l_s_count..' лаунчерных скинов!')
    else
        print('Ошибка загрузки Launcher скинов, файл не найден', 2, true, false)
    end
end

local selected = {
    skin = ini.main.skin,
    fight = ini.main.fight,
    walk = ini.main.walk
}

local sampev = require 'lib.samp.events'

function main()
    while not isSampAvailable() do wait(200) end
    LOAD_LAUNCHER_SKINS()
    if not doesDirectoryExist(getWorkingDirectory()..'\\config') then createDirectory(getWorkingDirectory()..'\\config') end
    if not doesFileExist(json) then
        local t = {
            ['chapo'] = {skin = 49},
        }
        jsonSave(json, t)
    end
    list = jsonRead(json)

    sampRegisterChatCommand('askin', function()
        window.v = not window.v
    end)
    imgui.Process = false
    window.v = false  --show window on start
    if isArizonaLauncher() then
        print('Лаунчер, загружаю скины...')
        for i = 1, #arzskins do
            table.insert(skins, arzskins[i])
        end
    end
    while true do
        wait(0)
        imgui.Process = window.v

        
        if selected.skin ~= 0 then
            if skins[selected.skin].id ~= getCharModel(PLAYER_PED) then
                apply(skins[selected.skin].id)
            end
        end

        for k, v in pairs(getAllChars()) do
            local result, id = sampGetPlayerIdByCharHandle(v)
            if result then
                local name = sampGetPlayerNickname(id)
                if list[name] ~= nil then
                    if getCharModel(v) ~= list[name].skin then
                        setPlayerSkin(id, list[name].skin)
                    end
                end
            end
        end
    end
end
    
local search = imgui.ImBuffer(256)

local fa = require 'fAwesome5' -- ICONS LIST: https://fontawesome.com/v5.15/icons?d=gallery&s=solid&m=free

local fa_font = nil
local font_title = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true
        
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 20.0, font_config, fa_glyph_ranges)
    end
    if font_title == nil then
        font_title = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 20.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) -- вместо 30 любой нужный размер
    end
    
end

function imgui.IconButton(icon, text, size)
    local c = imgui.GetCursorPos()
    local bebra = imgui.Button('##'..text, imgui.ImVec2(160, 50))
    imgui.SetCursorPos(imgui.ImVec2(c.x + 10, c.y + 20))
    imgui.Text(icon)

    imgui.SetCursorPos(imgui.ImVec2(c.x + 50, c.y + 7 + imgui.CalcTextSize(text).y / 2))
    imgui.PushFont(font_title)
    imgui.Text(text)
    imgui.PopFont()
    search.v = ''
    
    return bebra
end

local players_selected = -1
local players_selected_name = 'NONE'

local tab = 0

function isArizonaLauncher()
    return doesFileExist(getGameDirectory()..'\\_CoreGame.asi') or doesFileExist(getGameDirectory()..'\\_ci.asi')
end 

function isArizonaSkin(id)
    return id > 311 or id < 0
end

function imgui.CenterText(text)
    imgui.SetCursorPosX(imgui.GetWindowSize().x / 2 - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end

local rollerfix = imgui.ImBool(true)
local normalturn = imgui.ImBool(true)

function save()
    ini.main.skin = selected.skin
    ini.main.fight = selected.fight
    ini.main.walk = selected.walk
    jsonSave(json, list)
    inicfg.save(ini, directIni)
end

function imgui.OnDrawFrame()
    if window.v then
        local resX, resY = getScreenResolution()
        local sizeX, sizeY = 400, 330 -- WINDOW SIZE
        imgui.SetNextWindowPos(imgui.ImVec2(resX / 2 - sizeX / 2, resY / 2 - sizeY / 2), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(sizeX, sizeY), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'хуй', window, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize)
            --==[ TITLE ]==--
            imgui.SetCursorPos(imgui.ImVec2(0, 0))
            local dl = imgui.GetWindowDrawList()
            local p = imgui.GetCursorScreenPos()
            dl:AddRectFilled(p, imgui.ImVec2(p.x + sizeX, p.y + 40), imgui.GetColorU32(imgui.ImVec4(0.20, 0.25, 0.29, 1.00)), 5, 1 + 2)

            imgui.SetCursorPos(imgui.ImVec2(sizeX - 25, 10))
            if imgui.Button(fa.ICON_FA_TIMES, imgui.ImVec2(20, 20)) then window.v = false end

            imgui.PushFont(font_title)
            
            local title_text = 'Skin Changer'
            imgui.SetCursorPos(imgui.ImVec2(40 / 2 - imgui.CalcTextSize(title_text).y / 2, 40 / 2 - imgui.CalcTextSize(title_text).y / 2))
            imgui.TextColored(imgui.ImVec4(1, 1, 1, 1), title_text)
            imgui.PopFont()
            

            if tab == 0 then
                -- BUTTONS
                imgui.SetCursorPos(imgui.ImVec2(30, 40 + 30))
                if imgui.IconButton(fa.ICON_FA_TSHIRT, u8'Скин') then tab = 1 end

                imgui.SetCursorPos(imgui.ImVec2(sizeX - 30 - 160, 70))
                if imgui.IconButton(fa.ICON_FA_WALKING, u8'Походка') then tab = 2 end

                imgui.SetCursorPos(imgui.ImVec2(30, 70 + 50 + 30))
                if imgui.IconButton(fa.ICON_FA_HAND_ROCK, u8'Стиль боя') then tab = 3 end

                imgui.SetCursorPos(imgui.ImVec2(sizeX - 30 - 160, 70 + 50 + 30))
                if imgui.IconButton(fa.ICON_FA_USERS, u8'Игроки') then tab = 4 end
                
                imgui.SetCursorPos(imgui.ImVec2(30, sizeY / 2 + 65))
                imgui.BeginChild('bebra', imgui.ImVec2(sizeX - 60, sizeY - sizeY / 2 - 65 - 30), true)

                imgui.CenterText(u8'Скины с лаунчера: '..(isArizonaLauncher() and u8'доступны' or u8'недоступны'))
                imgui.CenterText(u8'Доступные скины: '..tostring(#skins))
                imgui.CenterText(u8'Доступные стили боя: '..tostring(#fightstyles)..u8', стили ходьбы: '..tostring(#walkstyles))
                
                --imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(1, 1, 1, 1.00))
                --imgui.PushStyleColor(imgui.Col.FrameBgHovered, imgui.ImColor(100, 100, 100, 180):GetU32())
                --imgui.SetCursorPosX(5) imgui.ToggleButton('##rollerfix', rollerfix) imgui.SameLine() imgui.Text(u8'Фикс скинов на роликах')
                --imgui.SetCursorPosX(5) imgui.ToggleButton('##normalturn', normalturn) imgui.SameLine() imgui.Text(u8'Фикс поворотов')
                --imgui.PopStyleColor(2)

                    imgui.EndChild()
                --imgui.Separator()
                imgui.SetCursorPosY(sizeY - 23)
                imgui.CenterText('by chapo')
            else
                imgui.SetCursorPos(imgui.ImVec2(5, 45))
                if imgui.Button(fa.ICON_FA_ANGLE_DOUBLE_LEFT , imgui.ImVec2(40, sizeY - 40 - 10)) then tab = 0 search.v = '' end

                imgui.SetCursorPos(imgui.ImVec2(55, 45))
                imgui.Text(u8'Поиск: ') imgui.SameLine() 
                imgui.PushItemWidth(sizeX - 20 - 90)
                imgui.InputText('##search', search)
                imgui.PopItemWidth()

                imgui.SetCursorPos(imgui.ImVec2(55, 70))
                imgui.BeginChild('list', imgui.ImVec2(sizeX - 60, (tab ~= 4 and sizeY - 45 - 5 - 25 or sizeY - 45 - 5 - 25 - 30)), true)
                imgui.SetCursorPosX(5)
                if tab == 1 then
                    if imgui.Selectable(u8'Выкл', selected.skin == 0) then selected.skin = 0 apply() end
                    for i = 1, #skins do
                        local text = tostring(skins[i].id)..' - '..skins[i].name
                        if #search.v > 0 and text:lower():lower():find(search.v) or #search.v == 0 then
                            imgui.SetCursorPosX(5)
                            if imgui.Selectable((selected.skin == i and u8'• ' or '') .. text, selected.skin == i) then 
                                selected.skin = i 
                                apply()
                                save()
                            end
                        end

                    end
                elseif tab == 2 then
                    if imgui.Selectable(u8'Выкл', selected.walk == 0) then selected.walk = 0 apply() end
                    if #search.v > 0 and u8(walkstyles[i].name):lower():lower():find(search.v) or #search.v == 0 then
                        for i = 1, #walkstyles do
                            imgui.SetCursorPosX(5)
                            if imgui.Selectable((selected.walk == i and u8'• ' or '') .. u8(walkstyles[i].name), selected.walk == i) then selected.walk = i apply()  end
                        end
                    end
                elseif tab == 3 then
                    if imgui.Selectable(u8'Выкл', selected.fight == 0) then selected.fight = 0 apply() end
                    for i = 1, #fightstyles do
                        if #search.v > 0 and u8(fightstyles[i].name):lower():lower():find(search.v) or #search.v == 0 then
                            imgui.SetCursorPosX(5)
                            if imgui.Selectable((selected.fight == i and u8'• ' or '') .. u8(fightstyles[i].name), selected.fight == i) then selected.fight = i apply() end
                        end
                    end
                elseif tab == 4 then
                    for k, v in pairs(list) do
                        if v ~= nil then
                            imgui.SetCursorPosX(5)
                            if imgui.Selectable(k..u8': скин: '..tostring(v.skin), players_selected == i) then 
                                players_selected = i 
                                players_selected_name = k
                                jsonSave(json, list)
                            end
                        end
                    end
                    
                end
                imgui.EndChild()
                if tab == 4 then
                    local btnSizeX = (sizeX - 60) / 2 - 10
                    imgui.SetCursorPosX(55)
                    if imgui.Button(u8'Добавить', imgui.ImVec2(btnSizeX, 20)) then imgui.OpenPopup(u8'Добавление лошпеда') end
                    imgui.SameLine(55 + btnSizeX + 20)
                    if imgui.Button(u8'Удалить', imgui.ImVec2(btnSizeX, 20)) then 
                        if list[players_selected_name] ~= nil then
                            list[players_selected_name] = nil
                            save()
                        else
                            sampAddChatMessage(players_selected_name..' не найден в списке :(', -1)
                        end
                    end 
                end
            end
            
            if imgui.BeginPopupModal(u8'Добавление лошпеда', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
                local sizeX, sizeY = 300, 200
                imgui.SetWindowSize(imgui.ImVec2(sizeX, sizeY))

                imgui.SetCursorPosX(5)imgui.Text(u8'Ник:') imgui.SameLine(50)
                imgui.PushItemWidth(sizeX - 55)
                imgui.InputText('##nick', add_player.nick)
                imgui.PopItemWidth()

                imgui.SetCursorPosX(5)
                imgui.BeginChild('s', imgui.ImVec2(sizeX - 10, 115), true)
                for i = 1, #skins do
                    local text = tostring(skins[i].id)..' - '..skins[i].name
                    imgui.SetCursorPosX(5)
                    if imgui.Selectable(text, add_player.selected == i) then 
                        add_player.selected = i 
                        jsonSave(json, list)
                        save()
                    end
                end
                imgui.EndChild()

                imgui.SetCursorPos(imgui.ImVec2(5, sizeY - 25 - 25))
                if imgui.Button(u8'Добавить', imgui.ImVec2(sizeX - 10, 20)) then
                    list[add_player.nick.v] = {skin = skins[add_player.selected].id}
                    jsonSave(json, list)
                    save()
                    imgui.CloseCurrentPopup()
                end

                imgui.SetCursorPos(imgui.ImVec2(5, sizeY - 25))
                if imgui.Button(u8'Закрыть', imgui.ImVec2(sizeX - 10, 20)) then
                    jsonSave(json, list)
                    save()
                    imgui.CloseCurrentPopup()
                end

                imgui.EndPopup()
            end
            
        imgui.End()
    end
end

function apply(skin)
    save()
    if selected.skin ~= 0 then
        bs = raknetNewBitStream()
        raknetBitStreamWriteInt32(bs, select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
        raknetBitStreamWriteInt32(bs, skins[selected.skin].id)
        raknetEmulRpcReceiveBitStream(153, bs)
        raknetDeleteBitStream(bs)
    end
    if selected.fight ~= 0 then
        bs = raknetNewBitStream()
        raknetBitStreamWriteInt16(bs, select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
        raknetBitStreamWriteInt8(bs, fightstyles[selected.fight].id)
        raknetEmulRpcReceiveBitStream(89, bs)
        raknetDeleteBitStream(bs)
    end
    if selected.walk ~= 0 then
        setAnimGroupForChar(PLAYER_PED, walkstyles[selected.walk].handle)
    end
end

function setPlayerSkin(player, skin)
    save()
    bs = raknetNewBitStream()
    raknetBitStreamWriteInt32(bs, player)
    raknetBitStreamWriteInt32(bs, skin)
    raknetEmulRpcReceiveBitStream(153, bs)
    raknetDeleteBitStream(bs)
end


function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2
    style.WindowPadding = ImVec2(0, 4)
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
     --style.WindowPadding = ImVec2(0, 0)
     --style.WindowRounding = 5.0
     --style.FramePadding = ImVec2(5, 5)
     --style.ItemSpacing = ImVec2(12, 5)
     --style.ItemInnerSpacing = ImVec2(8, 5)
     --style.IndentSpacing = 25.0
     --style.ScrollbarSize = 15.0
     --style.ScrollbarRounding = 5.0
     --style.GrabMinSize = 15.0
     --style.GrabRounding = 7.0
     --style.ChildWindowRounding = 5.0
     --style.FrameRounding = 6.0
   
 
       colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
       colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
       colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 1.00)
       colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
       colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
       colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
       colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
       colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
       colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
       colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
       colors[clr.TitleBg] = ImVec4(0.09, 0.12, 0.14, 0.65)
       colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
       colors[clr.TitleBgActive] = ImVec4(0.08, 0.10, 0.12, 1.00)
       colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
       colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
       colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
       colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
       colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
       colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
       colors[clr.CheckMark] = ImVec4(ImVec4(0.20, 0.25, 0.29, 0.50))
       colors[clr.SliderGrab] = ImVec4(ImVec4(0.20, 0.25, 0.29, 0.50))
       colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
       colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
       colors[clr.ButtonHovered] = ImVec4(ImVec4(0.20, 0.25, 0.29, 0.50))
       colors[clr.ButtonActive] = ImVec4(ImVec4(0.20, 0.25, 0.29, 0.50))
       colors[clr.Header] = ImVec4(0.20, 0.25, 0.29, 0.55)
       colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
       colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
       colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
       colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
       colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
       colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
       colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
       colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
       colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
       colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
       colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
       colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
       colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
       colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
 end
 apply_custom_style()

--
