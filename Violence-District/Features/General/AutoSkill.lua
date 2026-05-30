local Players =
    game:GetService(
        "Players"
    )

local RunService =
    game:GetService(
        "RunService"
    )

local VIM =
    game:GetService(
        "VirtualInputManager"
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


local QTEHandler = {
    Monitoring = false,
    FrameConn = nil,
    UIConn = nil,
    Elements = nil
}

local LastPrompt = nil
local LastSkillCheck = 0


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

    local pg =
        LocalPlayer
        :FindFirstChild(
            "PlayerGui"
        )

    if not pg then
        return nil
    end

    local prompt =
        pg:FindFirstChild(
            "SkillCheckPromptGui"
        )

    if not prompt then
        return nil
    end

    local frame =
        prompt:FindFirstChild(
            "Check"
        )

    if not frame then
        return nil
    end

    local needle =
        frame:FindFirstChild(
            "Line"
        )

    local target =
        frame:FindFirstChild(
            "Goal"
        )

    if not needle
    or not target then
        return nil
    end

    return {
        frame = frame,
        needle = needle,
        target = target
    }
end


local function InZone(
    needleAngle,
    targetAngle
)

    local needle =
        needleAngle % 360

    local target =
        targetAngle % 360

    local start =
        (target + 104) % 360

    local ending =
        (target + 114) % 360

    if start > ending then

        return
            needle >= start
            or needle <= ending
    end

    return
        needle >= start
        and needle <= ending
end


local function Stop()

    if QTEHandler.FrameConn then

        QTEHandler.FrameConn
        :Disconnect()

        QTEHandler.FrameConn = nil
    end

    QTEHandler.Monitoring = false
end


local function Update()

    if not Config.AutoSkill then

        Stop()

        return
    end

    local ui =
        QTEHandler.Elements

    if not ui
    or not ui.frame
    or not ui.needle
    or not ui.target then

        Stop()

        return
    end

    if not ui.frame.Parent then

        Stop()

        QTEHandler.Elements = nil

        return
    end

    if not ui.frame.Visible then
        return
    end

    if InZone(
        ui.needle.Rotation,
        ui.target.Rotation
    ) then

        if tick() - LastSkillCheck > 0.2 then

            LastSkillCheck = tick()

            PressSpace()
        end
    end
end


local function Start()

    if QTEHandler.Monitoring then
        return
    end

    QTEHandler.Monitoring = true

    QTEHandler.FrameConn =
        RunService.RenderStepped
        :Connect(Update)
end


local function Visible()

    if not Config.AutoSkill then

        Stop()

        return
    end

    local ui =
        QTEHandler.Elements

    if not ui
    or not ui.frame then

        Stop()

        return
    end

    if ui.frame.Visible then

        Start()

    else

        Stop()
    end
end


local function Setup()

    pcall(function()

        Stop()

        if QTEHandler.UIConn then

            QTEHandler.UIConn
            :Disconnect()

            QTEHandler.UIConn = nil
        end

        local ui = GetUI()

        if not ui then
            return
        end

        if LastPrompt == ui.frame then
            return
        end

        LastPrompt = ui.frame
        QTEHandler.Elements = ui

        QTEHandler.UIConn =
            ui.frame
            :GetPropertyChangedSignal(
                "Visible"
            )
            :Connect(Visible)

        if ui.frame.Visible then

            Start()
        end
    end)
end


local function Reconnect()

    if not Config.AutoSkill then
        return
    end

    local ui = GetUI()

    if not ui
    or not ui.frame then
        return
    end

    if LastPrompt == ui.frame then
        return
    end

    QTEHandler.Elements = nil

    Setup()
end


LocalPlayer.PlayerGui.ChildAdded:Connect(function(v)

    if not Config.AutoSkill then
        return
    end

    if v.Name == "SkillCheckPromptGui" then

        task.defer(Reconnect)
    end
end)

LocalPlayer.CharacterAdded:Connect(function()

    if Config.AutoSkill then

        task.defer(Reconnect)
    end
end)

workspace.ChildAdded:Connect(function(v)

    if Config.AutoSkill
    and v.Name == "Map" then

        task.defer(Reconnect)
    end
end)

task.spawn(function()

    while task.wait(1) do

        if Config.AutoSkill
        and not QTEHandler.Elements then

            Setup()
        end
    end
end)

return true
