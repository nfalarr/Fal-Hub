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

local ObjectESP = {}

local function GetRoot()

    local char =
        LocalPlayer.Character

    return char
        and char:FindFirstChild(
            "HumanoidRootPart"
        )
end

local function GetPart(obj)

    return obj:FindFirstChild(
        "HitBox"
    )
    or obj:FindFirstChildWhichIsA(
        "BasePart"
    )
end

local function GetDistance(part)

    local root =
        GetRoot()

    if not root
    or not part then
        return nil
    end

    return math.floor(
        (
            part.Position
            - root.Position
        ).Magnitude
    )
end

local function Matches(obj, exactNames, containsNames)

    local lowerName =
        obj.Name:lower()

    for _,name in ipairs(exactNames or {}) do

        if lowerName
        == name:lower() then
            return true
        end
    end

    for _,name in ipairs(containsNames or {}) do

        if lowerName:find(
            name:lower()
        ) then
            return true
        end
    end

    return false
end

local function CreateLabel(part, label, color)

    local gui =
        Instance.new(
            "BillboardGui"
        )

    gui.Size =
        UDim2.new(0,90,0,32)

    gui.StudsOffset =
        Vector3.new(0,3,0)

    gui.AlwaysOnTop = true
    gui.MaxDistance = 99999
    gui.Adornee = part
    gui.Parent = part

    local text =
        Instance.new(
            "TextLabel"
        )

    text.Parent = gui
    text.Size = UDim2.new(1,0,1,0)
    text.BackgroundTransparency = 1
    text.TextColor3 = color
    text.TextStrokeColor3 = Color3.new(0,0,0)
    text.TextStrokeTransparency = 0.25
    text.Font = Enum.Font.GothamBold
    text.TextSize = 12
    text.TextScaled = false
    text.Text = label

    return gui, text
end

local function Remove(cache, obj)

    local data =
        cache[obj]

    if not data then
        return
    end

    pcall(function()
        data.Highlight:Destroy()
    end)

    pcall(function()
        data.Gui:Destroy()
    end)

    cache[obj] = nil
end

function ObjectESP.Start(options)

    local cache = {}
    local connection

    local function Clear()

        for obj in pairs(cache) do

            Remove(
                cache,
                obj
            )
        end
    end

    local function Create(obj)

        if cache[obj]
        or not obj.Parent
        or not obj:IsA("Model")
        or not Matches(
            obj,
            options.ExactNames,
            options.ContainsNames
        ) then
            return
        end

        local part =
            GetPart(obj)

        if not part then
            return
        end

        local highlight =
            Instance.new(
                "Highlight"
            )

        highlight.FillColor =
            options.FillColor

        highlight.OutlineColor =
            options.OutlineColor

        highlight.FillTransparency =
            options.FillTransparency
            or 0.5

        highlight.OutlineTransparency = 0

        highlight.DepthMode =
            Enum.HighlightDepthMode
            .AlwaysOnTop

        highlight.Adornee = obj
        highlight.Parent = game.CoreGui

        local gui, text =
            CreateLabel(
                part,
                options.Label,
                options.OutlineColor
            )

        cache[obj] = {
            Highlight = highlight,
            Gui = gui,
            Text = text,
            Part = part
        }
    end

    local function UpdateLabels()

        for obj,data in pairs(cache) do

            if not obj
            or not obj.Parent
            or not data.Part
            or not data.Part.Parent then

                Remove(
                    cache,
                    obj
                )

                continue
            end

            local label =
                options.Label

            local distance =
                GetDistance(
                    data.Part
                )

            if distance then

                label =
                    label
                    .. "\n"
                    .. distance
                    .. "m"
            end

            data.Text.Text = label
        end
    end

    local function Scan()

        local map =
            workspace:FindFirstChild(
                "Map"
            )

        if not map then
            return
        end

        for _,obj in ipairs(
            map:GetDescendants()
        ) do

            Create(obj)
        end
    end

    task.spawn(function()

        while task.wait(1) do

            if not Config[
                options.ConfigKey
            ] then

                Clear()

                if connection then

                    connection:Disconnect()
                    connection = nil
                end

                continue
            end

            Scan()
            UpdateLabels()

            if not connection then

                local map =
                    workspace:FindFirstChild(
                        "Map"
                    )

                if map then

                    connection =
                        map.DescendantAdded
                        :Connect(function(obj)

                            task.defer(function()

                                Create(obj)
                            end)
                        end)
                end
            end
        end
    end)

    workspace.ChildRemoved:Connect(function(v)

        if v.Name == "Map" then

            Clear()
        end
    end)
end

return ObjectESP
