local ObjectESP =
    require(
        script.Parent
        .ObjectESP
    )

ObjectESP.Start({
    ConfigKey = "HookESP",
    ExactNames = {
        "Hook"
    },
    Label = "HOOK",
    FillColor = Color3.fromRGB(180,60,60),
    OutlineColor = Color3.fromRGB(255,100,100),
    FillTransparency = 0.5
})

return true
