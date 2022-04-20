-- additional utility functions for Rebirth Plus
-- PLUS ULTRA

function rp_isGlobalVar(var)
    for k, _ in pairs(_G) do
        if k == var then
            return true
        end
    end
end


function rp_update_mean(old_mu, old_N, mu, N)
    return ((old_mu * old_N)+(mu*N)) / (old_N + N), (old_N + N)
end
-- moved from BGAnimations/ScreenEvaluation decorations/mainDisplay.lua Line 604
function rp_calculateStatData(score)
    local tracks = score:GetTrackVector()
    local offsetTable = score:GetOffsetVector()

    -- MUST MATCH statData above
    local output = {
        0, -- notes
        0, -- mean
        0, -- sd
        0, -- largest deviation
    }

    if offsetTable == nil or #offsetTable == 0 then
        return output
    end

    -- count CBs
    for i, o in ipairs(offsetTable) do
        -- online replays return 180 instead of "1000" for misses
        if o == 180 then
            offsetTable[i] = 1000
            o = 1000
        end
    end

    local smallest, largest = wifeRange(offsetTable)

    -- MUST MATCH statData above
    output = {
        #offsetTable, -- notes
        wifeMean(offsetTable), -- mean
        wifeSd(offsetTable), -- sd
        largest,
    }
    return output
end

function rp_getHighscoreByKey(key, rate)
    local hs = nil
    local scorestack = SCOREMAN:GetScoresByKey(key)
    if scorestack ~= nil then
        -- the scores are in lists for each rate
        -- find the highest
        for ___, l in pairs(scorestack) do
            local scoresatrate = l:GetScores()
            for ____, s in ipairs(scoresatrate) do
                if rate == nil or s:GetMusicRate() == rate then
                    local ws = s:GetWifeScore()
                    if hs == nil or ws > hs:GetWifeScore() then
                        hs = s
                    end
                end
            end
        end
    end
    return hs
end