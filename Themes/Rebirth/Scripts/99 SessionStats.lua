
local ratios = {
    LeftGap = 16 / 1920,
    UpperGap = 219 / 1080, -- distance from top of screen, not info frame
    LowerGap = 0 / 1080, -- expected, maybe unused
    Width = 867 / 1920,
    Height = 861 / 1080, -- does not include the header
    ItemHeight = 86.5 / 1080, -- 85 + 2 to account for half of the upper and lower item dividers
    ItemDividerThickness = 2 / 1080,
    ItemDividerLength = 584 / 1920,
    ItemTextUpperGap = 20 / 1080, -- distance from top of item to center of title text
    ItemTextLowerGap = 18 / 1080, -- distance from center of divider to center of author text
    ItemTextCenterDistance = 40 / 1080, -- distance from lower (divider center) to center of subtitle
    ItemGradeTextRightGap = 24 / 1920, -- distance from right of item to right edge of text
    ItemGradeTextMaxWidth = 86 / 1920, -- approximation of width of the AAAAA grade
    ItemFavoriteIconRightGap = 18 / 1920, -- from right edge of banner to middle of favorite icon
    ItemFavoriteIconSize = 36 / 1080, -- width and height of the icon
    ItemPermamirrorIconRightGap = 40 / 1920, -- from right edge of banner to middle of favorite icon
    ItemPermamirrorIconSize = 39 / 1080, -- width and height of the icon
    BannerWidth = 265 / 1920,
    BannerItemGap = 18 / 1920, -- gap between banner and item text/dividers
    HeaderHeight = 110 / 1080,
    HeaderUpperGap = 109 / 1080, -- top of screen to top of frame (same as playerinfo height)
    wtffudge = 45 / 1080, -- this random number fixes the weird offset of the wheel vertically so that it fits perfectly with the header
    -- effective measurements for group specific information
    HeaderBannerWidth = 336 / 1920,
    HeaderText1UpperGap = 21 / 1080, -- distance from top edge to top text top edge
    HeaderText2UpperGap = 68 / 1080, -- distance from top edge to top edge of lower text
    HeaderTextLeftGap = 21 / 1920, -- distance from edge of banner to left of text
    -- effective measurements for the header lines when not in group specific info mode
    HeaderMText1UpperGap = 16 / 1080,
    HeaderMText2UpperGap = 47 / 1080,
    HeaderMText3UpperGap = 78 / 1080,
    HeaderMTextLeftGap = 0 / 1920, -- text width will be the same as the banner width
    HeaderGraphWidth = 573 / 1920, -- very approximate

    -- controls the width of the mouse wheel scroll box, should be the same number as the general box X position
    -- (found in generalBox.lua)
    GeneralBoxLeftGap = 1140 / 1920, -- distance from left edge to the left edge of the general box

    ScrollBarWidth = 18 / 1920,
    ScrollBarHeight = 971 / 1080,
}

