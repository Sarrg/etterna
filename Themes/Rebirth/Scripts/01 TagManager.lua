-- TODO Rename file to SettingsManager.lua

local defaultConfig = {
    playerTags = {}
}

TAGMAN = create_setting("tags", "tags.lua", defaultConfig, 0)
TAGMAN:load()

defaultConfig = {
}

for i=1,9 do
    defaultConfig[i] = {}
    defaultConfig[i]["Name"] = "Profile "..i
end

PRESETMAN = create_setting("filterprofile", "filterprofile.lua", defaultConfig, 0)
PRESETMAN:load()
PRESETMAN['selectedPreset'] = 0

PRESETMAN['specialPresets'] = {
    function()
        local profile = PROFILEMAN:GetProfile(PLAYER_1)
        local preset = {
            Name = "Warmup",
            FilterMode = "AND"
        }

        for i, s in ipairs(ms.SkillSets) do
            local rating = profile:GetPlayerSkillsetRating(s)
            preset[s] = {0, rating}
            if s == "Overall" then
                preset["Overall"] = {rating-6, rating-2}
            end
        end
        return preset
    end,

    function()
        local profile = PROFILEMAN:GetProfile(PLAYER_1)
        local preset = {
            Name = "Push",
            FilterMode = "AND"
        }

        for i, s in ipairs(ms.SkillSets) do
            local rating = profile:GetPlayerSkillsetRating(s)
            preset[s] = {0, rating + 1}
            if s == "Overall" then
                preset["Overall"] = {rating-0.5, rating+1.5}
            end
        end
        return preset
    end,
    
    function()
        local profile = PROFILEMAN:GetProfile(PLAYER_1)
        local preset = {
            Name = "Above Profile",
            FilterMode = "OR"
        }

        for i, s in ipairs(ms.SkillSets) do
            local rating = profile:GetPlayerSkillsetRating(s)
            preset[s] = {rating, 40}
        end
        return preset
    end,

    function()
        local profile = PROFILEMAN:GetProfile(PLAYER_1)
        local preset = {
            Name = "Below Profile",
            FilterMode = "AND"
        }

        for i, s in ipairs(ms.SkillSets) do
            local rating = profile:GetPlayerSkillsetRating(s)
            preset[s] = {0, rating}
        end
        return preset
    end,
}


function PRESETMAN:SavePreset(id, preset)
    if id == nil then
        id = PRESETMAN.selectedPreset
    end

    if id > 0 then
        PRESETMAN:get_data()[id] = preset
        PRESETMAN:set_dirty()
        PRESETMAN:save()
    end
end

function PRESETMAN:LoadPreset(id)
    local presets = PRESETMAN:get_data()
    if id < -#PRESETMAN.specialPresets then
        id = #presets
    end
    if id > #presets then
        id = -#PRESETMAN.specialPresets
    end

    PRESETMAN.selectedPreset = id
    return self:GetPreset(id)
end

function PRESETMAN:GetPreset(id)
    if id == nil then
        id = PRESETMAN.selectedPreset
    end
    if id > 0 then
        print("GetPreset "..id)
        return PRESETMAN:get_data()[id]
    end
    if id < 0 then
        id = -id
        return PRESETMAN.specialPresets[id]()
    end
    return nil
end