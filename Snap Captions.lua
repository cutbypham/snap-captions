-- Copyright (C) 2023 Orson Lord & Dan Knowlton
-- Updates by Asher Roland
--
-- Snap Captions v1.6.06
-- This tool automates the process of creating Text+ clips from subtitle
-- clips.
--
-- If you find this tool useful, please consider donating to support its
-- development: https://bit.ly/SnapCaptions
--
-- This software can not be redistributed or sold without the express
-- permission of the authors.

local DONATE_URL =
"https://bit.ly/SnapCaptions"                                                                             -- Donate to Snap Captions
local HUB_URL =
"https://mediable.notion.site/Snap-Captions-HUB-4e74a79db14748f098be647e40664da8"                         -- Get Help from the Hub
local noSnapPathFound =
"https://bit.ly/46PfP3B"                                                                                  -- Snap Captions Current Path could not be found when Installing
local snapInstallFailed =
"https://bit.ly/3WIv0XO"                                                                                  -- Snap Captions Could Not Install
local noUTF8File =
"https://bit.ly/3M15NTp"                                                                                  -- UTF8 File not With Snap Captions File When Installing
local UTF8FailedInstall =
"https://bit.ly/4fwWZSK"                                                                                  -- UTF8 File Could Not Install
local UTF8FailedLoad =
"https://bit.ly/4dCmVur"                                                                                  -- UTF8 did not Load Properly
local noFusionCompInTemplate =
"https://bit.ly/4cnJSAq"                                                                                  -- No Fusion Comp was Found in Chosen 'Template'
local noTextPlusInTemplate =
"https://bit.ly/46O1Gnq"                                                                                  -- No Text+ Node was Found in Chosen Template's Comp
local noSubtitleTrack =
"https://bit.ly/3WXVF41"                                                                                  -- There is No Subtitle Track When User Starts Generating
local AddTrackFailed =
"https://bit.ly/3yyabpT"                                                                                  -- Could Not Add a New Video Track
local noTimeline =
"https://bit.ly/4dFtxbl"                                                                                  -- No Timeline Opened and Active
local noTemplates =
"https://bit.ly/4dihVvd"                                                                                  -- Video Link for When User Tries Generating Without any Text+ Templates
local noNewPacks =
"https://bit.ly/4hnM7aW"                                                                                  -- No New Packs were Found in User's Selected Folder
local noCleanPack =
"https://bit.ly/3Uz9CUJ"                                                                                  -- Clean Pack Not With Snap Captions File when Installing
local CleanFailedInstall =
"https://bit.ly/3NPwATK"                                                                                  -- Clean Pack did not Install correctly
local PackMangagerTUT =
"https://bit.ly/4dWaolc"                                                                                  -- Learn How to Use the Pack Manager (Could be slip between 'Your Library' and 'Add Packs')
local GetMorePacks =
"https://mediable.notion.site/Official-Snap-Caption-Template-Pack-125c4270216c808f837cc3cd9c053a9d?pvs=4" -- 🪫POWER UP🔋 With More Caption Packs!
local REQUEST_URL =
"https://bit.ly/4edlPFB"                                                                                  -- Settings Screen Request Feature Button

-- local hiddenIMGB64 =
-- [[data:image/png;base64,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]]

-- local hiddenLogoIMG =
-- [[data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAASdIAAEnSAahFivgAAAW7aVRYdFhNTDpjb20uYWRvYmUueG1wAAAAAAA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA5LjEtYzAwMSA3OS4xNDYyODk5LCAyMDIzLzA2LzI1LTIwOjAxOjU1ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgMjUuMSAoV2luZG93cykiIHhtcDpDcmVhdGVEYXRlPSIyMDIzLTExLTI1VDIxOjU4OjUzLTA1OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMy0xMS0yNVQyMjowMTozOS0wNTowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMy0xMS0yNVQyMjowMTozOS0wNTowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6YmY0MGZlNDctOWJkZC1mZDRjLTgwYzYtODUz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]]

local utf8 = string
local hasUtf8Support = false

local ui = fu.UIManager
local disp = bmd.UIDispatcher(ui)

local winID = "SnapCaptionsWin"
local ver = "V1.6.06"
local CleanPackName = "Snap Captions - Clean Pack V02.02.drb"

local projectManager = resolve:GetProjectManager()
local mediaStorage = resolve:GetMediaStorage()
local project = projectManager:GetCurrentProject()
local mediaPool = project:GetMediaPool()

local fusion_titles = {}

local TEXT_TEMPLATE_FOLDER = "Snap Captions"

local platform = (FuPLATFORM_WINDOWS and "Windows") or
    (FuPLATFORM_MAC and "Mac") or
    (FuPLATFORM_LINUX and "Linux")


local function script_path()
    return arg[0]
end

local Scripts = app:MapPath('Scripts:/')

function removeFirstTwoItemsFromPath(path)
    -- Check if the path starts with "/Users/"
    if string.sub(path, 1, 7) ~= "/Users/" then
        return path -- Return the original path if it doesn't start with "/Users/"
    end

    -- Find the third slash in the path
    local start = 1
    local count = 0
    while count < 3 do
        start = string.find(path, "/", start + 1)
        if start == nil then
            return path -- If there are not enough slashes, return the original path
        end
        count = count + 1
    end

    -- Remove everything up to the third slash
    return string.sub(path, start + 1)
end

-- 'removeFirstTwoItemsFromPath' causes issues and fixes issues for some. removed the "User/" and username from scripts path
-- Adding Case Check to see if match failes by default, if so then retry with changed path
local function ScriptIsInstalled()
    local script_path = script_path()
    local match
    if platform == "Mac" then
        print("Changing Path for Check:")
        print(Scripts)
        newScripts = removeFirstTwoItemsFromPath(Scripts)
        match = script_path:find(newScripts)
        print("Modified Path:")
        print(newScripts)
    else
        match = script_path:find(Scripts)
    end
    return match ~= nil
end

local SCRIPT_INSTALLED = ScriptIsInstalled()

local function EndDispLoop()
    local win = ui:FindWindow(winID)
    if win ~= nil then
        return
    end

    disp:ExitLoop()
end

local COLUMN_WIDTH = 130
local WINDOW_WIDTH = 320
local WINDOW_HEIGHT = 356

local function hideModal()
    local win = ui:FindWindow(winID)
    win:Find('Modal').Hidden = true
    win:RecalcLayout()
end

local function CreateDialog(title, message, url, noOk, deleteButt)
    if not url then
        url = ""
    end

    local dialog = ui:FindWindow(winID)
    dialog:RecalcLayout()

    dialog:Find('Modal').Hidden = false

    dialog:Find('error_title').Text = title
    dialog:Find('error_message').Text = message

    if deleteButt then
        dialog:Find('Delete').Hidden = false
        dialog:Find('OK').Text = "Don't Delete"
    else
        dialog:Find('Delete').Hidden = true
        dialog:Find('OK').Text = "OK"
    end

    if noOk then
        dialog:Find('OK').Hidden = true
    else
        dialog:Find('OK').Hidden = false
    end

    if url == "" then
        dialog:Find('LINK').Hidden = true
    elseif url ~= "" then
        dialog:Find('LINK').Hidden = false
        dialog:Find('LINK').HTML = "<center><b><a href='" .. url .. "'>Learn To Fix It Quick Here!</a></b></center>"
    end

    dialog:RecalcLayout()

    return dialog
end

local function LoadUTF8Module()
    -- Remove any previously loaded utf8 module.
    package.loaded.utf8_snapcaptions = nil

    hasUtf8Support, utf8 = pcall(require, "utf8_snapcaptions")
    if not hasUtf8Support and SCRIPT_INSTALLED then
        local dialog = CreateDialog("🛑 Uh Oh!",
            "Resolve Couldn't Load My UTF8 Properly, I need this to caption languages other than english!",
            UTF8FailedLoad)
        -- dialog:Show()
        -- dialog:RecalcLayout()
        utf8 = string
    end
end
LoadUTF8Module()

local COMBOBOX_ACTION_BUTTON_CSS = [[
    QPushButton
    {
        border: 1px solid rgb(0,0,0);
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px;
        border-top-left-radius: 0px;
        border-bottom-left-radius: 0px;
        border-left: 0px;
        font-size: 22px;
        min-height: 26px;
        max-height: 26px;
        min-width: 26px;
        max-width: 26px;
        background-color: rgb(31,31,31);
    }
    QPushButton:hover
    {
        color: rgb(255, 255, 255);
    }
    QPushButton:pressed
    {
        background-color: rgb(20,20,20);
    }
]]
local SMALLER_TITLE_CSS = [[
    QLabel
    {
        color: rgb(255, 255, 255);
        font-size: 20px;
        font-weight: bold;
    }
    QLabel:!enabled
    {
        color: rgb(150, 150, 150);
    }
]]
local TITLE_CSS = [[
    QLabel
    {
        color: rgb(255, 255, 255);
        font-size: 30px;
        font-weight: bold;
    }
    QLabel:!enabled
    {
        color: rgb(150, 150, 150);
    }
]]
local START_LOGO_CSS = [[
    QLabel
    {
        color: #fcfc03;
        font-size: 20px;
        font-weight: bold;
        letter-spacing: 1px;
        font-family: 'Readex Pro';
    }
    QLabel:!enabled
    {
        color: rgb(150, 150, 150);
    }
]]
local END_LOGO_CSS = [[
    QLabel
    {
        color: rgb(255, 255, 255);
        font-size: 20px;
        font-weight: bold;
        letter-spacing: 1px;
        font-family: 'Readex Pro';
    }
    QLabel:!enabled
    {
        color: rgb(150, 150, 150);
    }
]]
local SECTION_TITLE_CSS = [[
    QLabel
    {
        color: rgb(255, 255, 255);
        font-size: 13px;
        font-weight: bold;
    }
    QLabel:!enabled
    {
        color: rgb(150, 150, 150);
    }
]]
local BANNER_ACTION_BUTTON_CSS = [[
    QPushButton
    {
        max-height: 20px;
        min-height: 20px;
        color: rgb(200, 200, 200);
        font-size: 12px;
        min-width: 80px;
    }
]]
local PRIMARY_ACTION_BUTTON_CSS = [[
    QPushButton
    {
        border: 1px solid #141414;
        max-height: 28px;
        border-radius: 14px;
        background-color: #1f1f1f;
        color: #fcfc03;
        min-height: 28px;
        font-size: 13px;
        font-family: Readex Pro;
        font-weight: 600;
        letter-spacing: 1px;
        text-shadow: 0 0 3px #FF0000, 0 0 5px #0000FF;
    }
    QPushButton:hover
    {
        border: 2px solid rgb(50,50,50);
        background-color: rgb(20,20,20);
    }
    QPushButton:pressed
    {
        border: 2px solid rgb(0,0,0);
        background-color: rgb(0,0,0);
    }
    QPushButton:!enabled
    {
        border: 2px solid rgb(0,0,0);
        background-color: rgb(0,0,0);
        color: #fcfc03;
    }
]]
local SECONDARY_ACTION_BUTTON_CSS = [[
    QPushButton
    {
        max-height: 24px;
        min-height: 24px;
    }
]]
local FLAT_CSS = [[
    QPushButton
    {
        color: rgb(255, 255, 255);
        font-size: 13px;
        font-weight: bold;
    }
    QPushButton:hover
    {
        font-size: 15px;
    }
]]
local DIVIDER_CSS = [[
    QFrame[frameShape="4"]
    {
        border: none;
        background-color: rgb(30, 30, 30);
        max-height: 1px;
    }
]]
local TITLE_DIV_CSS = [[
    QFrame[frameShape="4"]
    {
        border: none;
        background-color: rgb(30, 30, 30);
        max-height: 2px;
    }
]]
local COMBOBOX_PLACEHOLDER_CSS = [[
    QLabel
    {
        color: rgb(140, 140, 140);
        font-size: 13px;
        min-height: 26px;
        max-height: 26px;
        background-color: rgb(31,31,31);
        border: 1px solid rgb(0,0,0);
        border-top-right-radius: 0px;
        border-bottom-right-radius: 0px;
        border-top-left-radius: 4px;
        border-bottom-left-radius: 4px;
        padding-left: 4px;
    }
]]

