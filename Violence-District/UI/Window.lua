local UIS =
    game:GetService(
        "UserInputService"
    )

local Window = {}

function Window:Create(title)

    if game.CoreGui:FindFirstChild(
        "FalHub"
    ) then

        game.CoreGui.FalHub:Destroy()
    end


    local ScreenGui =
        Instance.new("ScreenGui")

    ScreenGui.Name = "FalHub"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false


    local Main =
        Instance.new("Frame")

    Main.Parent = ScreenGui

    Main.Size =
        UDim2.new(0,520,0,350)

    Main.Position =
        UDim2.new(
            0.5,
            -260,
            0.5,
            -175
        )

    Main.BackgroundColor3 =
        Color3.fromRGB(15,15,15)

    Main.BorderSizePixel = 0

    Instance.new(
        "UICorner",
        Main
    ).CornerRadius =
        UDim.new(0,12)


    local Top =
        Instance.new("Frame")

    Top.Parent = Main

    Top.Size =
        UDim2.new(1,0,0,45)

    Top.BackgroundColor3 =
        Color3.fromRGB(20,20,20)

    Top.BorderSizePixel = 0

    Instance.new(
        "UICorner",
        Top
    ).CornerRadius =
        UDim.new(0,12)


    local Title =
        Instance.new("TextLabel")

    Title.Parent = Top

    Title.BackgroundTransparency = 1

    Title.Position =
        UDim2.new(0,15,0,0)

    Title.Size =
        UDim2.new(0,250,1,0)

    Title.Text = title

    Title.TextColor3 =
        Color3.new(1,1,1)

    Title.Font =
        Enum.Font.GothamBold

    Title.TextSize = 15

    Title.TextXAlignment =
        Enum.TextXAlignment.Left


    local function CreateButton(
        txt,
        pos,
        color
    )

        local b =
            Instance.new(
                "TextButton"
            )

        b.Parent = Top

        b.Size =
            UDim2.new(0,30,0,30)

        b.Position = pos

        b.Text = txt

        b.Font =
            Enum.Font.GothamBold

        b.TextSize = 14

        b.TextColor3 = color

        b.BackgroundColor3 =
            Color3.fromRGB(
                35,
                35,
                35
            )

        b.BorderSizePixel = 0

        Instance.new(
            "UICorner",
            b
        ).CornerRadius =
            UDim.new(0,8)

        return b
    end


    local Minimize =
        CreateButton(
            "_",
            UDim2.new(
                1,
                -75,
                0.5,
                -15
            ),
            Color3.new(1,1,1)
        )

    local Close =
        CreateButton(
            "X",
            UDim2.new(
                1,
                -38,
                0.5,
                -15
            ),
            Color3.fromRGB(
                255,
                100,
                100
            )
        )


    local Sidebar =
        Instance.new("Frame")

    Sidebar.Parent = Main

    Sidebar.Position =
        UDim2.new(0,10,0,55)

    Sidebar.Size =
        UDim2.new(0,120,1,-65)

    Sidebar.BackgroundColor3 =
        Color3.fromRGB(18,18,18)

    Sidebar.BorderSizePixel = 0

    Instance.new(
        "UICorner",
        Sidebar
    ).CornerRadius =
        UDim.new(0,10)

    local SidebarLayout =
        Instance.new(
            "UIListLayout"
        )

    SidebarLayout.Parent =
        Sidebar

    SidebarLayout.Padding =
        UDim.new(0,8)


    local Pages =
        Instance.new("Frame")

    Pages.Parent = Main

    Pages.Position =
        UDim2.new(0,140,0,55)

    Pages.Size =
        UDim2.new(1,-150,1,-65)

    Pages.BackgroundTransparency = 1


    local dragging = false
    local dragStart
    local startPos

    Top.InputBegan:Connect(function(input)

        if input.UserInputType
        == Enum.UserInputType.MouseButton1 then

            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)

    UIS.InputEnded:Connect(function(input)

        if input.UserInputType
        == Enum.UserInputType.MouseButton1 then

            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)

        if dragging
        and input.UserInputType
        == Enum.UserInputType.MouseMovement then

            local delta =
                input.Position
                - dragStart

            Main.Position =
                UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset
                    + delta.X,

                    startPos.Y.Scale,
                    startPos.Y.Offset
                    + delta.Y
                )
        end
    end)


    local minimized = false

    Minimize.MouseButton1Click:Connect(function()

        minimized = not minimized

        if minimized then

            Sidebar.Visible = false
            Pages.Visible = false

            Main.Size =
                UDim2.new(
                    0,
                    520,
                    0,
                    45
                )

        else

            Sidebar.Visible = true
            Pages.Visible = true

            Main.Size =
                UDim2.new(
                    0,
                    520,
                    0,
                    350
                )
        end
    end)


    Close.MouseButton1Click:Connect(function()

        ScreenGui:Destroy()

    end)


    return {
        Gui = ScreenGui,
        Main = Main,
        Sidebar = Sidebar,
        Pages = Pages
    }
end

return Window
