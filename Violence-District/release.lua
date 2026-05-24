# Release.lua

```lua
------------------------------------------------
-- SERVICES
------------------------------------------------

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer

------------------------------------------------
-- CONFIG
------------------------------------------------

local Config = {

    ------------------------------------------------
    -- GENERAL
    ------------------------------------------------

    Crosshair = false,
    AutoSkill = false,

    ------------------------------------------------
    -- VISUALS
    ------------------------------------------------

    SurvivorESP = false,
    KillerESP = false,
    GeneratorESP = false,
    GateESP = false,
    HookESP = false,
    PalletESP = false,
    WindowESP = false
}

------------------------------------------------
-- GUI
------------------------------------------------

if game.CoreGui:FindFirstChild("FalHub") then
    game.CoreGui.FalHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FalHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

------------------------------------------------
-- MAIN
------------------------------------------------

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,520,0,350)
Main.Position = UDim2.new(0.5,-260,0.5,-175)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.BorderSizePixel = 0

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

------------------------------------------------
-- TOPBAR
------------------------------------------------

local Top = Instance.new("Frame")
Top.Parent = Main
Top.Size = UDim2.new(1,0,0,45)
Top.BackgroundColor3 = Color3.fromRGB(20,20,20)
Top.BorderSizePixel = 0

Instance.new("UICorner", Top).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel")
Title.Parent = Top
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,15,0,0)
Title.Size = UDim2.new(0,250,1,0)
Title.Text = "Fal Hub"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left

------------------------------------------------
-- BUTTONS
------------------------------------------------

local function CreateButton(txt,pos,color)

    local b = Instance.new("TextButton")

    b.Parent = Top
    b.Size = UDim2.new(0,30,0,30)
    b.Position = pos
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = color
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.BorderSizePixel = 0

    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

    return b
end

local Minimize = CreateButton(
    "_",
    UDim2.new(1,-75,0.5,-15),
    Color3.new(1,1,1)
)

local Close = CreateButton(
    "X",
    UDim2.new(1,-38,0.5,-15),
    Color3.fromRGB(255,100,100)
)

------------------------------------------------
-- SIDEBAR
------------------------------------------------

local Sidebar = Instance.new("Frame")
Sidebar.Parent = Main
Sidebar.Position = UDim2.new(0,10,0,55)
Sidebar.Size = UDim2.new(0,120,1,-65)
Sidebar.BackgroundColor3 = Color3.fromRGB(18,18,18)
Sidebar.BorderSizePixel = 0

Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0,10)

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.Padding = UDim.new(0,8)

------------------------------------------------
-- PAGES
------------------------------------------------

local Pages = Instance.new("Frame")
Pages.Parent = Main
Pages.Position = UDim2.new(0,140,0,55)
Pages.Size = UDim2.new(1,-150,1,-65)
Pages.BackgroundTransparency = 1

------------------------------------------------
-- TABS
------------------------------------------------

local function CreateTab(name)

    local Button = Instance.new("TextButton")
    Button.Parent = Sidebar
    Button.Size = UDim2.new(1,-10,0,40)
    Button.Text = name
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 14
    Button.TextColor3 = Color3.new(1,1,1)
    Button.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Button.BorderSizePixel = 0

    Instance.new("UICorner", Button).CornerRadius = UDim.new(0,8)

    local Page = Instance.new("ScrollingFrame")
    Page.Parent = Pages
    Page.Size = UDim2.new(1,0,1,0)
    Page.CanvasSize = UDim2.new(0,0,0,0)
    Page.ScrollBarThickness = 0
    Page.BackgroundTransparency = 1
    Page.Visible = false

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0,8)

    Button.MouseButton1Click:Connect(function()

        for _,v in ipairs(Pages:GetChildren()) do
            if v:IsA("ScrollingFrame") then
                v.Visible = false
            end
        end

        Page.Visible = true
    end)

    return Page
end

local VisualsPage = CreateTab("Visuals")
local GeneralPage = CreateTab("General")
local SettingsPage = CreateTab("Settings")

VisualsPage.Visible = true

------------------------------------------------
-- TOGGLE
------------------------------------------------

local function CreateToggle(parent,name,callback)

    local Holder = Instance.new("Frame")
    Holder.Parent = parent
    Holder.Size = UDim2.new(1,-5,0,45)
    Holder.BackgroundColor3 = Color3.fromRGB(24,24,24)
    Holder.BorderSizePixel = 0

    Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,10)

    local Label = Instance.new("TextLabel")
    Label.Parent = Holder
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0,15,0,0)
    Label.Size = UDim2.new(0.7,0,1,0)
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Button = Instance.new("TextButton")
    Button.Parent = Holder
    Button.Size = UDim2.new(0,55,0,28)
    Button.Position = UDim2.new(1,-70,0.5,-14)
    Button.Text = ""
    Button.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Button.BorderSizePixel = 0

    Instance.new("UICorner", Button).CornerRadius = UDim.new(1,0)

    local Circle = Instance.new("Frame")
    Circle.Parent = Button
    Circle.Size = UDim2.new(0,22,0,22)
    Circle.Position = UDim2.new(0,3,0.5,-11)
    Circle.BackgroundColor3 = Color3.new(1,1,1)
    Circle.BorderSizePixel = 0

    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

    local Enabled = false

    Button.MouseButton1Click:Connect(function()

        Enabled = not Enabled

        if Enabled then

            Button.BackgroundColor3 = Color3.new(1,1,1)

            Circle.Position = UDim2.new(1,-25,0.5,-11)

            Circle.BackgroundColor3 = Color3.fromRGB(20,20,20)

        else

            Button.BackgroundColor3 = Color3.fromRGB(40,40,40)

            Circle.Position = UDim2.new(0,3,0.5,-11)

            Circle.BackgroundColor3 = Color3.new(1,1,1)
        end

        callback(Enabled)
    end)
end

------------------------------------------------
-- DRAGGING
------------------------------------------------

local dragging = false
local dragStart
local startPos

Top.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UIS.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)

    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

------------------------------------------------
-- MINIMIZE
------------------------------------------------

local minimized = false

Minimize.MouseButton1Click:Connect(function()

    minimized = not minimized

    if minimized then

        Sidebar.Visible = false
        Pages.Visible = false

        Main.Size = UDim2.new(0,520,0,45)

    else

        Sidebar.Visible = true
        Pages.Visible = true

        Main.Size = UDim2.new(0,520,0,350)
    end
end)

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

------------------------------------------------
-- CROSSHAIR
------------------------------------------------

local Dot = Drawing.new("Circle")
Dot.Visible = false
Dot.Radius = 2
Dot.Filled = true
Dot.NumSides = 20
Dot.Color = Color3.new(1,1,1)
Dot.Transparency = 1

RunService.RenderStepped:Connect(function()

    if not Config.Crosshair then

        Dot.Visible = false

        return
    end

    local Camera = workspace.CurrentCamera
    local Center = Camera.ViewportSize / 2

    Dot.Position = Vector2.new(Center.X,Center.Y)
    Dot.Visible = true
end)

------------------------------------------------
-- AUTO SKILL CHECK
------------------------------------------------

local QTEHandler = {
    Monitoring = false,
    FrameConn = nil,
    UIConn = nil,
    Elements = nil
}

local function PressSpace()

    VIM:SendKeyEvent(
        true,
        Enum.KeyCode.Space,
        false,
        game
    )

    task.defer(function()

        VIM:SendKeyEvent(
            false,
            Enum.KeyCode.Space,
            false,
            game
        )
    end)
end

local function GetUI()

    local pg = LocalPlayer:FindFirstChild("PlayerGui")

    if not pg then
        return nil
    end

    local prompt = pg:FindFirstChild("SkillCheckPromptGui")

    if not prompt then
        return nil
    end

    local frame = prompt:FindFirstChild("Check")

    if not frame then
        return nil
    end

    return {
        frame = frame,
        needle = frame:FindFirstChild("Line"),
        target = frame:FindFirstChild("Goal")
    }
end

local function InZone(needleAngle,targetAngle)

    local needle = needleAngle % 360
    local target = targetAngle % 360

    local start = (target + 104) % 360
    local ending = (target + 114) % 360

    if start > ending then

        return needle >= start
            or needle <= ending
    end

    return needle >= start
        and needle <= ending
end

local function StopSkill()

    if QTEHandler.FrameConn then

        QTEHandler.FrameConn:Disconnect()
        QTEHandler.FrameConn = nil
    end

    QTEHandler.Monitoring = false
end

local function UpdateSkill()

    if not Config.AutoSkill then

        StopSkill()

        return
    end

    local ui = QTEHandler.Elements

    if not ui
    or not ui.needle
    or not ui.target then

        StopSkill()

        return
    end

    if InZone(
        ui.needle.Rotation,
        ui.target.Rotation
    ) then

        PressSpace()
        StopSkill()
    end
end

local function StartSkill()

    if QTEHandler.Monitoring then
        return
    end

    QTEHandler.Monitoring = true

    QTEHandler.FrameConn =
        RunService.Heartbeat
        :Connect(UpdateSkill)
end

local function VisibleSkill()

    if not Config.AutoSkill then

        StopSkill()

        return
    end

    local ui = QTEHandler.Elements

    if ui and ui.frame and ui.frame.Visible then

        StartSkill()

    else

        StopSkill()
    end
end

local function SetupSkill()

    pcall(function()

        StopSkill()

        if QTEHandler.UIConn then

            QTEHandler.UIConn:Disconnect()
            QTEHandler.UIConn = nil
        end

        local ui = GetUI()

        if not ui
        or not ui.frame
        or not ui.needle
        or not ui.target then
            return
        end

        QTEHandler.Elements = ui

        QTEHandler.UIConn =
            ui.frame
            :GetPropertyChangedSignal(
                "Visible"
            )
            :Connect(VisibleSkill)
    end)
end

task.spawn(function()

    while task.wait(2) do

        if Config.AutoSkill then

            if not QTEHandler.Elements then
                SetupSkill()
            end
        end
    end
end)

------------------------------------------------
-- TOGGLES
------------------------------------------------

CreateToggle(
    GeneralPage,
    "Crosshair",
    function(v)
        Config.Crosshair = v
    end
)

CreateToggle(
    GeneralPage,
    "Auto Skill Check",
    function(v)
        Config.AutoSkill = v
    end
)

CreateToggle(
    VisualsPage,
    "Survivor ESP",
    function(v)
        Config.SurvivorESP = v
    end
)

CreateToggle(
    VisualsPage,
    "Killer ESP",
    function(v)
        Config.KillerESP = v
    end
)

CreateToggle(
    VisualsPage,
    "Generator ESP",
    function(v)
        Config.GeneratorESP = v
    end
)

------------------------------------------------
-- SURVIVOR ESP
------------------------------------------------

local SurvivorCache = {}

local function RemoveSurvivorESP(char)

    local esp = SurvivorCache[char]

    if esp then

        pcall(function()
            esp:Destroy()
        end)

        SurvivorCache[char] = nil
    end
end

task.spawn(function()

    while task.wait(1) do

        if not Config.SurvivorESP then

            for char in pairs(
                SurvivorCache
            ) do

                RemoveSurvivorESP(char)
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
            == "Survivors" then

                local char =
                    plr.Character

                if not SurvivorCache[char] then

                    local esp =
                        Instance.new(
                            "Highlight"
                        )

                    esp.FillTransparency = 1

                    esp.OutlineTransparency = 0.4

                    esp.OutlineColor =
                        Color3.fromRGB(
                            255,
                            255,
                            255
                        )

                    esp.DepthMode =
                        Enum.HighlightDepthMode
                        .AlwaysOnTop

                    esp.Parent = char

                    SurvivorCache[char] = esp
                end
            end
        end
    end
end)

------------------------------------------------
-- KILLER ESP
------------------------------------------------

local KillerCache = {}

local function RemoveKillerESP(char)

    local esp = KillerCache[char]

    if esp then

        pcall(function()
            esp:Destroy()
        end)

        KillerCache[char] = nil
    end
end

task.spawn(function()

    while task.wait(1) do

        if not Config.KillerESP then

            for char in pairs(
                KillerCache
            ) do

                RemoveKillerESP(char)
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

                if not KillerCache[char] then

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

                    KillerCache[char] = esp
                end
            end
        end
    end
end)

------------------------------------------------
-- GENERATOR ESP
------------------------------------------------

local GeneratorCache = {}

local function RemoveGeneratorESP(obj)

    local data =
        GeneratorCache[obj]

    if data then

        pcall(function()
            data.Highlight:Destroy()
        end)

        pcall(function()
            data.Gui:Destroy()
        end)

        GeneratorCache[obj] = nil
    end
end

local function CreateGeneratorESP(obj)

    if GeneratorCache[obj] then
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

    GeneratorCache[obj] = {
        Highlight = esp,
        Gui = gui,
        Text = txt
    }

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

            RemoveGeneratorESP(obj)

            return
        end

        local cache =
            GeneratorCache[obj]

        if cache then

            cache.Text.Text =
                new .. "%"
        end
    end)
end

task.spawn(function()

    while task.wait(2) do

        if not Config.GeneratorESP then

            for obj in pairs(
                GeneratorCache
            ) do

                RemoveGeneratorESP(obj)
            end

            continue
        end

        local map =
            workspace:FindFirstChild(
                "Map"
            )

        if not map then
            continue
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

                CreateGeneratorESP(obj)
            end
        end
    end
end)

------------------------------------------------
-- SIMPLE OBJECT ESP
------------------------------------------------

local function CreateObjectESP(
    configName,
    keyword,
    color
)

    local Cache = {}

    local function RemoveESP(obj)

        local esp = Cache[obj]

        if esp then

            pcall(function()
                esp:Destroy()
            end)

            Cache[obj] = nil
        end
    end

    local function CreateESP(obj)

        if Cache[obj] then
            return
        end

        local esp =
            Instance.new(
                "Highlight"
            )

        esp.FillTransparency = 1

        esp.OutlineTransparency = 0.35

        esp.OutlineColor = color

        esp.DepthMode =
            Enum.HighlightDepthMode
            .AlwaysOnTop

        esp.Parent = obj

        Cache[obj] = esp
    end

    task.spawn(function()

        while task.wait(2) do

            if not Config[configName] then

                for obj in pairs(Cache) do
                    RemoveESP(obj)
                end

                continue
            end

            local map =
                workspace
                :FindFirstChild(
                    "Map"
                )

            if not map then
                continue
            end

            for _,obj in ipairs(
                map:GetDescendants()
            ) do

                if obj:IsA("Model")
                and tostring(obj.Name)
                :lower()
                :find(keyword) then

                    CreateESP(obj)
                end
            end
        end
    end)
end

------------------------------------------------
-- GATE ESP
------------------------------------------------

CreateObjectESP(
    "GateESP",
    "gate",
    Color3.fromRGB(
        0,
        255,
        120
    )
)

------------------------------------------------
-- HOOK ESP
------------------------------------------------

CreateObjectESP(
    "HookESP",
    "hook",
    Color3.fromRGB(
        255,
        80,
        80
    )
)

------------------------------------------------
-- PALLET ESP
------------------------------------------------

CreateObjectESP(
    "PalletESP",
    "pallet",
    Color3.fromRGB(
        255,
        200,
        0
    )
)

------------------------------------------------
-- WINDOW ESP
------------------------------------------------

CreateObjectESP(
    "WindowESP",
    "window",
    Color3.fromRGB(
        0,
        170,
        255
    )
)