local timeline_type_names = {}
timeline_type_names["Timeline"] = true
timeline_type_names["タイムライン"] = true
timeline_type_names["时间线"] = true
timeline_type_names["Línea de tiempo"] = true
timeline_type_names["Linha de Tempo"] = true
timeline_type_names["Временная шкала"] = true
timeline_type_names["ไทม์ไลน์"] = true
timeline_type_names["타임라인"] = true

------------------------------------------------------------------------------
-- parseFilename() from bmd.scriptlib | Also can be found in LoaderFromSaver Script by Alexey Bogomolov
--
-- this is a great function for ripping a filepath into little bits
-- returns a table with the following
--
-- FullPath	: The raw, original path sent to the function
-- Path		: The path, without filename
-- FullName	: The name of the clip w\ extension
-- Name     : The name without extension
-- CleanName: The name of the clip, without extension or sequence
-- SNum		: The original sequence string, or "" if no sequence
-- Number 	: The sequence as a numeric value, or nil if no sequence
-- Extension: The raw extension of the clip
-- Padding	: Amount of padding in the sequence, or nil if no sequence
-- UNC		: A true or false value indicating whether the path is a UNC path or not
------------------------------------------------------------------------------
function parseFilename(filename)
    local seq = {}
    seq.FullPath = filename
    string.gsub(seq.FullPath, "^(.+[/\\])(.+)", function(path, name)
        seq.Path = path
        seq.FullName = name
    end)
    string.gsub(seq.FullName, "^(.+)(%..+)$", function(name, ext)
        seq.Name = name
        seq.Extension = ext
    end)

    if not seq.Name then -- no extension?
        seq.Name = seq.FullName
    end

    string.gsub(seq.Name, "^(.-)(%d+)$", function(name, SNum)
        seq.CleanName = name
        seq.SNum = SNum
    end)

    if seq.SNum then
        seq.Number = tonumber(seq.SNum)
        seq.Padding = string.len(seq.SNum)
    else
        seq.SNum = ""
        seq.CleanName = seq.Name
    end

    if not seq.Extension then seq.Extension = "" end
    seq.UNC = (string.sub(seq.Path, 1, 2) == [[\\]])

    return seq
end

local username
if platform == 'Windows' then
    username = os.getenv('USERPROFILE')
else
    -- For Mac and Linux
    username = os.getenv('HOME')
end

local nonWindowsBase = (platform == "Mac" and username .. "/Library/Application Support") or
    (platform == "Linux" and username .. "/.local/share") or (platform == "Windows" and Scripts .. "Comp/")
if not bmd.direxists(nonWindowsBase) then
    error("There was an issue getting the Application Support Folder!")
    return
end

local installFolder = (platform == "Mac" and username .. "/Library/Application Support/Snap Captions - Installed Packs") or
    (platform == "Linux" and username .. "/.local/share/Snap Captions - Installed Packs") or
    (platform == "Windows" and Scripts .. "Comp/" .. "Snap Captions - Installed Packs")

local function OpenURL(url)
    if bmd.openurl then
        bmd.openurl(url)
        print("[Opening URL] " .. url)
    end
end

local function ClearTable(table)
    for k in pairs(table) do
        table[k] = nil
    end
end

local function CopyFile(source, target)
    if not source then
        print("No Source")
        return false
    end
    local source_file = io.open(source, "r")
    print(source)
    if not source_file then
        print("Source Could Not Open")
        return false
    end
    local contents = source_file:read("*a")
    source_file:close()

    local target_file = io.open(target, "w")
    print(target)
    if not target_file then
        print("Target Could Not Open")
        return false
    end
    target_file:write(contents)
    target_file:close()

    return true
end

local function extractSnapCaptions(inputStr)
    -- Extract the string after "Snap Captions "
    local result = inputStr:match("Snap Captions (.+)")
    if result then
        -- Remove any non-letter and non-number characters that are not a period
        result = result:gsub("[^%w%. ]", "")

        -- Remove a space at the start of the string if one exists
        result = result:gsub("^%s+", "")
    end
    return result
end

local function CopyDRB(source, destination)
    local destPath = parseFilename(destination).Path

    -- Ensure the destination directory exists
    if not bmd.direxists(destPath) then
        bmd.createdir(destPath)
    end

    -- Check if the source file exists
    if not bmd.fileexists(source) then
        error("Source file does not exist: " .. source)
        return false
    end

    -- Use Lua's file handling in binary mode to copy the file
    local file = io.open(source, "rb")
    if not file then
        error("Failed to open source file for reading: " .. source)
        return false
    end

    -- Read the source file in binary mode
    local content = file:read("*a")
    file:close()

    -- Write to the destination file in binary mode
    local destFile = io.open(destination, "wb")
    if not destFile then
        error("Failed to open destination file for writing: " .. destination)
        return false
    end

    destFile:write(content)
    destFile:close()
    return true
end


local function InstallScript()
    local source_path = script_path()
    local target_path = Scripts .. "Comp/"
    local modules_path = app:MapPath('LuaModules:/')

    local script_name = source_path:match(".*[/\\](.*)")
    target_path = target_path .. script_name

    if not bmd.fileexists(source_path) then
        local dialog = CreateDialog("🛑 Uh Oh!",
            "Snap Captions can’t find itself to install! WHAT AN EXISTENTIAL CRISIS 😱!?!", noSnapPathFound)
        -- dialog:Show()
        -- dialog:RecalcLayout()
        return false
    end

    -- Copy the file.
    local success = CopyFile(source_path, target_path)
    if not success then
        local dialog = CreateDialog("🛑 Uh Oh!",
            "Snap Captions Can't Get Permission To Install Into Resolve! The Housing Crisis Even Affects Digital Plugin's Now 🥺",
            snapInstallFailed)
        -- dialog:Show()
        -- dialog:RecalcLayout()
        return false
    end

    -- Also copy the utf8 modules to the Modules folder.
    local utf8_source = source_path:match("(.*[/\\]).+$") .. "utf8_snapcaptions.lua"
    local utf8_target = modules_path .. "utf8_snapcaptions.lua"

    if not bmd.fileexists(utf8_source) then
        local dialog = CreateDialog("🛑 Uh Oh!",
            "The UTF8 File Is Missing! It should have been in the same folder as Snap Captions to ensure it get's included with Installation.",
            noUTF8File)
        -- dialog:Show()
        -- dialog:RecalcLayout()
        return false
    end

    local success = CopyFile(utf8_source, utf8_target)

    if success then
        -- Reload the utf8 module.
        LoadUTF8Module()
    else
        local dialog = CreateDialog("🛑 Uh Oh!",
            "UTF8 File Failed To Install Into Snap Captions", UTF8FailedInstall)
        -- dialog:Show()
        -- dialog:RecalcLayout()
        return false
    end

    if not bmd.direxists(installFolder) then
        bmd.createdir(installFolder)
    end

    local cleanpack_source = source_path:match("(.*[/\\]).+$") .. CleanPackName
    local cleanpack_target = installFolder ..
        "/" ..
        extractSnapCaptions(parseFilename(cleanpack_source).Name) .. "/" .. parseFilename(cleanpack_source).FullName

    if not bmd.fileexists(cleanpack_source) then
        local dialog = CreateDialog("🛑 Uh Oh!",
            "🤔 Snap Captions Can't Find The Clean Caption Template Pack To Install!", noCleanPack)
        -- dialog:Show()
        -- dialog:RecalcLayout()
        return false
    end

    --Install the Clean Pack to the Packs Library
    local success = CopyDRB(cleanpack_source, cleanpack_target)

    if not success then
        local dialog = CreateDialog("🛑 Uh Oh!",
            "🤔 Snap Captions Couldn't Install Some Caption Templates To Get Started! 😱 We have no Caption Templates 😱",
            CleanFailedInstall)
        -- dialog:Show()
        -- dialog:RecalcLayout()
        return false
    end

    print("[Snap Captions] Installed to " .. target_path)
    print("[UTF8 Module] Installed to " .. utf8_target)
    print("[Clean Pack] Installed to " .. cleanpack_target)
    return true
end

local function PopulateSubtitleTracks(win)
    local combobox = win:Find("subtitle_tracks")
    local subtitle_stack = win:Find("subtitle_stack")
    local subtitle_placeholder = win:Find("subtitle_placeholder")
    local subtitle_placeholder2 = win:Find("subtitle_placeholder2")
    combobox:Clear()

    local timeline = project:GetCurrentTimeline()
    if not timeline then
        subtitle_placeholder2:SetVisible(true)
        return
    end
    local track_count = timeline:GetTrackCount("subtitle")
    if track_count == 0 then
        -- ASK TO GENERATE SUBS FOR USER
        combobox:SetEnabled(false)
        subtitle_stack:SetCurrentIndex(1)
        combobox:SetVisible(false)
        subtitle_placeholder:SetVisible(true)
        return
    end

    subtitle_stack:SetCurrentIndex(0)
    combobox:SetEnabled(true)
    subtitle_placeholder:SetVisible(false)
    subtitle_placeholder2:SetVisible(false)
    combobox:SetVisible(true)

    for i = 1, track_count do
        win:Find("subtitle_tracks"):AddItems(
            { "[ST" .. i .. "] " .. timeline:GetTrackName("subtitle", i) })
    end
end

-- Function to list all files in a folder
local function listFiles(folder)
    local files = {}

    -- Determine the command based on the platform
    local command = platform == 'Windows' and ('dir "' .. folder .. '" /b /a-d') or
        ('ls -p "' .. folder .. '" | grep -v /')

    -- Execute the command silently and capture the output
    local handle = io.popen(command)
    if handle then
        for file in handle:lines() do
            table.insert(files, folder .. "/" .. file)
        end
        handle:close()
    end
    if not files[1] then
        error("NO FILE FOUND IN " .. folder)
        return nil
    end
    return files
end

local noTemplateBin
local function PopulateTextTemplates(win)
    ClearTable(fusion_titles)
    local combobox = win:Find("title_templates")
    local title_stack = win:Find("title_stack")
    local title_placeholder = win:Find("title_placeholder")
    combobox:Clear()

    local template_folder = nil
    for _, subfolder in ipairs(mediaPool:GetRootFolder():GetSubFolderList()) do
        if subfolder:GetName() == TEXT_TEMPLATE_FOLDER then
            template_folder = subfolder
            break
        end
    end

    if template_folder == nil or #template_folder:GetClipList() == 0 then
        if template_folder == nil then
            noTemplateBin = true
        else
            title_placeholder:SetText("No Text+ Templates Found")
        end

        title_stack:SetCurrentIndex(1)
        combobox:SetEnabled(false)
        combobox:SetVisible(false)
        title_placeholder:SetVisible(true)
        return
    end

    title_stack:SetCurrentIndex(0)
    combobox:SetEnabled(true)
    title_placeholder:SetVisible(false)
    combobox:SetVisible(true)
    for i, clip in ipairs(template_folder:GetClipList()) do
        -- Filter out items that are not Text+ templates.
        if clip:GetClipProperty("File Path") == "" then
            table.insert(fusion_titles, clip)
            combobox:AddItem(clip:GetClipProperty("Clip Name"))
        end
    end