local actuals = {
    LeftGap = ratios.LeftGap * SCREEN_WIDTH,
    UpperGap = ratios.UpperGap * SCREEN_HEIGHT,
    LowerGap = ratios.LowerGap * SCREEN_HEIGHT,
    Width = ratios.Width * SCREEN_WIDTH,
    Height = ratios.Height * SCREEN_HEIGHT,
    ItemHeight = ratios.ItemHeight * SCREEN_HEIGHT,
    ItemDividerThickness = 2, -- maybe needs to be constant
    ItemDividerLength = ratios.ItemDividerLength * SCREEN_WIDTH,
    ItemTextUpperGap = ratios.ItemTextUpperGap * SCREEN_HEIGHT,
    ItemTextLowerGap = ratios.ItemTextLowerGap * SCREEN_HEIGHT,
    ItemTextCenterDistance = ratios.ItemTextCenterDistance * SCREEN_HEIGHT,
    ItemGradeTextRightGap = ratios.ItemGradeTextRightGap * SCREEN_WIDTH,
    ItemGradeTextMaxWidth = ratios.ItemGradeTextMaxWidth * SCREEN_WIDTH,
    ItemFavoriteIconRightGap = ratios.ItemFavoriteIconRightGap * SCREEN_WIDTH,
    ItemFavoriteIconSize = ratios.ItemFavoriteIconSize * SCREEN_HEIGHT,
    ItemPermamirrorIconRightGap = ratios.ItemPermamirrorIconRightGap * SCREEN_WIDTH,
    ItemPermamirrorIconSize = ratios.ItemPermamirrorIconSize * SCREEN_HEIGHT,
    BannerWidth = ratios.BannerWidth * SCREEN_WIDTH,
    BannerItemGap = ratios.BannerItemGap * SCREEN_WIDTH,
    HeaderHeight = ratios.HeaderHeight * SCREEN_HEIGHT,
    HeaderUpperGap = ratios.HeaderUpperGap * SCREEN_HEIGHT,
    wtffudge = ratios.wtffudge * SCREEN_HEIGHT,
    HeaderBannerWidth = ratios.HeaderBannerWidth * SCREEN_WIDTH,
    HeaderText1UpperGap = ratios.HeaderText1UpperGap * SCREEN_HEIGHT,
    HeaderText2UpperGap = ratios.HeaderText2UpperGap * SCREEN_HEIGHT,
    HeaderTextLeftGap = ratios.HeaderTextLeftGap * SCREEN_WIDTH,
    HeaderMText1UpperGap = ratios.HeaderMText1UpperGap * SCREEN_HEIGHT,
    HeaderMText2UpperGap = ratios.HeaderMText2UpperGap * SCREEN_HEIGHT,
    HeaderMText3UpperGap = ratios.HeaderMText3UpperGap * SCREEN_HEIGHT,
    HeaderMTextLeftGap = ratios.HeaderMTextLeftGap * SCREEN_WIDTH,
    HeaderGraphWidth = ratios.HeaderGraphWidth * SCREEN_WIDTH,
    GeneralBoxLeftGap = ratios.GeneralBoxLeftGap * SCREEN_WIDTH,
    ScrollBarWidth = ratios.ScrollBarWidth * SCREEN_WIDTH,
    ScrollBarHeight = ratios.ScrollBarHeight * SCREEN_HEIGHT,
}

local wheelItemTextSize = 0.62
local wheelItemGradeTextSize = 1
local wheelItemTitleTextSize = 0.82
local wheelItemSubTitleTextSize = 0.62
local wheelItemArtistTextSize = 0.62
local wheelItemGroupTextSize = 0.82
local wheelItemGroupInfoTextSize = 0.62
local wheelHeaderTextSize = 1.2
local wheelHeaderMTextSize = 0.6
local textzoomfudge = 5 -- used in maxwidth to allow for gaps when squishing text

local graphLineColor = COLORS:getWheelColor("GraphLine")
local primaryTextColor = COLORS:getMainColor("PrimaryText")


