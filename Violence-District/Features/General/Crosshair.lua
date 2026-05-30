local RunService =
    game:GetService(
        "RunService"
    )

local Config =
    require(
        script.Parent
        .Parent
        .Settings
        .Config
    )


local Dot =
    Drawing.new("Circle")

Dot.Visible = false
Dot.Radius = 2
Dot.Filled = true
Dot.NumSides = 20

Dot.Color =
    Color3.fromRGB(
        255,
        255,
        255
    )

Dot.Transparency = 1


RunService.RenderStepped:Connect(function()

    if not Config.Crosshair then

        Dot.Visible = false

        return
    end

    local Camera =
        workspace.CurrentCamera

    local Center =
        Camera.ViewportSize / 2

    Dot.Position =
        Vector2.new(
            Center.X,
            Center.Y
        )

    Dot.Visible = true
end)

return true