end


local function PopulateTextTransforms(win)
    local transform_combobox = win:Find("text_transform")
    transform_combobox:Clear()
    transform_combobox:AddItems({ "None" })
    transform_combobox:AddItems({ "to lowercase" })
    transform_combobox:AddItems({ "TO UPPERCASE" })
    transform_combobox:AddItems({ "Capitalize All Words" })
end


local function PopulatePunctuationStyles(win)
    local Punctuation_combobox = win:Find("remove_punctuation")
    Punctuation_combobox:Clear()
    Punctuation_combobox:AddItems({ "None" })
    Punctuation_combobox:AddItems({ "Advanced Settings" })
    Punctuation_combobox:AddItems({ "Remove All" })
    Punctuation_combobox:AddItems({ "Remove Commas" })
    Punctuation_combobox:AddItems({ "Remove Quotes" })
    Punctuation_combobox:AddItems({ "Remove Endings(.!?)" })
    Punctuation_combobox:AddItems({ "Remove 'Other'(:;-)" })
end


local function IsTimelineClip(clip)
    local clip_type = clip:GetClipProperty("Type")
    return timeline_type_names[clip_type] ~= nil
end


local function GetTimelineClipFromMediaPool(timeline_name, folder)
    local folder = folder or mediaPool:GetRootFolder()

    for i, clip in ipairs(folder:GetClipList()) do
        if IsTimelineClip(clip) and
            clip:GetClipProperty("Clip Name") == timeline_name then
            return clip
        end
    end

    for i, subfolder in ipairs(folder:GetSubFolderList()) do
        local clip = GetTimelineClipFromMediaPool(timeline_name, subfolder)
        if clip ~= nil then
            return clip
        end
    end

    return nil
end


local function ConvertTimecodeToFrame(timecode, fps, is_drop_frame, is_interlaced)
    local time_pieces = {}
    for str in string.gmatch(timecode, "(%d+)") do
        table.insert(time_pieces, str)
    end

    local rounded_fps = math.floor(fps + 0.5)

    local hours = tonumber(time_pieces[1])
    local minutes = tonumber(time_pieces[2])
    local seconds = tonumber(time_pieces[3])
    local frame = (hours * 60 * 60 + minutes * 60 + seconds) * rounded_fps
    local frame_count = tonumber(time_pieces[4])

    if is_interlaced then
        frame_count = frame_count * 2
        local add_frame = timecode:find('%.') == nil and timecode:find(',') == nil
        if add_frame then
            frame_count = frame_count + 1
        end
    end

    frame = frame + frame_count

    if is_drop_frame then
        local dropped_frames = math.floor(fps / 15 + 0.5)
        local total_minutes = 60 * hours + minutes

        frame = frame - (dropped_frames * (total_minutes - math.floor(total_minutes / 10)))
    end

    return frame
end


local function ConvertFrameToTimecode(frame, fps, is_drop_frame, is_interlaced)
    local rounded_fps = math.floor(fps + 0.5)
    if is_drop_frame then
        local dropped_frames = math.floor(fps / 15 + 0.5)
        local frames_per_ten = math.floor(fps * 60 * 10 + 0.5)
        local frames_per_minute = (rounded_fps * 60) - dropped_frames

        local d = math.floor(frame / frames_per_ten)
        local m = math.fmod(frame, frames_per_ten)
        if m > dropped_frames then
            frame = frame + (dropped_frames * 9 * d) +
                dropped_frames * math.floor((m - dropped_frames) / frames_per_minute)
        else
            frame = frame + dropped_frames * 9 * d
        end
    end

    local frame_count = math.fmod(frame, rounded_fps)
    local seconds = math.fmod(math.floor(frame / rounded_fps), 60)
    local minutes = math.fmod(math.floor(math.floor(frame / rounded_fps) / 60), 60)
    local hours = math.floor(math.floor(math.floor(frame / rounded_fps) / 60) / 60)

    local frame_chars = string.len(tostring(rounded_fps - 1))
    local frame_divider = ":"
    local interlace_divider = "."
    if is_drop_frame then
        frame_divider = ";"
        interlace_divider = ","
    end

    local format_string = "%02d:%02d:%02d" .. frame_divider .. "%0" .. frame_chars .. "d"
    if is_interlaced then
        local frame_mod = math.fmod(frame_count, 2)
        frame_count = math.floor(frame_count / 2)
        if frame_mod == 0 then
            format_string = format_string:gsub("(.*)" .. frame_divider,
                "%1" .. interlace_divider)
        end
    end

    return string.format(format_string, hours, minutes, seconds, frame_count)
end


local function TimelineUsesDropFrameTimecodes(timeline)
    return timeline:GetSetting("timelineDropFrameTimecode") == "1"
end


local function TimelineUsesInterlacedTimecodes(timeline)
    return timeline:GetSetting("timelineInterlaceProcessing") == "1"
end


local function GetTimelineInOutTimecodes(timeline_clip, is_drop_frame, is_interlaced)
    local in_out_set = true
    local in_timecode = timeline_clip:GetClipProperty("In")
    if in_timecode == "" then
        in_timecode = timeline_clip:GetClipProperty("Start TC")
        local frame_divider = ":"
        local interlace_divider = "."
        if is_drop_frame then
            frame_divider = ";"
            interlace_divider = ","
        end
        if is_interlaced then
            in_timecode = in_timecode:gsub("(.*)" .. frame_divider,
                "%1" .. interlace_divider)
        end
    end
    local out_timecode = timeline_clip:GetClipProperty("Out")
    if out_timecode == "" then
        out_timecode = timeline_clip:GetClipProperty("End TC")
    end

    return in_timecode, out_timecode
end


local function ToTitleCase(first, rest)
    return utf8.upper(first) .. utf8.lower(rest)
end


local function ApplyTextTransform(text, transform)
    if transform == "to lowercase" then
        return utf8.lower(text)
    elseif transform == "TO UPPERCASE" then
        return utf8.upper(text)
    elseif transform == "Capitalize All Words" then
        return utf8.gsub(text, "(%a)([%w_']*)", ToTitleCase)
    else
        return text
    end
end

local function removeAdvPunctuation(text, i)
    if i == 1 then
        return text:gsub("[.]", "")
    elseif i == 2 then
        return text:gsub('["]', "")
    elseif i == 3 then
        return text:gsub('[?]', "")
    elseif i == 4 then
        return text:gsub('[:]', "")
    elseif i == 5 then
        return text:gsub('[!]', "")
    elseif i == 6 then
        return text:gsub('[;]', "")
    elseif i == 7 then
        return text:gsub('[,]', "")
    elseif i == 8 then
        return text:gsub('[-]', "")
    end
end

local function GetSubtitleData(subtitle_track_index,
                               in_frame,
                               out_frame,
                               transform,
                               remove_punctuation,
                               punctuation_state,
                               remove_punctuation_tbl)
    local timeline = project:GetCurrentTimeline()
    local subtitle_clips = timeline:GetItemListInTrack("subtitle", subtitle_track_index)
    local subtitle_data = {}
    local index = 1

    for _, clip in ipairs(subtitle_clips) do
        if clip:GetEnd() <= in_frame or clip:GetStart() >= out_frame then
            goto continue
        end

        local start_frame = clip:GetStart()
        if start_frame < in_frame then
            start_frame = in_frame
        end

        local end_frame = clip:GetEnd()
        if end_frame > out_frame then
            end_frame = out_frame
        end

        subtitle_data[index] = {}
        subtitle_data[index]["start"] = start_frame
        subtitle_data[index]["end"] = end_frame
        subtitle_data[index]["duration"] = end_frame - start_frame

        local text = clip:GetName()
        text = ApplyTextTransform(text, transform)
        if punctuation_state == true then -- If "Advanced Settings" is Chosen, Run through Advanced
            for i, state in ipairs(remove_punctuation_tbl) do
                if state == "Checked" then
                    text = removeAdvPunctuation(text, i)
                end
            end
        else
            if remove_punctuation == 2 then
                text = text:gsub("[.!?,:;-]", "")
                text = text:gsub('["]', "")
            elseif remove_punctuation == 3 then
                text = text:gsub('[,]', "")
            elseif remove_punctuation == 4 then
                text = text:gsub('["]', "")
            elseif remove_punctuation == 5 then
                text = text:gsub("[.!?]", "")
            elseif remove_punctuation == 6 then
                text = text:gsub("[:;-]", "")
            end
        end


        -- Remove "invisible" UTF-8 line break
        text = text:gsub("\u{2028}", "\n")

        subtitle_data[index]["text"] = text

        index = index + 1

        ::continue::
    end

    return subtitle_data
end


local function CreateTextPlusClips(win, subtitle_data, template_index, video_track)
    if #subtitle_data == 0 then
        return true
    end

    local fill_gaps = win:Find("fill_gaps").Checked
    local max_fill = win:Find("max_fill").Value
    local text_clip = fusion_titles[template_index]

    -- First calculate a duration multiplier to ensure that any scaling triggered
    -- by the Fusion comp does not affect the length of the clip (too much...).
    local testClip = {}
    local testDuration = 100
    testClip["mediaPoolItem"] = text_clip
    testClip["startFrame"] = 0
    testClip["endFrame"] = testDuration - 1
    testClip["trackIndex"] = video_track
    testClip["recordFrame"] = subtitle_data[1]["start"]
    local testItem = mediaPool:AppendToTimeline({ testClip })[1]
    local testDurationReal = testItem:GetDuration()
    local timeline = project:GetCurrentTimeline()
    timeline:DeleteClips({ testItem }, false)
    local duration_multiplier = testDuration / testDurationReal

    for i, subtitle in ipairs(subtitle_data) do
        local newClip = {}
        newClip["mediaPoolItem"] = text_clip
        newClip["startFrame"] = 0
        newClip["endFrame"] = subtitle["duration"] - 1

        -- If filling gaps, check if there is a gap between this subtitle and
        -- the next one. If so, set the end of this subtitle to the start of
        -- the next one.
        if fill_gaps and i < #subtitle_data then
            local next_title = subtitle_data[i + 1]
            local gap_size = next_title["start"] - subtitle["end"]
            if gap_size > 0 and gap_size <= max_fill then
                newClip["endFrame"] = newClip["endFrame"] + gap_size
            end
        end

        -- Update based on the duration multiplier. This conteracts any
        -- modifications to the clip length triggered by the Fusion comp.
        local base_duration = newClip["endFrame"] - newClip["startFrame"] + 1
        local new_duration = base_duration * duration_multiplier + 0.999
        newClip["endFrame"] = new_duration - 1

        newClip["trackIndex"] = video_track
        newClip["recordFrame"] = subtitle["start"]

        local timelineItem = mediaPool:AppendToTimeline({ newClip })[1]
        timelineItem:SetClipColor("Green")

        if timelineItem:GetFusionCompCount() == 0 then
            local dialog = CreateDialog("🛑 Uh Oh!",
                "No Fusion Based Caption Template Selected",
                noFusionCompInTemplate)
            -- dialog:Show()
            -- dialog:RecalcLayout()
            return false
        end

        local comp = timelineItem:GetFusionCompByIndex(1)

        -- Check that the TextPlus tool exists in the comp.
        local text_plus_tools = comp:GetToolList(false, "TextPlus")
        if #text_plus_tools == 0 then
            local dialog = CreateDialog("🛑 Uh Oh!",
                "Non-Text+ Effects Are Not Compatible With Snap Captions",
                noTextPlusInTemplate)
            -- dialog:Show()
            -- dialog:RecalcLayout()
            return false
        end

        text_plus_tools[1]:SetInput("StyledText", subtitle["text"])
        app:Sleep(0.005)
        win:Repaint()
    end

    return true
