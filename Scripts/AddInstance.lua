-- New Project --
local ws = game:GetService("Workspace")

function create_dictionaries()
    local folders = {
        "HHxScripts", "HHxScripts/Assets", "HHxScripts/Assets/Audios", "HHxScripts/Assets/Images"
    } for index = 1, #folders do
        if not isfolder(folders[index]) then
            makefolder(folders[index])
        end
    end
end

local my_assets, my_repos = {
    "HHxScripts/Assets/Audios/AutoFarmLevel_Enabled.mp3",
    "HHxScripts/Assets/Audios/AutoFarmLevel_Disabled.mp3",
    "HHxScripts/Assets/Audios/Endfield_24.mp3",
    "HHxScripts/Assets/Audios/Endfield_42"
}, "https://raw.githubusercontent.com/Ancient2k3/Assets/refs/heads/main/Audio/"

function dwnload_audio_asset()
    if writefile and isfile then
        create_dictionaries()
        for index = 1, #my_assets do
            if not isfile(my_assets[index]) then
                writefile(my_assets[index], game:HttpGet(my_assets[index]:gsub("HHxScripts/Assets/Audios/", my_repos)))
            end
        end if not isfile("HHxScripts/Assets/Audios/.nomedia") then
            writefile("HHxScripts/Assets/Audios/.nomedia", "")
        end
    end
end

function add_wsfolder(pr, name)
    local current = pr:FindFirstChild(name)
    if current == nil then
        local new_folder = Instance.new("Folder", pr)
        new_folder.Name = name
        print("[-]: created " .. name .. "!")
    else
        print("[+]: " .. name .. " already exist!")
    end
end

function create_sound_obj()
    add_wsfolder(ws, "HHxScripts")
    add_wsfolder(ws["HHxScripts"], "Assets")
    add_wsfolder(ws["HHxScripts"]["Assets"], "Audios")
    for index = 1, #my_assets do
        local extract_name = string.gsub(my_assets[index]:gsub("HHxScripts/Assets/Audios/", ""), ".mp3", "")
        local sound_obj = ws["HHxScripts"]["Assets"]["Audios"]:FindFirstChild(extract_name)
        if sound_obj == nil then
            local new_sound_obj = Instance.new("Sound", ws["HHxScripts"]["Assets"]["Audios"])
            new_sound_obj.SoundId = getcustomasset(my_assets[index])
            new_sound_obj.Name = extract_name
            print("[+]: added " .. extract_name .. "!")
        end
    end
end

dwnload_audio_asset()
create_sound_obj()
