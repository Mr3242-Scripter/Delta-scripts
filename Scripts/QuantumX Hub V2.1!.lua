local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not Rayfield then
    warn("Rayfield failed to load")
    return
end

---------------------------------------------------
-- WINDOW
---------------------------------------------------
local Window = Rayfield:CreateWindow({
    Name = "QuantumX Hub",
    LoadingTitle = "Loading scripts...",
    LoadingSubtitle = "Follow me on TikTok Mr_3242",
    ConfigurationSaving = { Enabled = false }
})

---------------------------------------------------
-- CONFIG
---------------------------------------------------
local PRIMARY_INDEX = "https://raw.githubusercontent.com/Mr3242-Scripter/Delta-scripts/main/Scripts/QuantumX%20Script%20list.lua"

---------------------------------------------------
-- NOTIFY
---------------------------------------------------
local function Notify(t, c)
    pcall(function()
        Rayfield:Notify({
            Title = tostring(t),
            Content = tostring(c),
            Duration = 4,
            Image = 4483362458
        })
    end)
end

---------------------------------------------------
-- BLACKLIST
---------------------------------------------------
local blacklist = {
    "Quiz bot script (the question about how to custom quiz here’s the answer this isn’t the script)",
    "Fake loading progress",
    "⚠️this is not a script ⚠️ Daycare 💥 virus combinations",
    "QuantumX Script list",
    "QuantumX Hub V2.1!",
    "This isn’t a script its a Ui Library i made",
    "How to use loadstring",
    "rayfield made by sirius",
    "Sign in"
}

local function isBlocked(name)
    name = tostring(name or ""):lower()
    for _, bad in ipairs(blacklist) do
        if bad ~= "" and name:find(bad:lower(), 1, true) then
            return true
        end
    end
    return false
end

---------------------------------------------------
-- CATEGORY SETUP
---------------------------------------------------
local categoryOrder = {
    "Admin", "Hub", "Games", "Automation", "Movement",
    "Visuals", "Tools", "Misc", "Bypasses"
}

local categories = {}
for _, name in ipairs(categoryOrder) do
    categories[name] = {}
end

---------------------------------------------------
-- HTTP
---------------------------------------------------
local function httpGet(url, retries)
    retries = retries or 3
    for i = 1, retries do
        local ok, res = pcall(function()
            return game:HttpGet(url)
        end)
        if ok and type(res) == "string" and #res > 20 then
            return res
        end
        task.wait(0.2 * i)
    end
    return nil
end

---------------------------------------------------
-- CLEAN TEXT
---------------------------------------------------
local function clean(text)
    return (text or "")
        :gsub("&amp;", "&")
        :gsub("<.->", "")
        :gsub("%s+", " ")
        :match("^%s*(.-)%s*$") or ""
end

---------------------------------------------------
-- CATEGORY DETECTION
---------------------------------------------------
local function getCategory(name)
    local n = clean(name):lower()

    if n:find("admin", 1, true) or n:find("nameless", 1, true)
        or n:find("command", 1, true) or n:find("cmd", 1, true)
        or n:find("admin panel", 1, true) then
        return "Admin"
    elseif n:find("hub", 1, true) or n:find("script hub", 1, true)
        or n:find("universal sus", 1, true)
        or n:find("universal badass", 1, true)
        or n:find("voidware", 1, true) then
        return "Hub"
    elseif n:find("simulator", 1, true) or n:find("obby", 1, true)
        or n:find("battleground", 1, true) or n:find("daycare", 1, true)
        or n:find("brainrot", 1, true) or n:find("slap battles", 1, true)
        or n:find("among us", 1, true) or n:find("bridge battles", 1, true)
        or n:find("prison run", 1, true) or n:find("flee the facility", 1, true)
        or n:find("murder vs", 1, true) or n:find("find who slapped", 1, true)
        or n:find("(game)", 1, true) or n:find("game:", 1, true) then
        return "Games"
    elseif n:find("auto farm", 1, true) or n:find("autofarm", 1, true)
        or n:find("auto click", 1, true) or n:find("autoclick", 1, true)
        or n:find("auto buy", 1, true) or n:find("auto roll", 1, true)
        or n:find("auto piano", 1, true) or n:find("instant", 1, true)
        or n:find("farm", 1, true) or n:find("clicker", 1, true) then
        return "Automation"
    elseif n:find("fly", 1, true) or n:find("speed", 1, true)
        or n:find("frost walker", 1, true) or n:find("walkspeed", 1, true)
        or n:find("jump", 1, true) or n:find("infjump", 1, true)
        or n:find("inf jump", 1, true) or n:find("infinite jump", 1, true)
        or n:find("gravity", 1, true) or n:find("noclip", 1, true)
        or n:find("teleport", 1, true) or n:find("shiftlock", 1, true)
        or n:find("wall climber", 1, true) or n:find("wall climb", 1, true)
        or n:find("r15 to r6", 1, true) then
        return "Movement"
    elseif n:find("esp", 1, true) or n:find("wallhack", 1, true)
        or n:find("highlight", 1, true) or n:find("tracer", 1, true)
        or n:find("chams", 1, true) or n:find("xray", 1, true)
        or n:find("fullbright", 1, true) or n:find("fov", 1, true)
        or n:find("visual", 1, true) or n:find("invisible", 1, true)
        or n:find("invisibility", 1, true) then
        return "Visuals"
    elseif n:find("dex", 1, true) or n:find("cobalt", 1, true)
        or n:find("npc controller", 1, true) or n:find("quiz bot", 1, true)
        or n:find("decompiler", 1, true) or n:find("inspector", 1, true)
        or n:find("monitor", 1, true) or n:find("fps", 1, true)
        or n:find("gui", 1, true) or n:find("utility", 1, true)
        or n:find("music player", 1, true) or n:find("product buyer", 1, true)
        or n:find("draggable", 1, true) or n:find("explorer", 1, true) then
        return "Tools"
    elseif n:find("bypass", 1, true) or n:find("anti cheat", 1, true) then
        return "Bypasses"
    end
    return "Misc"