end


local function GenerateTextPlus(win)
    -- Get the selected subtitle track.
    local subtitle_track_index = win:Find("subtitle_tracks").CurrentIndex + 1
    if subtitle_track_index == 0 then
        local dialog = CreateDialog("🛑 Woah!",
            "I need A Subtitle Track Before I Can Create Captions!",
            noSubtitleTrack)
        -- dialog:Show()
        -- dialog:RecalcLayout()
        return false
    end

    local text_template_index = win:Find("title_templates").CurrentIndex + 1
    if text_template_index == 0 then
        -- local dialog = CreateDialog("No Text+ Template",
        --                             "Please add a Text+ template to the Media Pool in a bin named '" .. TEXT_TEMPLATE_FOLDER .. "' and try again.",
        --                             "https://bit.ly/4dihVvd")
        -- dialog:Show()
        -- dialog:RecalcLayout()
        OpenURL(noTemplates)
        return false
    end

    local timeline = project:GetCurrentTimeline()
    local is_interlaced = TimelineUsesInterlacedTimecodes(timeline)
    local is_drop_frame = TimelineUsesDropFrameTimecodes(timeline)
    local timeline_clip = GetTimelineClipFromMediaPool(timeline:GetName())
    local in_timecode, out_timecode =
        GetTimelineInOutTimecodes(timeline_clip, is_drop_frame, is_interlaced)
    local fps = timeline_clip:GetClipProperty("FPS")
    local in_frame = ConvertTimecodeToFrame(in_timecode, fps, is_drop_frame, is_interlaced)
    local out_frame = ConvertTimecodeToFrame(out_timecode, fps, is_drop_frame, is_interlaced)

    local transform = win:Find("text_transform").CurrentText
    local punctuation_state = false
    if win:Find("remove_punctuation").CurrentIndex == 1 then
        punctuation_state = true
    else

    end
    local remove_punctuation = win:Find("remove_punctuation").CurrentIndex
    local remove_punctuation_tbl = {
        win:Find("remove_periods").CheckState,
        win:Find("remove_quotes").CheckState,
        win:Find("remove_question").CheckState,
        win:Find("remove_colon").CheckState,
        win:Find("remove_exclaim").CheckState,
        win:Find("remove_semicolon").CheckState,
        win:Find("remove_commas").CheckState,
        win:Find("remove_dashes").CheckState
    }
    local subtitle_data = GetSubtitleData(subtitle_track_index,
        in_frame,
        out_frame,
        transform,
        remove_punctuation,
        punctuation_state,
        remove_punctuation_tbl)

    -- Create a new video track.
    local track_created = timeline:AddTrack("video")
    if not track_created then
        local dialog = CreateDialog("🛑 Uh Oh!",
            "🙀 Snap Captions Can't Add a New Video Track On Your Resolve Timeline.",
            AddTrackFailed)
        -- dialog:Show()
        -- dialog:RecalcLayout()
        return false
    end

    local track_count = timeline:GetTrackCount("video")

    local success = CreateTextPlusClips(win, subtitle_data, text_template_index, track_count)
    if not success then
        -- Delete the added track.
        timeline:DeleteTrack("video", track_count)
    else
        timeline:SetTrackEnable("subtitle", subtitle_track_index, false)
    end

    -- Reset the In/Out points.
    local timeline_clip = GetTimelineClipFromMediaPool(timeline:GetName())
    if timeline_clip:GetClipProperty("In") ~= "" or
        timeline_clip:GetClipProperty("Out") ~= "" then
        -- Note: SetClipProperty does not correctly handle interlaced timecodes.
        timeline_clip:SetClipProperty("In",
            ConvertFrameToTimecode(in_frame + 1, fps, is_drop_frame, false))
        if is_interlaced then
            in_timecode = ConvertFrameToTimecode(in_frame, fps, is_drop_frame, false)
        end
        timeline_clip:SetClipProperty("In", in_timecode)
    end

    return success
end

local function addBin(win)
    local win = ui:FindWindow(winID)
    noPackInstalled = true
    local maxRetries = 30 -- Maximum attempts (30 x 100ms = 3 seconds)
    local retryCount = 0
    local checkTimer = ui:Timer {
        ID = "CheckTimerAddBin",
        Interval = 300,    -- checks 10x per second
        SingleShot = false -- keeps firing until we manually stop
    }

    checkTimer:Start()

    function disp.On.Timeout(ev)
        if ev.who == checkTimer.ID then
            retryCount = retryCount + 1
            local foundTemplate = false
            for _, subfolder in ipairs(mediaPool:GetRootFolder():GetSubFolderList()) do
                if subfolder:GetName() == TEXT_TEMPLATE_FOLDER then
                    template_folder = subfolder
                    noPackInstalled = false
                    foundTemplate = true
                    break
                end
            end

            if foundTemplate then
                checkTimer:Stop() -- Stop checking once found
            elseif retryCount >= maxRetries then
                checkTimer:Stop() -- Stop checking if max retries reached
                noPackInstalled = true
            end
        end
    end

    if noPackInstalled then
        local selecteditm
        local selPack = win:Find('Packs').CurrentIndex + 1
        if not packs[selPack] then
            selecteditm = win:Find('PackList'):CurrentItem()
            selPack = win:Find('PackList'):IndexOfTopLevelItem(selecteditm)
        end

        if selPack ~= 0 then
            packPath = listFiles(packs[selPack].FullPath)[1]
        else
            local masterBin = app:GetResolve():GetProjectManager():GetCurrentProject():GetMediaPool():GetRootFolder()
            if masterBin then
                app:GetResolve():GetProjectManager():GetCurrentProject():GetMediaPool():AddSubFolder(masterBin,
                    'Snap Captions')
            end
            PopulateTextTemplates(win)
            return
        end

        local function installBin(filePath)
            local isWindows = package.config:sub(1, 1) == '\\'
            local command = isWindows and ('cmd.exe /c start "" "' .. filePath .. '"') or ('open "' .. filePath .. '"')

            local result = os.execute(command)
            if not result then
                error("File execution failed.")
            end
            print(result)
        end

        local masterBin = app:GetResolve():GetProjectManager():GetCurrentProject():GetMediaPool():GetRootFolder()
        app:GetResolve():GetProjectManager():GetCurrentProject():GetMediaPool():SetCurrentFolder(masterBin)

        installBin(packPath)
        template_folder = nil
        local maxRetriesBin = 60 -- Maximum attempts (60 x 500ms = 30 seconds)
        local retryCountBin = 0
        local checkTimerBin = ui:Timer {
            ID = "CheckTimerBin",
            Interval = 500,    -- checks every 0.5 seconds
            SingleShot = false -- keeps firing until we manually stop
        }

        checkTimerBin:Start()

        function disp.On.Timeout(ev)
            if ev.who == checkTimerBin.ID then
                retryCountBin = retryCountBin + 1
                for _, subfolder in ipairs(mediaPool:GetRootFolder():GetSubFolderList()) do
                    if subfolder:GetName() == TEXT_TEMPLATE_FOLDER then
                        template_folder = subfolder
                        checkTimerBin:Stop()       -- Stop checking once found
                        PopulateTextTemplates(win) -- Populate the templates
                        return
                    end
                end

                if retryCountBin >= maxRetriesBin then
                    checkTimerBin:Stop() -- Stop checking after max retries
                    print("Error: " .. TEXT_TEMPLATE_FOLDER .. " not found after multiple attempts.")
                end
            end
        end
    end
    PopulateTextTemplates(win)
end

