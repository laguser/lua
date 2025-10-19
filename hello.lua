script_name("HelloScript")
script_author("Николас")

function main()
    repeat wait(0) until isSampAvailable()  -- ждём, пока SA:MP полностью загрузится
    sampAddChatMessage("{00FF00}Hello", 0xFFFFFFFF)
end
