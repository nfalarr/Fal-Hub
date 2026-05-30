local ObjectESP =
    require(
        script.Parent
        .ObjectESP
    )

ObjectESP.Start({
    ConfigKey = "WindowESP",
    ExactNames = {
        "Window"
    },
    Label = "WINDOW",
    FillColor = Color3.fromRGB(60,140,200),
    OutlineColor = Color3.fromRGB(120,200,255),
    FillTransparency = 0.5
})

return true
