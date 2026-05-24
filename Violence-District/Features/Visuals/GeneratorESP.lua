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
local Connection

------------------------------------------------
-- REMOVE
------------------------------------------------

local function RemoveESP(obj)

    local data = Cache[obj]

    if data then

        pcall(function()
            data.Highlight:Destroy()
        end)

        pcall(function()
            data.Gui:Destroy()
        end)

        Cache[obj] = nil
    end
end

------------------------------------------------
-- CREATE
------------------------------------------------

local function CreateESP(obj)

    if Cache[obj] then
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

    if progress >= 100 then
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

    ------------------------------------------------
    -- HIGHLIGHT
    ------------------------------------------------

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

    esp.Parent = obj

    ------------------------------------------------
    -- GUI
    ------------------------------------------------

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

    ------------------------------------------------
    -- BG
    ------------------------------------------------

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

    bg.BorderSizePixel = 0

    Instance.new(
        "UICorner",
        bg
    ).CornerRadius =
        UDim.new(1,0)

    ------------------------------------------------
    -- STROKE
    ------------------------------------------------

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

    ------------------------------------------------
    -- TEXT
    ------------------------------------------------

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

    txt.Text =
        math.floor(progress + 0.5)
        .. "%"

    ------------------------------------------------
    -- CACHE
    ------------------------------------------------

    Cache[obj] = {
        Highlight = esp,
        Gui = gui,
        Text = txt
    }

    ------------------------------------------------
    -- UPDATE
    ------------------------------------------------

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
            math.floor(new + 0.5)

        if new >= 100 then

            RemoveESP(obj)

            return
        end

        local cache =
            Cache[obj]

        if cache then

            cache.Text.Text =
                new .. "%"
        end
    end)
end

------------------------------------------------
-- SCAN
------------------------------------------------

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
        and progress < 100 then

            CreateESP(obj)
        end
    end
end

------------------------------------------------
-- CLEAR
------------------------------------------------

local function Clear()

    for obj in pairs(Cache) do

        RemoveESP(obj)
    end
end

------------------------------------------------
-- LOOP
------------------------------------------------

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

                    task.wait(0.1)

                    local progress =
                        obj:GetAttribute(
                            "RepairProgress"
                        )

                    if obj:IsA(
                        "Model"
                    )
                    and typeof(progress)
                    == "number"
                    and progress < 100 then

                        CreateESP(obj)
                    end
                end)
            end
        end
    end
end)