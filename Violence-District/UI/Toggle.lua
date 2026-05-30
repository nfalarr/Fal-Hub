local Toggle = {}

function Toggle:Create(
    Parent,
    Name,
    Callback
)

    local Holder =
        Instance.new("Frame")

    Holder.Parent = Parent

    Holder.Size =
        UDim2.new(1,-5,0,45)

    Holder.BackgroundColor3 =
        Color3.fromRGB(24,24,24)

    Holder.BorderSizePixel = 0

    Instance.new(
        "UICorner",
        Holder
    ).CornerRadius =
        UDim.new(0,10)


    local Label =
        Instance.new("TextLabel")

    Label.Parent = Holder

    Label.BackgroundTransparency = 1

    Label.Position =
        UDim2.new(0,15,0,0)

    Label.Size =
        UDim2.new(0.7,0,1,0)

    Label.Text = Name

    Label.TextColor3 =
        Color3.new(1,1,1)

    Label.Font =
        Enum.Font.Gotham

    Label.TextSize = 14

    Label.TextXAlignment =
        Enum.TextXAlignment.Left


    local Button =
        Instance.new("TextButton")

    Button.Parent = Holder

    Button.Size =
        UDim2.new(0,55,0,28)

    Button.Position =
        UDim2.new(1,-70,0.5,-14)

    Button.Text = ""

    Button.BackgroundColor3 =
        Color3.fromRGB(40,40,40)

    Button.BorderSizePixel = 0

    Instance.new(
        "UICorner",
        Button
    ).CornerRadius =
        UDim.new(1,0)


    local Circle =
        Instance.new("Frame")

    Circle.Parent = Button

    Circle.Size =
        UDim2.new(0,22,0,22)

    Circle.Position =
        UDim2.new(0,3,0.5,-11)

    Circle.BackgroundColor3 =
        Color3.new(1,1,1)

    Circle.BorderSizePixel = 0

    Instance.new(
        "UICorner",
        Circle
    ).CornerRadius =
        UDim.new(1,0)


    local Enabled = false

    Button.MouseButton1Click:Connect(function()

        Enabled = not Enabled

        if Enabled then

            Button.BackgroundColor3 =
                Color3.new(1,1,1)

            Circle.Position =
                UDim2.new(
                    1,
                    -25,
                    0.5,
                    -11
                )

            Circle.BackgroundColor3 =
                Color3.fromRGB(
                    20,
                    20,
                    20
                )

        else

            Button.BackgroundColor3 =
                Color3.fromRGB(
                    40,
                    40,
                    40
                )

            Circle.Position =
                UDim2.new(
                    0,
                    3,
                    0.5,
                    -11
                )

            Circle.BackgroundColor3 =
                Color3.new(1,1,1)
        end

        Callback(Enabled)
    end)
end

return Toggle