end

---------------------------------------------------
-- STORAGE
---------------------------------------------------
local seen = {}
local totalLoaded = 0

local function addScript(name, url)
    name = clean(name)
    url = clean(url)

    if name == "" or url == "" then return end
    if not url:find("^https?://") then return end
    if isBlocked(name) then return end
    if seen[url] then return end

    seen[url] = true
    totalLoaded = totalLoaded + 1

    local cat = getCategory(name)
    table.insert(categories[cat], {
        name = name,
        url = url
    })
end

---------------------------------------------------
-- PARSER (super robust)
---------------------------------------------------
local function parsePrimary(data)
    for line in data:gmatch("[^\r\n]+") do
        line = line:match("^%s*(.-)%s*$") or ""  -- trim
        if line == "" then continue end

        -- Find the first = that has an http URL after it
        local eqPos = line:find("=")
        if not eqPos then continue end

        local name = line:sub(1, eqPos - 1)
        local url  = line:sub(eqPos + 1)

        -- Clean URL (remove any trailing junk)
        url = url:match("(https?://%S+)") or url

        addScript(name, url)
    end
end

---------------------------------------------------
-- RUN SCRIPT
---------------------------------------------------
local function runScript(url)
    Notify("Loading...", "Please wait")
    local content = httpGet(url, 3)

    if not content or content:lower():find("<html") or #content < 30 then
        Notify("Error", "Failed to load script")
        return
    end

    pcall(function()
        Rayfield:Destroy()
    end)

    task.wait(0.15)

    local ok, err = pcall(function()
        loadstring(content)()
    end)

    if not ok then
        Notify("Execution Error", tostring(err):sub(1, 100))
    end
end

---------------------------------------------------
-- BUILD UI
---------------------------------------------------
local function buildUI()
    local anyTab = false

    for _, catName in ipairs(categoryOrder) do
        local list = categories[catName]
        if #list > 0 then
            anyTab = true
            local tab = Window:CreateTab(catName, 4483362458)

            -- Sort alphabetically for nicer look
            table.sort(list, function(a, b)
                return a.name:lower() < b.name:lower()
            end)

            for _, script in ipairs(list) do
                tab:CreateButton({
                    Name = script.name,
                    Callback = function()
                        runScript(script.url)
                    end
                })
            end
        end
    end

    if not anyTab then
        local tab = Window:CreateTab("Error", 4483362458)
        tab:CreateParagraph({
            Title = "No scripts found",
            Content = "Could not load any scripts from the list.\nCheck your executor's HttpGet or try again."
        })
    end
end

---------------------------------------------------
-- LOAD EVERYTHING
---------------------------------------------------
task.spawn(function()
    Notify("QuantumX Hub", "Fetching script list...")

    local primary = httpGet(PRIMARY_INDEX, 3)

    if not primary then
        Notify("Error", "Failed to download script list!")
        local tab = Window:CreateTab("Error", 4483362458)
        tab:CreateParagraph({
            Title = "Failed to load",
            Content = "HttpGet failed for the script list.\nYour executor might be blocking GitHub."
        })
        return
    end

    parsePrimary(primary)
    buildUI()

    Notify("Loaded!", totalLoaded .. " scripts ready")

    ---------------------------------------------------
    -- CREDITS
    ---------------------------------------------------
    local CreditsTab = Window:CreateTab("Credits", 4483362458)

    CreditsTab:CreateParagraph({
        Title = "Credits",
        Content = "QuantumX Hub created by Mr_3242\nThanks for using the hub!"
    })

    local function copy(txt)
        if typeof(setclipboard) == "function" then
            pcall(setclipboard, txt)
        end
    end

    CreditsTab:CreateButton({
        Name = "Copy TikTok",
        Callback = function() copy("https://www.tiktok.com/@Mr_3242") end
    })

    CreditsTab:CreateButton({
        Name = "Copy YouTube",
        Callback = function() copy("https://www.youtube.com/@Mr_3242.") end
    })

    CreditsTab:CreateButton({
        Name = "Copy Twitch",
        Callback = function() copy("https://m.twitch.tv/quantumx_42/home") end
    })

    ---------------------------------------------------
    -- UNLOAD
    ---------------------------------------------------
    local UnloadTab = Window:CreateTab("Unload", 4483362458)
    UnloadTab:CreateButton({
        Name = "Unload Script",
        Callback = function()
            pcall(function()
                Rayfield:Destroy()
            end)
        end
    })
end)
