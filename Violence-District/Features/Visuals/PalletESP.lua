local ObjectESP =
    require(
        script.Parent
        .ObjectESP
    )

ObjectESP.Start({
    ConfigKey = "PalletESP",
    ExactNames = {
        "Palletwrong"
    },
    ContainsNames = {
        "Pallet"
    },
    Label = "PALLET",
    FillColor = Color3.fromRGB(180,140,70),
    OutlineColor = Color3.fromRGB(255,210,130),
    FillTransparency = 0.5
})

return true
