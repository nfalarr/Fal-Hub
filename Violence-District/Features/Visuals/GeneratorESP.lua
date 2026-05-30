local Config =
    require(
        script.Parent
        .Parent
        .Settings
        .Config
    )


local Cache = {}
local Connection


local function RemoveESP(obj)

    local data = Cache[obj]

    if data then

        pcall(function()
            data.Connection:Disconnect()
        end)

        pcall(function()
            data.Highlight:Destroy()
        end)

        pcall(function()
            data.Gui:Destroy()
        end)

        Cache[obj] = nil
    end
end


local function CreateESP(obj)

    if Cache[obj] then
        return
    end

    if not obj.Parent then
        return
    end

    local progress =
        obj:GetAttribute(
            "RepairProgress"
        )

    if typeof(progress)
    ~= "number" then
        return
    end

    if progress >= 99.5 then
        return
    end

    local part =
        obj:FindFirstChild(
            "HitBox"
        )
        or obj:FindFirstChildWhichIsA(
            "BasePart"
        )

    if not part then
        return
    end


    local esp =
        Instance.new("Highlight")

    esp.FillTransparency = 1

    esp.OutlineTransparency = 0.35

    esp.OutlineColor =
        Color3.fromRGB(
            255,
            255,
            255
        )

    esp.DepthMode =
        Enum.HighlightDepthMode
        .AlwaysOnTop

    esp.Adornee = obj
    esp.Parent = game.CoreGui


    local gui =
        Instance.new(
            "BillboardGui"
        )

    gui.Size =
        UDim2.new(0,55,0,24)

    gui.StudsOffset =
        Vector3.new(0,3,0)

    gui.AlwaysOnTop = true
    gui.MaxDistance = 99999

    gui.Adornee = part
    gui.Parent = part


    local bg =
        Instance.new("Frame")

    bg.Parent = gui

    bg.Size =
        UDim2.new(1,0,1,0)

    bg.BackgroundColor3 =
        Color3.fromRGB(
            15,
            15,
            15
        )

    bg.BackgroundTransparency = 0.05
    bg.BorderSizePixel = 0

    Instance.new(
        "UICorner",
        bg
    ).CornerRadius =
        UDim.new(1,0)


    local stroke =
        Instance.new(
            "UIStroke"
        )

    stroke.Parent = bg

    stroke.Color =
        Color3.fromRGB(
            40,
            40,
            40
        )

    stroke.Thickness = 1


    local txt =
        Instance.new(
            "TextLabel"
        )

    txt.Parent = bg

    txt.Size =
        UDim2.new(1,0,1,0)

    txt.BackgroundTransparency = 1

    txt.TextColor3 =
        Color3.new(1,1,1)

    txt.Font =
        Enum.Font.GothamBold

    txt.TextSize = 14
    txt.TextScaled = false
    txt.TextStrokeTransparency = 1

    txt.Text =
        math.floor(progress + 0.5)
        .. "%"


    local attrConnection =
        obj:GetAttributeChangedSignal(
        "RepairProgress"
    ):Connect(function()

        if not Config.GeneratorESP then
            return
        end

        local new =
            obj:GetAttribute(
                "RepairProgress"
            )

        if typeof(new)
        ~= "number" then
            return
        end

        new =
            math.clamp(
                math.floor(new + 0.5),
                0,
                100
            )

        if new >= 99.5 then

            local cache =
                Cache[obj]

            if cache then

                cache.Text.Text =
                    "100%"
            end

            task.delay(0.3,function()

                RemoveESP(obj)

            end)

            return
        end

        local cache =
            Cache[obj]

        if cache then

            cache.Text.Text =
                new .. "%"
        end
    end)


    Cache[obj] = {
        Highlight = esp,
        Gui = gui,
        Text = txt,
        Connection = attrConnection
    }
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

        local progress =
            obj:GetAttribute(
                "RepairProgress"
            )

        if obj:IsA("Model")
        and typeof(progress)
        == "number"
        and progress < 99.5 then

            CreateESP(obj)
        end
    end
end


local function Clear()

    for obj in pairs(Cache) do

        RemoveESP(obj)
    end
end


task.spawn(function()

    while task.wait(1) do

        if not Config.GeneratorESP then

            Clear()

            if Connection then

                Connection:Disconnect()

                Connection = nil
            end

            continue
        end

        if not Connection then

            Scan()

            local map =
                workspace
                :FindFirstChild(
                    "Map"
                )

            if map then

                Connection =
                    map.DescendantAdded
                    :Connect(function(obj)

                    task.defer(function()

                    local progress =
                        obj:GetAttribute(
                            "RepairProgress"
                        )

                    if obj:IsA(
                        "Model"
                    )
                    and typeof(progress)
                    == "number"
                    and progress < 99.5 then

                        CreateESP(obj)
                    end
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

return true
