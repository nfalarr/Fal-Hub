local Tabs = {}

local CurrentY = 5

function Tabs:Create(
    Window,
    Name
)


    local Button =
        Instance.new("TextButton")

    Button.Parent =
        Window.Sidebar

    Button.Size =
        UDim2.new(1,-10,0,40)

    Button.Position =
        UDim2.new(0,5,0,CurrentY)

    CurrentY += 48

    Button.Text = Name

    Button.Font =
        Enum.Font.GothamBold

    Button.TextSize = 14

    Button.TextColor3 =
        Color3.new(1,1,1)

    Button.BackgroundColor3 =
        Color3.fromRGB(25,25,25)

    Button.BorderSizePixel = 0

    Instance.new(
        "UICorner",
        Button
    ).CornerRadius =
        UDim.new(0,8)


    local Page =
        Instance.new(
            "ScrollingFrame"
        )

    Page.Parent =
        Window.Pages

    Page.Size =
        UDim2.new(1,0,1,0)

    Page.CanvasSize =
        UDim2.new(0,0,0,0)

    Page.ScrollBarThickness = 0

    Page.BackgroundTransparency = 1

    Page.Visible = false


    local Layout =
        Instance.new(
            "UIListLayout"
        )

    Layout.Parent = Page

    Layout.Padding =
        UDim.new(0,8)


    Button.MouseButton1Click:Connect(function()

        for _,v in ipairs(
            Window.Pages:GetChildren()
        ) do

            if v:IsA(
                "ScrollingFrame"
            ) then

                v.Visible = false
            end
        end

        Page.Visible = true
    end)

    return Page
end

return Tabs