local function CreateToolWindow()
    local win = disp:AddWindow(
        {
            ID = winID,
            WindowTitle = "Snap Captions " .. ver,
            FixedSize = { WINDOW_WIDTH, WINDOW_HEIGHT },
            Margin = 16,

            ui:VGroup {
                Spacing = 0,
                ID = "Base",
                ui:VGroup {
                    Weight = 0,
                    ID = "install_bar",
                    Spacing = 0
                },
                ui:VGroup {
                    ID = 'Modal',
                    Hidden = true,
                    Weight = 1,
                    -- StyleSheet = [[
                    --     background-color: "black";
                    -- ]],
                    -- FixedSize = { 300, 150 },
                    ui:Label {
                        ID = "error_title",
                        Text = "title",
                        Alignment = { AlignHCenter = true, AlignBottom = true },
                        WordWrap = true,
                        StyleSheet = [[
                            QLabel {
                                color: rgb(255, 255, 255);
                                font-size: 13px;
                                font-weight: bold;
                                text-align: center;
                            }
                        ]]
                    },
                    ui:Label {
                        Weight = 1,
                        -- FixedSize = { 300, 35 },
                        ID = "error_message",
                        Text = "message",
                        WordWrap = true,
                        Alignment = { AlignHCenter = true, AlignTop = true },
                        StyleSheet = [[
                            QLabel {
                                text-align:center;
                            }
                        ]]
                    },
                    ui:VGap(0, 0.5),
                    ui:TextEdit {
                        Weight = 0,
                        -- FixedSize = { 300, 25 },
                        ID = "LINK",
                        HTML = "",
                        WordWrap = true,
                        Alignment = { AlignHCenter = true, AlignVCenter = true },
                        ReadOnly = true,
                        Events = { AnchorClicked = true },
                        FrameStyle = 0,
                    },
                    ui:VGap(0, 0.5),
                    ui:HGroup {
                        Weight = 0,
                        ui:Button { ID = "Delete",
                            Text = "Delete",
                            Hidden = true,
                            StyleSheet = SECONDARY_ACTION_BUTTON_CSS
                        }
                    },
                    ui:HGroup {
                        Weight = 0,
                        ui:Button { ID = "OK",
                            Text = "OK",
                            StyleSheet = SECONDARY_ACTION_BUTTON_CSS
                        }
                    }
                },
                ui:HGroup {
                    Weight = 0,
                    ui:HGroup {
                        Weight = 1,
                        ui:Label { Weight = 0, Text = "Snap", StyleSheet = START_LOGO_CSS, Alignment = { AlignCenter = true }, Margin = -1.75 },
                        ui:Label { Weight = 0, Text = "Captions", StyleSheet = END_LOGO_CSS, Alignment = { AlignCenter = true }, Margin = -1.75 },
                    },
                    ui:TabBar { ID = "MainTabs", DocumentMode = false, DrawBase = false, UsesScrollButtons = true, Expanding = false, Weight = 0, AutoHide = false },
                },
                ui:Label {
                    Weight = 0,
                    FrameStyle = 4,
                    StyleSheet = TITLE_DIV_CSS
                },
                ui:Stack {
                    ID = 'MainStack',
                    CurrentIndex = 0,
                    ui:VGroup {
                        ID = "root",
                        Spacing = 0,
                        ui:Label {
                            Text = "Source Subtitle Track",
                            StyleSheet = SECTION_TITLE_CSS,
                        },
                        ui:VGap(8, 0),
                        ui:HGroup {
                            Spacing = 0,
                            ID = "subtitle_track_group",
                            ui:Stack {
                                ID = "subtitle_stack",
                                CurrentIndex = 0,
                                ui:ComboBox {
                                    ID = "subtitle_tracks",
                                    MinimumSize = { 10, 26 }
                                },
                                ui:Label {
                                    ID = "subtitle_placeholder",
                                    Visible = false,
                                    Text = "No subtitle tracks found",
                                    StyleSheet = COMBOBOX_PLACEHOLDER_CSS
                                },
                                ui:Label {
                                    ID = "subtitle_placeholder2",
                                    Visible = false,
                                    Text = "No timeline open",
                                    StyleSheet = COMBOBOX_PLACEHOLDER_CSS
                                }
                            },
                            ui:Button {
                                ID = "refresh_subtitle_tracks",
                                Text = "↺",
                                ToolTip = "Refresh Subtitle Track List",
                                StyleSheet = COMBOBOX_ACTION_BUTTON_CSS
                            }
                        },
                        ui:VGap(16, 0),
                        ui:Label {
                            Text = "Text+ Template",
                            StyleSheet = SECTION_TITLE_CSS,
                        },
                        ui:VGap(8, 0),
                        ui:HGroup {
                            Spacing = 0,
                            ui:Stack {
                                ID = "title_stack",
                                CurrentIndex = 0,
                                ui:ComboBox {
                                    ID = "title_templates",
                                    MinimumSize = { 10, 26 }
                                },
                                ui:Label {
                                    ID = "title_placeholder",
                                    Visible = false,
                                    Text = "No '" .. TEXT_TEMPLATE_FOLDER .. "' Bin Found",
                                    ToolTip = "<qt>Add Text+ templates to the Media Pool in a Bin named '" .. TEXT_TEMPLATE_FOLDER .. "'</qt>",
                                    StyleSheet = COMBOBOX_PLACEHOLDER_CSS
                                }
                            },
                            ui:Button {
                                ID = "refresh_text_templates",
                                Text = "↺",
                                ToolTip = "Refresh Text+ Template List",
                                StyleSheet = COMBOBOX_ACTION_BUTTON_CSS
                            }
                        },
                        ui:VGap(16, 0),
                        ui:Label {
                            FrameStyle = 4,
                            StyleSheet = DIVIDER_CSS
                        },
                        ui:HGroup {
                            ui:Label {
                                Text = "Customization",
                                StyleSheet = SECTION_TITLE_CSS,
                            },
                        },
                        ui:VGap(8, 0),
                        ui:HGroup {
                            ui:Label {
                                Text = "Presets",
                                StyleSheet = SECTION_TITLE_CSS,
                                Weight = 0
                            },
                            ui:ComboBox { ID = "SavePreset",
                                Weight = 1, Editable = true },
                            ui:Button { ID = "save_settings",
                                Text = "Save", Weight = 0,
                                MaximumSize = { 70, 30 }, MinimumSize = { 40, 25 }, },
                        },
                        ui:VGap(8, 0),
                        ui:HGroup {
                            Spacing = 8,
                            ui:Label { Text = "Case Conversion",
                                MinimumSize = { COLUMN_WIDTH, 0 },
                                MaximumSize = { COLUMN_WIDTH, 1000 },
                                Alignment = { AlignRight = true, AlignVCenter = true } },
                            ui:ComboBox { ID = "text_transform",
                                MinimumSize = { 10, 26 } }
                        },
                        ui:VGap(8, 0),
                        ui:HGroup {
                            ID = "PunctuationSimple",
                            Spacing = 8,
                            ui:Label { Text = "Remove Punctuation",
                                MinimumSize = { COLUMN_WIDTH, 0 },
                                MaximumSize = { COLUMN_WIDTH, 1000 },
                                Weight = 0.15,
                                Alignment = { AlignRight = true, AlignVCenter = true } },
                            ui:HGroup {
                                Weight = 0.85,
                                ui:ComboBox { ID = "remove_punctuation",
                                    Weight = 0 },
                                ui:Button { ID = "Advanced",
                                    Weight = 0,
                                    Text = "Advanced" }
                            },
                        },
                        ui:HGroup {
                            ID = "PunctuationAdvanced",
                            Hidden = true,
                            Spacing = 8,
                            ui:HGroup {
                                ui:VGroup {
                                    ui:CheckBox { ID = "remove_periods",
                                        Weight = 0,
                                        Text = "Remove Periods",
                                        Events = { Toggled = true }
                                    },
                                    ui:CheckBox { ID = "remove_quotes",
                                        Weight = 0,
                                        Text = "Remove Quotes",
                                        Events = { Toggled = true }
                                    },
                                },
                                ui:VGroup {
                                    ui:CheckBox { ID = "remove_question",
                                        Weight = 0,
                                        Text = "Remove Questions",
                                        Events = { Toggled = true }
                                    },
                                    ui:CheckBox { ID = "remove_colon",
                                        Weight = 0,
                                        Text = "Remove Colons",
                                        Events = { Toggled = true }
                                    },
                                },
                                ui:VGroup {
                                    ui:CheckBox { ID = "remove_exclaim",
                                        Weight = 0,
                                        Text = "Remove Exclamations",
                                        Events = { Toggled = true }
                                    },
                                    ui:CheckBox { ID = "remove_semicolon",
                                        Weight = 0,
                                        Text = "Remove Semicolons",
                                        Events = { Toggled = true }
                                    },
                                },
                                ui:VGroup {
                                    ui:CheckBox { ID = "remove_commas",
                                        Weight = 0,
                                        Text = "Remove Commas",
                                        Events = { Toggled = true }
                                    },
                                    ui:CheckBox { ID = "remove_dashes",
                                        Weight = 0,
                                        Text = "Remove Dashes",
                                        Events = { Toggled = true }
                                    },
                                }
                            },
                            ui:Button { ID = "Simple",
                                Weight = 0,
                                Text = "Simple" }
                        },
                        ui:VGap(8, 0),
                        ui:HGroup {
                            Spacing = 8,
                            ui:HGroup {
                                ui:HGap(0, 1.5),
                                ui:Label { Text = "Fill Gaps",
                                    Alignment = { AlignRight = true, AlignVCenter = true } },
                                ui:CheckBox { ID = "fill_gaps",
                                    Checked = true,
                                    Events = { Toggled = true } },
                            },
                            ui:HGroup {
                                ui:HGap(0, 1.5),
                                Weight = 1,
                                ID = "max_fill_group",
                                Enabled = true,
                                ui:Label { Text = "Max Fill",
                                    Alignment = { AlignVCenter = true },
                                    Weight = 0 },
                                ui.SpinBox { ID = "max_fill",
                                    Suffix = " Frames",
                                    Minimum = 1,
                                    Maximum = 9999,
                                    Value = 10,
                                    Weight = 1,
                                    FixedSize = { 100, 26 } }
                            }
                        },
                        ui:VGap(16, 10),
                        ui:Label {
                            FrameStyle = 4,
                            StyleSheet = DIVIDER_CSS
                        },
                        ui:VGap(4, 0),
                        ui:HGroup {
                            Weight = 0.5,
                            ui:Button { ID = "process",
                                Text = "CREATE CAPTIONS",
                                StyleSheet = PRIMARY_ACTION_BUTTON_CSS
                            }
                        },
                        ui:VGap(12, 0),
                        ui:HGroup {
                            ui:Button { ID = "tutorial_cta",
                                Text = "Master the Tool",
                                StyleSheet = SECONDARY_ACTION_BUTTON_CSS },
                            ui:Button { ID = "donate_cta",
                                Text = "Donate",
                                StyleSheet = SECONDARY_ACTION_BUTTON_CSS },
                        }
                    },
                    ui:VGroup {
                        ID = "Library",
                        Spacing = 0,
                        FixedX = WINDOW_WIDTH,
                        FixedY = WINDOW_HEIGHT + 50,
                        ui:VGroup {
                            ID = "mainLabels",
                            Weight = 0,
                            Alignment = { AlignCenter = true },
                            ui:Label { Text = "YOUR LIBRARY", Alignment = { AlignCenter = true }, Weight = 0, StyleSheet = TITLE_CSS }
                        },
                        ui:HGroup {
                            Weight = 0,
                            ui:Button { ID = "tutorial", Text = "Tutorial", Weight = 0.5 },
                            ui:Button { ID = "add_Captions", Text = "Add to Your Library", Weight = 0.5 },
                        },
                        ui:VGroup {
                            ID = 'installedPackImport',
                            ui:VGroup {
                                ID = "installedPacks",
                                ui:Tree { ID = "PackList", AlternatingRowColors = true, RootIsDecorated = false, Events = { ItemChanged = true }, Alignment = { AlignCenter = true } }
                            },
                            ui:Button { ID = "AddPack", Text = "USE SELECTED PACK", Weight = 0.5, StyleSheet = PRIMARY_ACTION_BUTTON_CSS }
                        }
                    },
                    ui:VGroup {
                        ID = "Settings",
                        ui:VGap(8, 0),
                        ui:HGroup {
                            Weight = 0,
                            ui:Label {
                                Text = "Customization Presets",
                                StyleSheet = SECTION_TITLE_CSS,
                            },
                        },
                        ui:HGroup {
                            Weight = 0,
                            ui:ComboBox { ID = "SavePresetUPDATES",
                                Weight = 1 },
                            ui:Button { ID = "default_settings",
                                Text = "Set Default", Weight = 0, MinimumSize = { 80, 25 }, },
                            ui:Button { ID = "remove_settings",
                                Text = "Delete", Weight = 0, MinimumSize = { 80, 25 }, },
                        },
                        ui:HGroup {
                            Weight = 0,
                            ui:Button { ID = "export_settings",
                                Text = "Export" },
                            ui:Button { ID = "import_settings",
                                Text = "Import" },
                        },
                        ui:VGap(8, 0),
                        ui:Label {
                            FrameStyle = 4,
                            StyleSheet = TITLE_DIV_CSS
                        },
                        ui:HGroup {
                            Weight = 0,
                            ui:Label {
                                Text = "Library Management",
                                StyleSheet = SECTION_TITLE_CSS,
                            },
                        },
                        ui:HGroup {
                            Weight = 0,
                            ui:ComboBox { ID = "Packs",
                                Weight = 1 },
                            ui:Button { ID = "delete_pack",
                                Text = "Delete", Weight = 0, MinimumSize = { 80, 25 }, },
                            ui:Button { ID = "add_Captions",
                                Text = "Install", Weight = 0, MinimumSize = { 80, 25 }, },
                        },
                        ui:Button { ID = "import_pack",
                            Text = "Add Pack to Project",
                            Weight = 0 },
                        ui:VGap(8, 0),
                        ui:Label {
                            FrameStyle = 4,
                            StyleSheet = TITLE_DIV_CSS
                        },
                        ui:HGroup {
                            Weight = 0,
                            ui:Label {
                                Text = "Extra Settings",
                                StyleSheet = SECTION_TITLE_CSS,
                            },
                        },
                        ui:HGroup {
                            Weight = 0,
                            Alignment = { AlignCenter = true },
                            ui:Label {
                                FrameStyle = 4,
                                Weight = 0.5,
                            },
                            ui:Label { Text = "Close Window When Finished Creating",
                                Weight = 0
                            },
                            ui:CheckBox { ID = "close_window",
                                Weight = 0,
                                CheckState = app:GetData("SnapCaptions.Settings.CloseonFinish") or "Unchecked"
                            },
                            ui:Label {
                                FrameStyle = 4,
                                Weight = 0.5,
                            },
                        },
                        ui:VGap(8, 0),
                        ui:Label {
                            FrameStyle = 4,
                            StyleSheet = TITLE_DIV_CSS
                        },
                        ui:HGroup {
                            Weight = 0,
                            Alignment = { AlignCenter = true },
                            ui:Button {
                                ID = "RequestFeature",
                                Alignment = { AlignCenter = true },
                                Text = "Want a feature? Let us know!",
                                StyleSheet = FLAT_CSS,
                                Flat = true,
                            },
                        },
                        ui:Label {
                            Weight = 1,
                        },
                    }
                },
                -- ui:Group {
                --     ui:TextEdit { ID = 'EasterEgg', HTML = "<center><img src='" .. hiddenIMGB64 .. "'>", Geometry = { (WINDOW_WIDTH / 2) - 16, 40, 110, 200 }, ReadOnly = true, FrameStyle = 0 },
                --     ui:TextEdit { ID = 'EasterEgg2', HTML = "<center><img src='" .. hiddenLogoIMG .. "'>", Geometry = { (WINDOW_WIDTH / 2) - 16, 300, 125, 200 }, ReadOnly = true, FrameStyle = 0, Hidden = true },
                --     ui:Label { ID = "HiddenTxt", Text = "Updates By Asher Roland", Geometry = { (WINDOW_WIDTH / 2) - 45, 275, 175, 50 }, StyleSheet = SECTION_TITLE_CSS, Hidden = true, Alignment = { AlignCenter = true } },
                --     ui:CheckBox { ID = "Secret", Text = "?", Geometry = { (WINDOW_WIDTH / 2) + 20, 250, 50, 50 }, Events = { Toggled = true } },
                -- },
            }
        })

    function win.On.Delete.Clicked(ev)
        template_folder = nil
        for _, subfolder in ipairs(mediaPool:GetRootFolder():GetSubFolderList()) do
            if subfolder:GetName() == TEXT_TEMPLATE_FOLDER then
                template_folder = subfolder
                break
            end
        end
        mediaPool:DeleteFolders({ template_folder })
        hideModal()
        addBin(win)
    end

    function win.On.LINK.AnchorClicked(ev)
        bmd.openurl(ev.URL)
    end

    function win.On.OK.Clicked(ev)
        hideModal()
    end

    PopulateSubtitleTracks(win)
    PopulateTextTemplates(win)
    PopulateTextTransforms(win)
    PopulatePunctuationStyles(win)

    win:Find('PackList'):SetHeaderLabels({ "Pack Name" })

    function PopulateLibrary(installedPacks)
        local winItms = win:GetItems()
        _G.packs = {}
        winItms.PackList:Clear()
        local itrow1 = winItms.PackList:NewItem()
        itrow1.Text[0] = "Create Empty Folder (BYO Templates 🍺)"
        -- itrow1.CheckState[0] = true and "Checked" or "Unchecked"
        winItms.PackList:AddTopLevelItem(itrow1)
        selectedInstalled = winItms.PackList:ItemAt(0)
        if installedPacks then
            for i, folder in ipairs(installedPacks) do
                local itrow2 = winItms.PackList:NewItem()
                local packName = parseFilename(folder).FullName
                itrow2.Text[0] = packName
                -- itrow2.CheckState[0] = false and "Checked" or "Unchecked"
                winItms.PackList:AddTopLevelItem(itrow2)
                table.insert(packs, parseFilename(folder))
            end
        end
    end

    local function drbToLib()
        local drbPath = app:MapPath(app:RequestFile(
            '',
            "",
            {
                FReqB_Saving = false,
                FReqB_SeqGather = false,
                FReqS_Filter = 'DRB File (*.drb)|*.drb',
                FReqS_Title = 'Choose the drb file'
            }
        ))
        if drbPath then
            drbPath = parseFilename(drbPath)
            if bmd.fileexists(drbPath.FullPath) then
                local fileName = drbPath.FullPath:match("^.+[\\/](.+)$") or drbPath.FullPath
                local lowerFile = string.lower(fileName)
                -- Updated pattern: removed the hyphen
                if lowerFile:match("^snap captions .*%.drb$") then
                    CopyDRB(drbPath.FullPath,
                        installFolder .. "/" .. extractSnapCaptions(drbPath.Name) .. "/" .. drbPath.FullName)
                    local installedPacks = mediaStorage:GetSubFolderList(installFolder)
                    PopulateLibrary(installedPacks)
                    PopulateInstalledPacks(installedPacks)
                end
            end
        end
    end

    function win.On.AddPack.Clicked(ev)
        -- First, check if the Snap Captions Bin is already installed.
        template_folder = nil
        for _, subfolder in ipairs(mediaPool:GetRootFolder():GetSubFolderList()) do
            if subfolder:GetName() == TEXT_TEMPLATE_FOLDER then
                template_folder = subfolder
                break
            end
        end

        -- Define the common installation procedure as a local function.
        local function startInstallation()
            local selecteditm = win:Find('PackList'):CurrentItem()
            local selPack = win:Find('PackList'):IndexOfTopLevelItem(selecteditm)
            local packPath
            if selPack ~= 0 then
                packPath = listFiles(packs[selPack].FullPath)[1]
            else
                local masterBin = app:GetResolve():GetProjectManager():GetCurrentProject():GetMediaPool():GetRootFolder()
                if masterBin then
                    app:GetResolve():GetProjectManager():GetCurrentProject():GetMediaPool():AddSubFolder(masterBin,
                        'Snap Captions')
                end
                return
            end

            local function installBin(filePath)
                local isWindows = package.config:sub(1, 1) == '\\'
                local command = isWindows and ('cmd.exe /c start "" "' .. filePath .. '"')
                    or ('open "' .. filePath .. '"')
                local result = os.execute(command)
                if not result then
                    error("File execution failed.")
                end
                print(result)
            end

            local masterBin = app:GetResolve():GetProjectManager():GetCurrentProject():GetMediaPool():GetRootFolder()
            app:GetResolve():GetProjectManager():GetCurrentProject():GetMediaPool():SetCurrentFolder(masterBin)

            installBin(packPath)
            template_folder = nil

            -- Create a timer to check every 0.5 seconds whether the bin folder appears.
            local installRetries = 0
            local maxInstallRetries = 60 -- 60 x 0.5 sec = 30 seconds max
            local installTimer = ui:Timer {
                ID = "InstallTimer",
                Interval = 500, -- check every 500ms
                SingleShot = false,
                OnTimeout = function(self)
                    installRetries = installRetries + 1
                    local found = false
                    for _, subfolder in ipairs(mediaPool:GetRootFolder():GetSubFolderList()) do
                        if subfolder:GetName() == TEXT_TEMPLATE_FOLDER then
                            template_folder = subfolder
                            found = true
                            break
                        end
                    end

                    if found then
                        self:Stop() -- Stop the timer when found.
                        PopulateTextTemplates(win)
                    elseif installRetries >= maxInstallRetries then
                        self:Stop()
                        print("Error: " .. TEXT_TEMPLATE_FOLDER .. " not found after multiple attempts.")
                    end
                end
            }
            installTimer:Start()
        end

        -- If a bin already exists, ask if we should delete it and then wait for its removal.
        if template_folder then
            local dialog = CreateDialog("🛑 Oh No!",
                "There’s already a Snap Captions Bin installed, Want me to delete it?", nil, false, true)
            -- (If you need to show and/or process the dialog further, insert that code here.)
            -- Assume that the deletion is triggered (for example, by the dialog) and that
            -- the bin folder will eventually be removed.
            template_folder = nil

            local removeRetries = 0
            local maxRemoveRetries = 60 -- 60 x 0.5 sec = 30 seconds max
            local removeTimer = ui:Timer {
                ID = "RemoveTimer",
                Interval = 500, -- check every 500ms
                SingleShot = false,
                OnTimeout = function(self)
                    removeRetries = removeRetries + 1
                    local found = false
                    for _, subfolder in ipairs(mediaPool:GetRootFolder():GetSubFolderList()) do
                        if subfolder:GetName() == TEXT_TEMPLATE_FOLDER then
                            found = true
                            break
                        end
                    end

                    if not found then
                        self:Stop() -- Stop waiting when the folder is gone.
                        -- Now that the old bin is gone, proceed to install the new one.
                        startInstallation()
                    elseif removeRetries >= maxRemoveRetries then
                        self:Stop()
                        print("Error: " .. TEXT_TEMPLATE_FOLDER .. " still exists after deletion attempt.")
                    end
                end
            }
            removeTimer:Start()
        else
            -- If no bin is installed, go straight to installation.
            startInstallation()
            PopulateTextTemplates(win)
        end
    end

    function PopulateInstalledPacks(installedPacks)
        win:Find('Packs'):Clear()
        _G.packs = {}
        for _, pack in ipairs(installedPacks) do
            local packName = parseFilename(pack).FullName
            win:Find('Packs'):AddItem(packName)
            table.insert(packs, parseFilename(pack))
        end
    end

    function win.On.import_pack.Clicked(ev)
        template_folder = nil
        for _, subfolder in ipairs(mediaPool:GetRootFolder():GetSubFolderList()) do
            if subfolder:GetName() == TEXT_TEMPLATE_FOLDER then
                template_folder = subfolder
                break
            end
        end
        if template_folder then
            local dialog = CreateDialog("🛑 Oh No!",
                "There’s already a Snap Captions Bin installed, Want me to delete it?", nil, false, true)
            -- dialog:RecalcLayout()
            --     dialog:Show()
            template_folder = nil
            while true do
                bmd.wait(0.5)
                for _, subfolder in ipairs(mediaPool:GetRootFolder():GetSubFolderList()) do
                    if subfolder:GetName() == TEXT_TEMPLATE_FOLDER then
                        template_folder = subfolder
                        noPackInstalled = false
                        return
                    end
                end
                if not template_folder then
                    noPackInstalled = true
                    break
                end
            end
        else
            noPackInstalled = true
        end

        if noPackInstalled then
            local selPack = win:Find('Packs').CurrentIndex + 1

            local packPath = listFiles(packs[selPack].FullPath)[1]
            local function installBin(filePath)
                -- Determine the operating system
                local isWindows = package.config:sub(1, 1) == '\\'

                -- Prepare the command based on the OS
                local command
                if isWindows then
                    -- For Windows
                    command = 'cmd.exe /c start "" "' .. filePath .. '"'
                else
                    -- For Unix/Linux/Mac
                    command = 'open "' .. filePath .. '"'
                end

                -- Execute the command
                local result = os.execute(command)

                -- Check the result
                if not result then
                    error("File execution failed.")
                end
                print(result)
            end

            local masterBin = app:GetResolve():GetProjectManager():GetCurrentProject():GetMediaPool():GetRootFolder()
            app:GetResolve():GetProjectManager():GetCurrentProject():GetMediaPool():SetCurrentFolder(masterBin)

            installBin(packPath)
            template_folder = nil
            while true do
                bmd.wait(0.5)
                for _, subfolder in ipairs(mediaPool:GetRootFolder():GetSubFolderList()) do
                    if subfolder:GetName() == TEXT_TEMPLATE_FOLDER then
                        template_folder = subfolder
                        break
                    end
                end
                if template_folder then
                    PopulateTextTemplates(win)
                    break
                end
            end
        end
        -- end
    end

    function win.On.add_Captions.Clicked(ev)
        drbToLib()
    end

    local function deletePack(packFolder)
        if packFolder then
            for _, pack in ipairs(packs) do
                if pack.FullName == packFolder then
                    if bmd.direxists(pack.FullPath) then
                        local drbFile = listFiles(pack.FullPath)[1]
                        if drbFile and bmd.fileexists(drbFile) then
                            os.remove(drbFile)
                        end
                        bmd.removedir(pack.FullPath)
                        break
                    end
                end
            end
        end
        local installedPacks = mediaStorage:GetSubFolderList(installFolder)
        PopulateInstalledPacks(installedPacks)
    end

    -- function win.On.Secret.Toggled(ev)
    --     if win:Find('Secret').CheckState == "Checked" then
    --         win:Find('EasterEgg2').Hidden = false
    --         win:Find('HiddenTxt').Hidden = false
    --         win:RecalcLayout()
    --     else
    --         win:Find('EasterEgg2').Hidden = true
    --         win:Find('HiddenTxt').Hidden = true
    --         win:RecalcLayout()
    --     end
    -- end

    function win.On.tutorial_cta.Clicked(ev)
        OpenURL(HUB_URL)
    end

    function win.On.donate_cta.Clicked(ev)
        OpenURL(DONATE_URL)
    end

    function win.On.RequestFeature.Clicked(ev)
        OpenURL(REQUEST_URL)
    end

    function win.On.tutorial.Clicked(ev)
        OpenURL(PackMangagerTUT)
    end

    function win.On.remove_settings.Clicked(ev)
        local presetName = win:Find('SavePresetUPDATES').CurrentText
        app:SetData("SnapCaptions.Presets." .. presetName)

        local presetOrder = app:GetData("SnapCaptions.PresetOrder")
        for index, Name in ipairs(presetOrder) do
            if Name == presetName then
                table.remove(presetOrder, index)
            end
        end
        app:SetData("SnapCaptions.PresetOrder", presetOrder)

        fillCustomPresetsSETTINGS()
    end

    function win.On.export_settings.Clicked(ev)
        local presetName = win:Find('SavePresetUPDATES').CurrentText
        local preset = app:GetData("SnapCaptions.Presets." .. presetName)
        local path = app:MapPath(app:RequestFile(
            '',
            presetName .. ".txt",
            {
                FReqB_Saving = true,
                FReqB_SeqGather = false,
            }
        ))
        if path then
            local exportFile = io.open(path, "w")
            if exportFile then
                exportFile:write(bmd.writestring(preset))
                exportFile:close()
            else
                error("THERE WAS AN ISSUE SAVING PRESET")
            end
        end
    end

    function win.On.import_settings.Clicked(ev)
        local path = app:MapPath(app:RequestFile(
            '',
            "",
            {
                FReqB_Saving = false,
                FReqB_SeqGather = false,
            }
        ))
        if path then
            if not bmd.fileexists(path) then
                error("THERE WAS AN ISSUE GETTING YOUR PRESET")
            else
                local file = parseFilename(path)
                local preset = bmd.readfile(path)
                app:SetData("SnapCaptions.Presets." .. file.Name, preset)

                local presetOrder = app:GetData("SnapCaptions.PresetOrder")
                table.insert(presetOrder, presetName)
                app:SetData("SnapCaptions.PresetOrder", presetOrder)
                fillCustomPresetsSETTINGS()
            end
        end
    end

    if not app:GetData("SnapCaptions.Presets") then
        local PresetOrder = { "Default", "Orson's Favourite" }
        presetName = "Default"
        app:SetData("SnapCaptions.Presets." .. presetName .. ".CaseConversion", 0)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".RemovePunctuation", 0)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_periods", "Unchecked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_quotes", "Unchecked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_question", "Unchecked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_colon", "Unchecked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_exclaim", "Unchecked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_semicolon", "Unchecked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_commas", "Unchecked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_dashes", "Unchecked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".FillGaps", "Checked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".MaxFill", 10)

        presetName = "Orson's Favourite"
        app:SetData("SnapCaptions.Presets." .. presetName .. ".CaseConversion", 3)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".RemovePunctuation", 1)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_periods", "Checked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_quotes", "Checked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_question", "Checked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_colon", "Checked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_exclaim", "Checked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_semicolon", "Checked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_commas", "Checked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_dashes", "Unchecked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".FillGaps", "Checked")
        app:SetData("SnapCaptions.Presets." .. presetName .. ".MaxFill", 50)

        app:SetData("SnapCaptions.PresetOrder", PresetOrder)
    end

    CurrentPresets = {} -- Define the global table

    function fillCustomPresets()
        local currentPreset = win:Find('SavePreset').CurrentText
        local presets = app:GetData("SnapCaptions.Presets")
        local presetOrder = app:GetData("SnapCaptions.PresetOrder")

        if presets and presetOrder then
            win:Find('SavePreset'):Clear()
            -- Clear the global table before filling it
            CurrentPresets = {}

            -- Iterate over the presetOrder table to add presets in the specified order
            for _, Name in ipairs(presetOrder) do
                if presets[Name] then
                    -- Add each name to the combo box
                    win:Find('SavePreset'):AddItem(Name)

                    -- Add the preset name to the global table
                    table.insert(CurrentPresets, Name)
                end
            end
            if currentPreset ~= "" then
                local presetExists = false
                for _, Name in ipairs(presetOrder) do
                    if Name == currentPreset then
                        presetExists = true
                        break
                    end
                end
                if presetExists then
                    loadPreset(currentPreset)
                else
                    local default = app:GetData("SnapCaptions.DefaultPreset") or "Default"
                    loadPreset(default)
                end
            end
        end
    end

    function fillCustomPresetsSETTINGS()
        win:Find('SavePresetUPDATES'):Clear()
        local presets = app:GetData("SnapCaptions.Presets")
        local presetOrder = app:GetData("SnapCaptions.PresetOrder")

        if presets and presetOrder then
            -- Iterate over the presetOrder table to add presets in the specified order
            for _, Name in ipairs(presetOrder) do
                if presets[Name] then
                    -- Add each name to the combo box
                    win:Find('SavePresetUPDATES'):AddItem(Name)
                end
            end
        end
    end

    function loadPreset(presetName)
        win:Find("text_transform").CurrentIndex = app:GetData("SnapCaptions.Presets." .. presetName .. ".CaseConversion")
        win:Find("remove_periods").CheckState = app:GetData("SnapCaptions.Presets." ..
            presetName .. ".PunctuationAdvanced.remove_periods")
        win:Find("remove_quotes").CheckState = app:GetData("SnapCaptions.Presets." ..
            presetName .. ".PunctuationAdvanced.remove_quotes")
        win:Find("remove_question").CheckState = app:GetData("SnapCaptions.Presets." ..
            presetName .. ".PunctuationAdvanced.remove_question")
        win:Find("remove_colon").CheckState = app:GetData("SnapCaptions.Presets." ..
            presetName .. ".PunctuationAdvanced.remove_colon")
        win:Find("remove_exclaim").CheckState = app:GetData("SnapCaptions.Presets." ..
            presetName .. ".PunctuationAdvanced.remove_exclaim")
        win:Find("remove_semicolon").CheckState = app:GetData("SnapCaptions.Presets." ..
            presetName .. ".PunctuationAdvanced.remove_semicolon")
        win:Find("remove_commas").CheckState = app:GetData("SnapCaptions.Presets." ..
            presetName .. ".PunctuationAdvanced.remove_commas")
        win:Find("remove_dashes").CheckState = app:GetData("SnapCaptions.Presets." ..
            presetName .. ".PunctuationAdvanced.remove_dashes")
        win:Find("remove_punctuation").CurrentIndex = app:GetData("SnapCaptions.Presets." ..
            presetName .. ".RemovePunctuation")
        win:Find("fill_gaps").CheckState = app:GetData("SnapCaptions.Presets." .. presetName .. ".FillGaps")
        win:Find("max_fill").Value = app:GetData("SnapCaptions.Presets." .. presetName .. ".MaxFill")
        win:Find('SavePreset').CurrentText = presetName
    end

    function win.On.save_settings.Clicked(ev)
        local presetOrder = app:GetData("SnapCaptions.PresetOrder")
        local presetName = win:Find('SavePreset').CurrentText
        app:SetData("SnapCaptions.Presets." .. presetName .. ".CaseConversion", win:Find("text_transform").CurrentIndex)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".RemovePunctuation",
            win:Find("remove_punctuation").CurrentIndex)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_periods",
            win:Find("remove_periods").CheckState)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_quotes",
            win:Find("remove_quotes").CheckState)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_question",
            win:Find("remove_question").CheckState)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_colon",
            win:Find("remove_colon").CheckState)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_exclaim",
            win:Find("remove_exclaim").CheckState)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_semicolon",
            win:Find("remove_semicolon").CheckState)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_commas",
            win:Find("remove_commas").CheckState)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_dashes",
            win:Find("remove_dashes").CheckState)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".FillGaps", win:Find("fill_gaps").CheckState)
        app:SetData("SnapCaptions.Presets." .. presetName .. ".MaxFill", win:Find("max_fill").Value)
        local alreadyPreset = false
        for _, name in ipairs(CurrentPresets) do
            if name == presetName then
                alreadyPreset = true
            end
        end
        if not alreadyPreset then
            win:Find('SavePreset'):AddItem(presetName)
            table.insert(presetOrder, presetName)
            app:SetData("SnapCaptions.PresetOrder", presetOrder)
        end
    end

    function win.On.delete_pack.Clicked(ev)
        local packFolder = win:Find('Packs').CurrentText
        deletePack(packFolder)
    end

    function win.On.text_transform.CurrentIndexChanged(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".CaseConversion") ~= win:Find("text_transform").CurrentIndex) then
            win:Find('SavePreset').CurrentText = "Custom"
        end
    end

    function win.On.remove_punctuation.CurrentIndexChanged(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".RemovePunctuation") ~= win:Find("remove_punctuation").CurrentIndex) then
            win:Find('SavePreset').CurrentText = "Custom"
        end
    end

    function win.On.max_fill.ValueChanged(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".MaxFill") ~= win:Find("max_fill").Value) then
            win:Find('SavePreset').CurrentText = "Custom"
        end
    end

    function win.On.SavePreset.CurrentIndexChanged(ev)
        local presetName = win:Find('SavePreset').CurrentText
        loadPreset(presetName)
    end

    function win.On.default_settings.Clicked(ev)
        local presetName = win:Find('SavePresetUPDATES').CurrentText
        app:SetData("SnapCaptions.DefaultPreset", presetName)
    end

    fillCustomPresets()
    local default = app:GetData("SnapCaptions.DefaultPreset") or "Default"
    loadPreset(default)

    win:Find('MainTabs'):AddTab("Main")
    win:Find('MainTabs'):AddTab("Packs")
    win:Find('MainTabs'):AddTab("⚙️")

    function win.On.MainTabs.CurrentChanged(ev)
        win:Find('MainStack').CurrentIndex = ev.Index

        if ev.Index == 2 then
            fillCustomPresetsSETTINGS()
            local installedPacks = mediaStorage:GetSubFolderList(installFolder)
            PopulateInstalledPacks(installedPacks)
        elseif ev.Index == 0 then
            win:Find('SavePresetUPDATES'):Clear()
            win:Find('Packs'):Clear()
            fillCustomPresets()
        else
            local installedPacks = mediaStorage:GetSubFolderList(installFolder)
            PopulateLibrary(installedPacks)
        end

        for i = 0, 2, 1 do
            if ev.Index ~= i then win:Find('MainTabs').TabTextColor[i] = { R = 1, G = 1, B = 1, A = 0.25 } end
        end

        win:Find('MainTabs').TabTextColor[ev.Index] = { R = 1, G = 1, B = 1, A = 1 }
    end

    function win.On.Advanced.Clicked(ev)
        win:Find("PunctuationSimple").Hidden = true
        win:Find("PunctuationAdvanced").Hidden = false
        local currentGem = win:Find(winID).Geometry
        win:Move({ currentGem[1] - 100, currentGem[2] - 60, currentGem[3], currentGem[4] })
        win:RecalcLayout()
    end

    function win.On.Simple.Clicked(ev)
        win:Find("PunctuationSimple").Hidden = false
        win:Find("PunctuationAdvanced").Hidden = true
        local currentGem = win:Find(winID).Geometry
        win:Move({ currentGem[1] + 100, currentGem[2], currentGem[3], currentGem[4] })
        win:RecalcLayout()
    end

    function win.On.remove_periods.Toggled(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_periods") ~= win:Find("remove_periods").CheckState) then
            win:Find('SavePreset').CurrentText = "Custom"
        end

        local Checks = {
            win:Find("remove_periods").CheckState,
            win:Find("remove_quotes").CheckState,
            win:Find("remove_question").CheckState,
            win:Find("remove_colon").CheckState,
            win:Find("remove_exclaim").CheckState,
            win:Find("remove_semicolon").CheckState,
            win:Find("remove_commas").CheckState,
            win:Find("remove_dashes").CheckState
        }
        if win:Find("remove_periods").CheckState == "Checked" then
            win:Find("remove_punctuation").CurrentIndex = 1
        else
            local Check = true
            for _, box in ipairs(Checks) do
                if box == "Checked" then
                    return
                else
                    Check = false
                end
            end
            if Check == false then
                win:Find("remove_punctuation").CurrentIndex = 0
            end
        end
    end

    function win.On.remove_quotes.Toggled(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_quotes") ~= win:Find("remove_quotes").CheckState) then
            win:Find('SavePreset').CurrentText = "Custom"
        end
        local Checks = {
            win:Find("remove_periods").CheckState,
            win:Find("remove_quotes").CheckState,
            win:Find("remove_question").CheckState,
            win:Find("remove_colon").CheckState,
            win:Find("remove_exclaim").CheckState,
            win:Find("remove_semicolon").CheckState,
            win:Find("remove_commas").CheckState,
            win:Find("remove_dashes").CheckState
        }
        if win:Find("remove_quotes").CheckState == "Checked" then
            win:Find("remove_punctuation").CurrentIndex = 1
        else
            local Check = true
            for _, box in ipairs(Checks) do
                if box == "Checked" then
                    return
                else
                    Check = false
                end
            end
            if Check == false then
                win:Find("remove_punctuation").CurrentIndex = 0
            end
        end
    end

    function win.On.remove_question.Toggled(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_question") ~= win:Find("remove_question").CheckState) then
            win:Find('SavePreset').CurrentText = "Custom"
        end
        local Checks = {
            win:Find("remove_periods").CheckState,
            win:Find("remove_quotes").CheckState,
            win:Find("remove_question").CheckState,
            win:Find("remove_colon").CheckState,
            win:Find("remove_exclaim").CheckState,
            win:Find("remove_semicolon").CheckState,
            win:Find("remove_commas").CheckState,
            win:Find("remove_dashes").CheckState
        }
        if win:Find("remove_question").CheckState == "Checked" then
            win:Find("remove_punctuation").CurrentIndex = 1
        else
            local Check = true
            for _, box in ipairs(Checks) do
                if box == "Checked" then
                    return
                else
                    Check = false
                end
            end
            if Check == false then
                win:Find("remove_punctuation").CurrentIndex = 0
            end
        end
    end

    function win.On.remove_colon.Toggled(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_colon") ~= win:Find("remove_colon").CheckState) then
            win:Find('SavePreset').CurrentText = "Custom"
        end
        local Checks = {
            win:Find("remove_periods").CheckState,
            win:Find("remove_quotes").CheckState,
            win:Find("remove_question").CheckState,
            win:Find("remove_colon").CheckState,
            win:Find("remove_exclaim").CheckState,
            win:Find("remove_semicolon").CheckState,
            win:Find("remove_commas").CheckState,
            win:Find("remove_dashes").CheckState
        }
        if win:Find("remove_colon").CheckState == "Checked" then
            win:Find("remove_punctuation").CurrentIndex = 1
        else
            local Check = true
            for _, box in ipairs(Checks) do
                if box == "Checked" then
                    return
                else
                    Check = false
                end
            end
            if Check == false then
                win:Find("remove_punctuation").CurrentIndex = 0
            end
        end
    end

    function win.On.remove_exclaim.Toggled(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_exclaim") ~= win:Find("remove_exclaim").CheckState) then
            win:Find('SavePreset').CurrentText = "Custom"
        end
        local Checks = {
            win:Find("remove_periods").CheckState,
            win:Find("remove_quotes").CheckState,
            win:Find("remove_question").CheckState,
            win:Find("remove_colon").CheckState,
            win:Find("remove_exclaim").CheckState,
            win:Find("remove_semicolon").CheckState,
            win:Find("remove_commas").CheckState,
            win:Find("remove_dashes").CheckState
        }
        if win:Find("remove_exclaim").CheckState == "Checked" then
            win:Find("remove_punctuation").CurrentIndex = 1
        else
            local Check = true
            for _, box in ipairs(Checks) do
                if box == "Checked" then
                    return
                else
                    Check = false
                end
            end
            if Check == false then
                win:Find("remove_punctuation").CurrentIndex = 0
            end
        end
    end

    function win.On.remove_semicolon.Toggled(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_semicolon") ~= win:Find("remove_semicolon").CheckState) then
            win:Find('SavePreset').CurrentText = "Custom"
        end
        local Checks = {
            win:Find("remove_periods").CheckState,
            win:Find("remove_quotes").CheckState,
            win:Find("remove_question").CheckState,
            win:Find("remove_colon").CheckState,
            win:Find("remove_exclaim").CheckState,
            win:Find("remove_semicolon").CheckState,
            win:Find("remove_commas").CheckState,
            win:Find("remove_dashes").CheckState
        }
        if win:Find("remove_semicolon").CheckState == "Checked" then
            win:Find("remove_punctuation").CurrentIndex = 1
        else
            local Check = true
            for _, box in ipairs(Checks) do
                if box == "Checked" then
                    return
                else
                    Check = false
                end
            end
            if Check == false then
                win:Find("remove_punctuation").CurrentIndex = 0
            end
        end
    end

    function win.On.remove_commas.Toggled(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_commas") ~= win:Find("remove_commas").CheckState) then
            win:Find('SavePreset').CurrentText = "Custom"
        end
        local Checks = {
            win:Find("remove_periods").CheckState,
            win:Find("remove_quotes").CheckState,
            win:Find("remove_question").CheckState,
            win:Find("remove_colon").CheckState,
            win:Find("remove_exclaim").CheckState,
            win:Find("remove_semicolon").CheckState,
            win:Find("remove_commas").CheckState,
            win:Find("remove_dashes").CheckState
        }
        if win:Find("remove_commas").CheckState == "Checked" then
            win:Find("remove_punctuation").CurrentIndex = 1
        else
            local Check = true
            for _, box in ipairs(Checks) do
                if box == "Checked" then
                    return
                else
                    Check = false
                end
            end
            if Check == false then
                win:Find("remove_punctuation").CurrentIndex = 0
            end
        end
    end

    function win.On.remove_dashes.Toggled(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".PunctuationAdvanced.remove_dashes") ~= win:Find("remove_dashes").CheckState) then
            win:Find('SavePreset').CurrentText = "Custom"
        end
        local Checks = {
            win:Find("remove_periods").CheckState,
            win:Find("remove_quotes").CheckState,
            win:Find("remove_question").CheckState,
            win:Find("remove_colon").CheckState,
            win:Find("remove_exclaim").CheckState,
            win:Find("remove_semicolon").CheckState,
            win:Find("remove_commas").CheckState,
            win:Find("remove_dashes").CheckState
        }
        if win:Find("remove_dashes").CheckState == "Checked" then
            win:Find("remove_punctuation").CurrentIndex = 1
        else
            local Check = true
            for _, box in ipairs(Checks) do
                if box == "Checked" then
                    return
                else
                    Check = false
                end
            end
            if Check == false then
                win:Find("remove_punctuation").CurrentIndex = 0
            end
        end
    end

    function win.On.process.Clicked(ev)
        local root_element = win:Find("root")
        root_element:SetEnabled(false)
        local success = GenerateTextPlus(win)
        root_element:SetEnabled(true)
        if not success then
            return
        end
        app:SetData("SnapCaptions.Settings.CloseonFinish", win:Find("close_window").CheckState)
        if win:Find("close_window").CheckState == "Checked" then
            disp:ExitLoop()
        end
    end

    function win.On.fill_gaps.Toggled(ev)
        local presetName = win:Find('SavePreset').CurrentText
        if (app:GetData("SnapCaptions.Presets." .. presetName .. ".FillGaps") ~= win:Find("fill_gaps").CheckState) then
            win:Find('SavePreset').CurrentText = "Custom"
        end
        local group = win:Find("max_fill_group")
        local checkbox = win:Find("fill_gaps")
        group:SetEnabled(checkbox.Checked)
    end

    function win.On.SnapCaptionsWin.Close(ev)
        if not AboveWindowOpen == true then
            app:SetData("SnapCaptions.Settings.CloseonFinish", win:Find("close_window").CheckState)
            -- disp:ExitLoop()
            disp:ExitLoop()
        end
    end

    function win.On.refresh_subtitle_tracks.Clicked(ev)
        PopulateSubtitleTracks(win)
    end

    function win.On.refresh_text_templates.Clicked(ev)
        PopulateTextTemplates(win)
    end

    function win.On.install.Clicked(ev)
        local success = InstallScript()
        if not success then
            return
        end

        local content = win:GetItems().install_bar
        content:RemoveChild("install_group")
        win:RecalcLayout()
    end

    if not SCRIPT_INSTALLED then
        local content = win:GetItems().install_bar
        content:AddChild(
            ui:VGroup
            {
                ID = "install_group",
                Weight = 0,
                Spacing = 10,
                StyleSheet = [[
                    QWidget
                    {
                        margin-bottom: 0px;
                    }
                ]],
                ui:HGroup
                {
                    ui:Label
                    {
                        Weight = 1,
                        Text = "Install tool to Resolve's Scripts folder?"
                    },
                    ui:Button
                    {
                        Weight = 0,
                        ID = "install",
                        Text = "Install",
                        StyleSheet = BANNER_ACTION_BUTTON_CSS
                    }
                },
                ui:Label
                {
                    Weight = 0,
                    FrameStyle = 4,
                    StyleSheet = DIVIDER_CSS
                }
            })
    end

    win:Find('MainTabs').CurrentIndex = 2
    win:Find('MainTabs').CurrentIndex = 0

    if SCRIPT_INSTALLED then
        if noTemplateBin then
            win:Find('MainTabs').CurrentIndex = 1
        end
    end

    win:RecalcLayout()
    win:Show()
    disp:RunLoop()
    win:Hide()
end


local function Main()
    -- Check that there is a current timeline.
    -- if SCRIPT_INSTALLED and project:GetCurrentTimeline() == nil then
    --     local dialog = CreateDialog("No Current Timeline",
    --         "Please open a timeline and try again.",
    --         noTimeline)
    --     -- dialog:RecalcLayout()
    --     -- dialog:Show()
    --     -- disp:RunLoop()
    --     -- return
    -- end

    -- If the window is already being shown, raise it and exit.
    local win = ui:FindWindow(winID)
    if win ~= nil then
        win:RecalcLayout()
        win:Show()
        win:Raise()
        return
    end

    -- Otherwise, create the tool window.
    CreateToolWindow()
end


Main()
collectgarbage("collect")
