local Players =
    game:GetService(
        "Players"
    )

local LocalPlayer =
    Players.LocalPlayer

local Config =
    require(
        script.Parent
        .Parent
        .Settings
        .Config
    )

------------------------------------------------
-- CACHE
------------------------------------------------

local Cache = {}

------------------------------------------------
-- REMOVE
------------------------------------------------

local function RemoveESP(char)

    local esp = Cache[char]

    if esp then

        pcall(function()
            esp:Destroy()
        end)

        Cache[char] = nil
    end
end

------------------------------------------------
-- LOOP
------------------------------------------------

task.spawn(function()

    while task.wait(1) do

        if not Config.KillerESP then

            for char in pairs(Cache) do
                RemoveESP(char)
            end

            continue
        end

        for _,plr in ipairs(
            Players:GetPlayers()
        ) do

            if plr ~= LocalPlayer
            and plr.Character
            and plr.Team
            and tostring(plr.Team)
            == "Killer" then

                local char =
                    plr.Character

                if not Cache[char] then

                    local esp =
                        Instance.new(
                            "Highlight"
                        )

                    esp.FillTransparency = 1

                    esp.OutlineTransparency = 0.4

                    esp.OutlineColor =
                        Color3.fromRGB(
                            255,
                            0,
                            0
                        )

                    esp.DepthMode =
                        Enum.HighlightDepthMode
                        .AlwaysOnTop

                    esp.Parent = char

                    Cache[char] = esp
                end
            end
        end
    end
end)