--[[
Note: This is relatively barebones, and not very customizable.
Ex:
    t[#t+1] = audioVisualizer:new {
        x = SCREEN_RIGHT*1/3,
        y = SCREEN_BOTTOM*3/11,
        color = getMainColor('positive'),
        onInit = function(frame)
            local soundActor = frame.sound.actor
            local songs = SONGMAN:GetAllSongs()
            local idx = math.random(1, #songs)
            soundActor:stop()
            soundActor:load(songs[idx]:GetMusicPath())
            soundActor:play()
        end
    }
Using SOUND:
    local vis = audioVisualizer:new {
        x = SCREEN_RIGHT*1/3,
        y = SCREEN_BOTTOM*3/11,
        color = getMainColor('positive')
    }
    t[#t+1] = vis
    SOUND:SetPlayBackCallback(vis.playbackFunction)
--]]
local headerTransitionSeconds = 0.0
local graphBoundTextSize = 0.4
local graphBoundOffset = 10 / 1080 * SCREEN_HEIGHT -- offset the graph bounds diagonally by this much for alignment reasons
local graphWidth = actuals.ItemDividerLength - actuals.ItemGradeTextRightGap / 2
local playsThisSession = 0
local scoresThisSession = {}
local accThisSession = 0

-- the vertical bounds for the graph
-- need to keep them respectable ... dont allow below 50 or above 100
local graphUpperBound = 100
local graphLowerBound = 50
local hoverAlpha = 0.9


if not rp_isGlobalVar("pbsThisSession") then
    pbsThisSession = 0
    meanThisSession = 0
    sdThisSession = 0
    arrowsSmashedThisSession = 0
    lastScore = nil
end

-- calculate average wife percent for scores set this session
-- ignores negative percents
local function calcAverageWifePercentThisSession()
    local sum = 0
    for i, s in ipairs(scoresThisSession) do
        sum = sum + clamp(s:GetWifeScore() * 100, 0, 100)
    end

    -- prevent division by 0
    if playsThisSession == 0 then
        return 0
    else
        return sum / playsThisSession
    end
end

-- figure out the graph bounds in a very slightly more intelligent way than normal
local function calculateGraphBounds()
    local max = -10000
    local min = 10000

    local sum = 0
    local sd = 0
    local mean = 0
    for _, s in ipairs(scoresThisSession) do
        local w = clamp(s:GetWifeScore() * 100, 0, 100)
        if w > max then
            max = w
        end
        if w < min then
            min = w
        end
        sum = sum + w
    end

    -- prevent division by 0
    if playsThisSession == 0 then
        mean = 85
        sd = 15
        min = 0
        max = 100
    else
        mean = sum / playsThisSession
        -- 2nd pass for sd
        for _, s in ipairs(scoresThisSession) do
            local w = clamp(s:GetWifeScore() * 100, 0, 100)
            sd = sd + (w - mean) ^ 2
        end
        sd = math.sqrt(sd / playsThisSession)
    end

    max = clamp(mean + sd, min, 100)
    min = clamp(mean - sd / 2, 0, max)

    -- probably possible if your only score is outside the 0-100 range somehow
    -- allow impossible bounds here (negative and +100%)
    if min == max and playsThisSession > 1 then
        max = max + 2.5
        min = min - 2.5
    end
    graphUpperBound = max
    graphLowerBound = min
end


-- convert x value to x position in graph
local function graphXPos(x, width)
    -- dont hit the edge
    local buffer = 0.01
    local minX = width * buffer
    local maxX = width * (1 - buffer)

    local count = playsThisSession
    -- the left end of segments should be where the points go
    -- for 1, this is the middle
    -- 2 points makes 3 segments
    -- ...etc
    local xsegmentsize = (width - buffer * 2) / (count + 1)

    -- remember offset by minX and then push it over by the segmentsize
    return minX + xsegmentsize * x
end

-- convert y value to y position in graph
local function graphYPos(y, height)
    -- dont quite allow hitting the edges
    local buffer = 1
    local minY = graphLowerBound - buffer
    local maxY = graphUpperBound + buffer
    y = clamp(y, graphLowerBound, graphUpperBound)

    local percentage = (y - minY) / (maxY - minY)

    -- negate the output, the graph line position is relative to bottom left corner of graph
    -- negative numbers go upward on the screen
    return -1 * percentage * height
end

-- generate vertices for 1 dot in the graph
local function createVertices(vt, x, y, c)
    vt[#vt + 1] = {{x, y, 0}, c}
end

-- generate the vertices to put into the ActorFrameTexture for the MiscPage graph
local function generateRecentWifeScoreGraph()
    local v = {}
    -- update color if it happened to update before now
    graphLineColor = COLORS:getWheelColor("GraphLine")

    for i, s in ipairs(scoresThisSession) do
        local w = s:GetWifeScore() * 100
        local x = graphXPos(i, graphWidth)
        local y = graphYPos(w, actuals.HeaderHeight / 8 * 6)
        createVertices(v, x, y, graphLineColor)
    end

    return v
end

--[[
    params = {
        x=0,
        y=0,
        color = red,
        minHeight = 3,
        maxHeight = 120,
        width = 300, -- Of the whole thing
        spacing = 1, -- Between bars
        barBuilder = quad, -- Function that takes params
        sampleCount = 4096, -- number of samples per update
        onBarUpdate = nil, -- function(barActor, value) called whenever theyre updated
            (value is in the [0,1] range)
        onInit = nil
    }
]]

local function graphBuilder(params)
    -- pass
    local graph =
    Def.ActorFrame {
        Name = "Graph",
        InitCommand = function(self)
            -- the graph is placed relative to the top of the header and left aligned the same as the wheel items left alignment
            self:x(actuals.Width - actuals.ItemDividerLength)
        end
    }

    graph[#graph + 1] = Def.Quad {
        Name = "YAxisLine",
        InitCommand = function(self)
            self:halign(0):valign(0)
            self:x(actuals.HeaderMTextLeftGap)
            self:y(actuals.HeaderHeight / 8)
            self:zoomto(actuals.ItemDividerThickness, actuals.HeaderHeight / 8 * 6)
            self:diffusealpha(1)
            registerActorToColorConfigElement(self, "musicWheel", "GraphLine")
        end,
    }

    graph[#graph + 1] = Def.Quad {
        Name = "XAxisLine",
        InitCommand = function(self)
            self:halign(0):valign(0)
            self:x(actuals.HeaderMTextLeftGap)
            self:y(actuals.HeaderHeight - actuals.HeaderHeight / 8)
            self:zoomto(graphWidth, actuals.ItemDividerThickness)
            self:diffusealpha(1)
            registerActorToColorConfigElement(self, "musicWheel", "GraphLine")
        end,
    }
    

    graph[#graph + 1] = LoadFont("Common Normal") .. {
        Name = "YMax",
        InitCommand = function(self)
            self:halign(1)
            self:x(actuals.HeaderMTextLeftGap - graphBoundOffset / 2)
            self:y(actuals.HeaderHeight / 8 - graphBoundOffset)
            self:rotationz(-45)
            self:zoom(graphBoundTextSize)
            self:settextf("%d%%", notShit.round(graphUpperBound))
            self:diffusealpha(1)
            registerActorToColorConfigElement(self, "main", "SecondaryText")
        end,
    }
    

    graph[#graph + 1] = LoadFont("Common Normal") .. {
        Name = "YMin",
        InitCommand = function(self)
            self:halign(1)
            self:x(actuals.HeaderMTextLeftGap - graphBoundOffset / 2)
            self:y(actuals.HeaderHeight / 8 * 7 - graphBoundOffset)
            self:rotationz(-45)
            self:zoom(graphBoundTextSize)
            self:settextf("%d%%", notShit.round(graphLowerBound))
            self:diffusealpha(1)
            registerActorToColorConfigElement(self, "main", "SecondaryText")
        end,
    }


    graph[#graph + 1] = LoadFont("Common Normal") .. {
        Name = "Mean",
        InitCommand = function(self)
            self:halign(1)
            self:x(actuals.HeaderMTextLeftGap + graphWidth)
            self:y(actuals.HeaderHeight / 8 - graphBoundOffset + 5)
            self:zoom(graphBoundTextSize)
            self:settextf("Mean: %.2fms", notShit.round(meanThisSession, 2))
            self:diffusealpha(1)
            registerActorToColorConfigElement(self, "main", "SecondaryText")
        end,
    }


    graph[#graph + 1] = LoadFont("Common Normal") .. {
        Name = "StdDev",
        InitCommand = function(self)
            self:halign(1)
            self:x(actuals.HeaderMTextLeftGap + graphWidth)
            self:y(actuals.HeaderHeight / 8 * 2 - graphBoundOffset +5)
            self:zoom(graphBoundTextSize)
            self:settextf("Std: %.2fms", notShit.round(sdThisSession, 2))
            self:diffusealpha(1)
            registerActorToColorConfigElement(self, "main", "SecondaryText")
        end,
    }


    graph[#graph + 1] = Def.ActorMultiVertex {
        Name = "Line",
        InitCommand = function(self)
            self:x(actuals.HeaderMTextLeftGap)
            self:y(actuals.HeaderHeight / 8 * 7)
            self:playcommand("SetGraph")
        end,
        SetGraphCommand = function(self)
            local v = generateRecentWifeScoreGraph()
            if #v > 1 then
                self:SetVertices(v)
                self:SetDrawState {Mode = "DrawMode_LineStrip", First = 1, Num = #v}
            else
                self:SetVertices({})
                self:SetDrawState {Mode = "DrawMode_LineStrip", First = 1, Num = 0}
            end
        end,
        ColorConfigUpdatedMessageCommand = function(self)
            self:playcommand("SetGraph")
        end,
    }

    return graph
end

local function UpdateGlobals()
    if playsThisSession > 0 then
        local rs = SCOREMAN:GetMostRecentScore()
        if lastScore ~= rs then
            hs = rp_getHighscoreByKey(rs:GetChartKey(), rs:GetMusicRate())
            if rs == hs then
                pbsThisSession = pbsThisSession + 1
            end
            lastScore = rs
            stats = rp_calculateStatData(rs)
            if stats[1] ~= 0 then
                if arrowsSmashedThisSession ~= 0 then
                    meanThisSession, arrowsSmashedThisSession = rp_update_mean(meanThisSession, arrowsSmashedThisSession, stats[2], stats[1])
                    sdThisSession, _ = rp_update_mean(sdThisSession, playsThisSession - 1, stats[3], 1)
                else
                    arrowsSmashedThisSession = stats[1]
                    meanThisSession = stats[2]
                    sdThisSession = stats[3]
                end
            end
        end
    end
end


sessionStats = {}
sessionStats.a = 0
function sessionStats:new(params)
    --[[
        Structure:
        ActorFrame {
            TODO
        }
    --]]
    playsThisSession = SCOREMAN:GetNumScoresThisSession()
    scoresThisSession = SCOREMAN:GetScoresThisSession()
    accThisSession = calcAverageWifePercentThisSession()
    UpdateGlobals() 
    calculateGraphBounds()


    local frame =
        Def.ActorFrame {
        InitCommand = function(self)
            self:xy(params.x or 0, params.y or 0)
            self:SetUpdateFunction(function(self)
                if not self:IsInvisible() then
                    self:GetChild("SessionTime"):playcommand("Set")
                end
            end)
            self:SetUpdateFunctionInterval(0.5)
        end,
        InCommand = function(self)
            self:finishtweening()
            self:smooth(headerTransitionSeconds)
            self:diffusealpha(1)
            self:playcommand("Set")
        end,
        OutCommand = function(self)
            self:finishtweening()
            self:smooth(headerTransitionSeconds)
            self:diffusealpha(0)
        end
    }

    frame[#frame + 1] = LoadFont("Common Normal") .. {
        Name = "SessionTime",
        InitCommand = function(self)
            self:halign(0):valign(0)
            self:xy(actuals.HeaderMTextLeftGap, actuals.HeaderMText1UpperGap)
            self:zoom(wheelHeaderMTextSize)
            self:maxwidth((actuals.BannerWidth - actuals.HeaderMTextLeftGap) / wheelHeaderMTextSize)
            self:diffusealpha(1)
            registerActorToColorConfigElement(self, "main", "PrimaryText")
        end,
        SetCommand = function(self)
            local sesstime = GAMESTATE:GetSessionTime()
            self:settextf("Session Time: %s", SecondsToHHMMSS(sesstime))
        end
    }
    
    frame[#frame + 1] = LoadFont("Common Normal") .. {
        Name = "SessionPlays",
        InitCommand = function(self)
            self:halign(0):valign(0)
            self:xy(actuals.HeaderMTextLeftGap, actuals.HeaderMText2UpperGap)
            self:zoom(wheelHeaderMTextSize)
            self:maxwidth((actuals.BannerWidth - actuals.HeaderMTextLeftGap) / wheelHeaderMTextSize)
            self:diffusealpha(1)
            self:settextf("Session Plays: %d (PBs: %d)", playsThisSession, pbsThisSession)
            registerActorToColorConfigElement(self, "main", "PrimaryText")
        end,
        SetCommand = function(self)
            self:settextf("Session Plays: %d (PBs: %d)", playsThisSession, pbsThisSession)
        end
    }

    frame[#frame + 1] = LoadFont("Common Normal") .. {
        Name = "AverageAccuracy",
        InitCommand = function(self)
            self:halign(0):valign(0)
            self:xy(actuals.HeaderMTextLeftGap, actuals.HeaderMText3UpperGap)
            self:zoom(wheelHeaderMTextSize)
            self:maxwidth((actuals.BannerWidth - actuals.HeaderMTextLeftGap) / wheelHeaderMTextSize)
            self:settextf("Average Accuracy: %5.2f%%", accThisSession)
            self:diffusealpha(1)
            registerActorToColorConfigElement(self, "main", "PrimaryText")
        end,
        SetCommand = function(self)
            self:settextf("Average Accuracy: %5.2f%%", accThisSession)
        end
    }


    --params.width = params.width or 300
    --params.spacing = params.spacing or 1
    
    --local color = params.color or color("#FF00000")
    --local width = (params.width - intCount * params.spacing) / (#freqIntervals - 2)
    --local pos = width + params.spacing
    frame[#frame + 1] = (params.barBuilder or graphBuilder)(params)
    return frame
end