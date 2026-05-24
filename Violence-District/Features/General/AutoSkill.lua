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

------------------------------------------------
-- HANDLER
------------------------------------------------

local QTEHandler = {
    Monitoring = false,
    FrameConn = nil,
    UIConn = nil,
    Elements = nil
}

------------------------------------------------
-- INPUT
------------------------------------------------

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

------------------------------------------------
-- GET UI
------------------------------------------------

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

    return {
        frame = frame,
        needle = frame:FindFirstChild("Line"),
        target = frame:FindFirstChild("Goal")
    }
end

------------------------------------------------
-- PERFECT
------------------------------------------------

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

------------------------------------------------
-- STOP
------------------------------------------------

local function Stop()

    if QTEHandler.FrameConn then

        QTEHandler.FrameConn
        :Disconnect()

        QTEHandler.FrameConn = nil
    end

    QTEHandler.Monitoring = false
end

------------------------------------------------
-- UPDATE
------------------------------------------------

local function Update()

    if not Config.AutoSkill then

        Stop()

        return
    end

    local ui =
        QTEHandler.Elements

    if not ui
    or not ui.needle
    or not ui.target then

        Stop()

        return
    end

    if InZone(
        ui.needle.Rotation,
        ui.target.Rotation
    ) then

        PressSpace()

        Stop()
    end
end

------------------------------------------------
-- START
------------------------------------------------

local function Start()

    if QTEHandler.Monitoring then
        return
    end

    QTEHandler.Monitoring = true

    QTEHandler.FrameConn =
        RunService.Heartbeat
        :Connect(Update)
end

------------------------------------------------
-- VISIBLE
------------------------------------------------

local function Visible()

    if not Config.AutoSkill then

        Stop()

        return
    end

    local ui =
        QTEHandler.Elements

    if ui
    and ui.frame
    and ui.frame.Visible then

        Start()

    else

        Stop()
    end
end

------------------------------------------------
-- SETUP
------------------------------------------------

local function Setup()

    pcall(function()

        Stop()

        if QTEHandler.UIConn then

            QTEHandler.UIConn
            :Disconnect()

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
            :Connect(Visible)
    end)
end

------------------------------------------------
-- RECONNECT
------------------------------------------------

task.spawn(function()

    while task.wait(2) do

        if Config.AutoSkill then

            if not QTEHandler.Elements then

                Setup()
            end
        end
    end
end)