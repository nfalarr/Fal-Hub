local Window =
    require(script.UI.Window)

local Tabs =
    require(script.UI.Tabs)

local Toggle =
    require(script.UI.Toggle)

local Config =
    require(
        script.Features
        .Settings
        .Config
    )


local UI =
    Window:Create(
        "Fal Hub"
    )

UI.Gui.Destroying:Connect(function()

    for key in pairs(Config) do

        Config[key] = false
    end
end)


local VisualsPage =
    Tabs:Create(
        UI,
        "Visuals"
    )

local GeneralPage =
    Tabs:Create(
        UI,
        "General"
    )

local SettingsPage =
    Tabs:Create(
        UI,
        "Settings"
    )

VisualsPage.Visible = true


Toggle:Create(
    VisualsPage,
    "Survivor ESP",
    function(v)

        Config.SurvivorESP = v
    end
)

Toggle:Create(
    VisualsPage,
    "Killer ESP",
    function(v)

        Config.KillerESP = v
    end
)

Toggle:Create(
    VisualsPage,
    "Generator ESP",
    function(v)

        Config.GeneratorESP = v
    end
)

Toggle:Create(
    VisualsPage,
    "Gate ESP",
    function(v)

        Config.GateESP = v
    end
)

Toggle:Create(
    VisualsPage,
    "Hook ESP",
    function(v)

        Config.HookESP = v
    end
)

Toggle:Create(
    VisualsPage,
    "Pallet ESP",
    function(v)

        Config.PalletESP = v
    end
)

Toggle:Create(
    VisualsPage,
    "Window ESP",
    function(v)

        Config.WindowESP = v
    end
)


Toggle:Create(
    GeneralPage,
    "Crosshair",
    function(v)

        Config.Crosshair = v
    end
)

Toggle:Create(
    GeneralPage,
    "Auto Skill Check",
    function(v)

        Config.AutoSkill = v
    end
)


require(
    script.Features
    .General
    .Crosshair
)

require(
    script.Features
    .General
    .AutoSkill
)

require(
    script.Features
    .Visuals
    .SurvivorESP
)

require(
    script.Features
    .Visuals
    .KillerESP
)

require(
    script.Features
    .Visuals
    .GeneratorESP
)

require(
    script.Features
    .Visuals
    .GateESP
)

require(
    script.Features
    .Visuals
    .HookESP
)

require(
    script.Features
    .Visuals
    .PalletESP
)

require(
    script.Features
    .Visuals
    .WindowESP
)
