local ObjectESP =
    require(
        script.Parent
        .ObjectESP
    )

ObjectESP.Start({
    ConfigKey = "GateESP",
    ExactNames = {
        "Gate"
    },
    Label = "GATE",
    FillColor = Color3.fromRGB(150,150,170),
    OutlineColor = Color3.fromRGB(220,220,255),
    FillTransparency = 0.5
})

return true
