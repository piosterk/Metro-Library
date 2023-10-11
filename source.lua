local MetroLibrary = {}

local TweenService = game:GetService("TweenService")

MetroLibrary.Mouse = game.Players.LocalPlayer:GetMouse()

function MetroLibrary:Tween(Object, Time, EasingS, EasingD, Value)
    local newTween = TweenService:Create(Object, TweenInfo.new(Time, EasingS, EasingD), Value)
    newTween:Play()

    return newTween
end

function MetroLibrary:Tweens(Array)
    local Tweens = {}

    for _, Tween in pairs(Array) do
        local newTween = MetroLibrary:Tween(unpack(Tween))

        table.insert(Tweens, newTween)
    end

    return Tweens
end

function MetroLibrary:OnClick(GuiBase, Callback)
    if GuiBase:IsA("GuiBase2d") then
        GuiBase.Active = true
        GuiBase.InputBegan:Connect(
            function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Callback()
                end
            end
        )
    end
end

if shared.__Metro then
    shared.__Metro:Destroy()
    shared.__Metro = nil
end

local Metro_GUI = Instance.new("ScreenGui")
Metro_GUI.Name = "Metro_GUI"
Metro_GUI.Parent = (checkcaller and checkcaller()) and game.CoreGui or game.Players.LocalPlayer.PlayerGui
Metro_GUI.ResetOnSpawn = false
Metro_GUI.ZIndexBehavior = Enum.ZIndexBehavior.Global

shared.__Metro = Metro_GUI

local function makeRipple(Base, Color)
    if Base:IsA("GuiBase2d") then
        Base.ClipsDescendants = true

        local Circle = Instance.new("Frame")
        Circle.Name = "Circle"
        Circle.AnchorPoint = Vector2.new(0.5, 0.5)
        Circle.BackgroundColor3 = Color
        Circle.BackgroundTransparency = 0.5
        Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Circle.BorderSizePixel = 0
        Circle.Parent = Base

        local CircleCorner = Instance.new("UICorner")
        CircleCorner.Name = "CircleCorner"
        CircleCorner.CornerRadius = UDim.new(1, 0)
        CircleCorner.Parent = Circle

        local CircleRatioConstraint = Instance.new("UIAspectRatioConstraint")
        CircleRatioConstraint.Name = "CircleRatioConstraint"
        CircleRatioConstraint.Parent = Circle

        Circle.Position =
            UDim2.new(
            0,
            MetroLibrary.Mouse.X - Base.AbsolutePosition.X,
            0,
            MetroLibrary.Mouse.Y - Base.AbsolutePosition.Y
        )

        MetroLibrary:Tween(
            Circle,
            1,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            {BackgroundTransparency = 1, Size = UDim2.new(2, 0, 2, 0)}
        )

        wait(1)

        Circle:Destroy()
    end
end

function MetroLibrary:Window(Options)
    local Options = Options or {}
    Options.Name = Options.Name or "Metro"
    Options.Size = Options.Size or UDim2.new(0, 500, 0, 500)
    Options.Position = Options.Position or UDim2.new(0.5, 0, 0.5, 0)

    local Main = Instance.new("Frame")
    Main.Name = "Main_" .. Options.Name
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Size = Options.Size
    Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main.Position = Options.Position
    Main.BorderSizePixel = 0
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.Parent = shared.__Metro

    local MainCorner = Instance.new("UICorner")
    MainCorner.Name = "MainCorner"
    MainCorner.CornerRadius = UDim.new(0, 4)
    MainCorner.Parent = Main

    local Panel = Instance.new("Frame")
    Panel.Name = "Panel"
    Panel.Size = UDim2.new(1, 0, 1, 0)
    Panel.ClipsDescendants = true
    Panel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Panel.BackgroundTransparency = 1
    Panel.BorderSizePixel = 0
    Panel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Panel.Parent = Main

    local SidePanel = Instance.new("Frame")
    SidePanel.Name = "SidePanel"
    SidePanel.ZIndex = 4
    SidePanel.AnchorPoint = Vector2.new(1, 0)
    SidePanel.Size = UDim2.new(0, 50, 1, -30)
    SidePanel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SidePanel.Position = UDim2.new(0, 0, 0, 30)
    SidePanel.BorderSizePixel = 0
    SidePanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SidePanel.Parent = Panel

    local SidePanelCorner = Instance.new("UICorner")
    SidePanelCorner.Name = "SidePanelCorner"
    SidePanelCorner.CornerRadius = UDim.new(0, 4)
    SidePanelCorner.Parent = SidePanel

    local SidePanel_Fix = Instance.new("Frame")
    SidePanel_Fix.Name = "SidePanel_Fix"
    SidePanel_Fix.ZIndex = 4
    SidePanel_Fix.AnchorPoint = Vector2.new(1, 0.5)
    SidePanel_Fix.Size = UDim2.new(0, 4, 1, 0)
    SidePanel_Fix.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SidePanel_Fix.Position = UDim2.new(1, 0, 0.5, 0)
    SidePanel_Fix.BorderSizePixel = 0
    SidePanel_Fix.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SidePanel_Fix.Parent = SidePanel

    local Indicator = Instance.new("Frame")
    Indicator.Name = "Indicator"
    Indicator.ZIndex = 4
    Indicator.AnchorPoint = Vector2.new(0.5, 0)
    Indicator.Size = UDim2.new(0, 30, 0, 30)
    Indicator.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Indicator.BackgroundTransparency = 0.5
    Indicator.Position = UDim2.new(0.5, 0, 0, 10)
    Indicator.BorderSizePixel = 0
    Indicator.BackgroundColor3 = Color3.fromRGB(85, 85, 255)
    Indicator.Parent = SidePanel

    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.Name = "IndicatorCorner"
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = Indicator

    local Buttons = Instance.new("ScrollingFrame")
    Buttons.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Buttons.Name = "Buttons"
    Buttons.ZIndex = 3
    Buttons.CanvasSize = UDim2.new(0, 0, 0, 0)
    Buttons.Size = UDim2.new(1, 0, 1, 0)
    Buttons.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Buttons.BackgroundTransparency = 1
    Buttons.BorderSizePixel = 0
    Buttons.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Buttons.Parent = SidePanel

    local ButtonsPadding = Instance.new("UIPadding")
    ButtonsPadding.Name = "ButtonsPadding"
    ButtonsPadding.PaddingTop = UDim.new(0, 10)
    ButtonsPadding.PaddingBottom = UDim.new(0, 10)
    ButtonsPadding.PaddingLeft = UDim.new(0, 10)
    ButtonsPadding.PaddingRight = UDim.new(0, 10)
    ButtonsPadding.Parent = Buttons

    local ButtonsListLayout = Instance.new("UIListLayout")
    ButtonsListLayout.Name = "ButtonsListLayout"
    ButtonsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ButtonsListLayout.Padding = UDim.new(0, 10)
    ButtonsListLayout.Parent = Buttons

    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 30)
    Header.BorderColor3 = Color3.fromRGB(255, 255, 255)
    Header.BorderSizePixel = 0
    Header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Header.Parent = Panel

    local isDragging = false

    MetroLibrary.Mouse.Move:Connect(
        function()
            if isDragging then
                MetroLibrary:Tween(
                    Main,
                    0.1,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.Out,
                    {
                        Position = UDim2.new(
                            0,
                            MetroLibrary.Mouse.X - Main.Parent.AbsolutePosition.X,
                            0,
                            MetroLibrary.Mouse.Y - Main.Parent.AbsolutePosition.Y
                        )
                    }
                )
            end
        end
    )

    Header.InputBegan:Connect(
        function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Main.AnchorPoint =
                    Vector2.new(
                    (MetroLibrary.Mouse.X - Main.AbsolutePosition.X) / Main.AbsoluteSize.X,
                    (MetroLibrary.Mouse.Y - Main.AbsolutePosition.Y) / Main.AbsoluteSize.Y
                )
                Main.Position =
                    UDim2.new(
                    0,
                    MetroLibrary.Mouse.X - Main.Parent.AbsolutePosition.X,
                    0,
                    MetroLibrary.Mouse.Y - Main.Parent.AbsolutePosition.Y
                )
                isDragging = true
            end
        end
    )

    Header.InputEnded:Connect(
        function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
            end
        end
    )

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.Name = "HeaderCorner"
    HeaderCorner.CornerRadius = UDim.new(0, 4)
    HeaderCorner.Parent = Header

    local Header_Fix = Instance.new("Frame")
    Header_Fix.Name = "Header_Fix"
    Header_Fix.AnchorPoint = Vector2.new(0.5, 1)
    Header_Fix.Size = UDim2.new(1, 0, 0, 4)
    Header_Fix.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Header_Fix.Position = UDim2.new(0.5, 0, 1, 0)
    Header_Fix.BorderSizePixel = 0
    Header_Fix.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Header_Fix.Parent = Header

    local Header_Title = Instance.new("TextLabel")
    Header_Title.Name = "Header_Title"
    Header_Title.Size = UDim2.new(0.5, 0, 1, 0)
    Header_Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Header_Title.BackgroundTransparency = 1
    Header_Title.Position = UDim2.new(0, 35, 0, 0)
    Header_Title.BorderSizePixel = 0
    Header_Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Header_Title.FontSize = Enum.FontSize.Size14
    Header_Title.TextSize = 13
    Header_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Header_Title.Text = Options.Name
    Header_Title.TextWrapped = true
    Header_Title.TextWrap = true
    Header_Title.Font = Enum.Font.Gotham
    Header_Title.TextXAlignment = Enum.TextXAlignment.Left
    Header_Title.Parent = Header

    local TabDock = Instance.new("Frame")
    TabDock.Name = "TabDock"
    TabDock.AnchorPoint = Vector2.new(0, 0.5)
    TabDock.Size = UDim2.new(0, 35, 0, 30)
    TabDock.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabDock.Position = UDim2.new(0, 0, 0.5, 0)
    TabDock.BackgroundTransparency = 1
    TabDock.BorderSizePixel = 0
    TabDock.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabDock.Parent = Header

    local TabDock_Image = Instance.new("ImageLabel")
    TabDock_Image.Name = "TabDock_Image"
    TabDock_Image.AnchorPoint = Vector2.new(0.5, 0.5)
    TabDock_Image.Size = UDim2.new(0, 15, 0, 15)
    TabDock_Image.Selectable = true
    TabDock_Image.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabDock_Image.BackgroundTransparency = 1
    TabDock_Image.Position = UDim2.new(0.5, 0, 0.5, 0)
    TabDock_Image.Active = true
    TabDock_Image.BorderSizePixel = 0
    TabDock_Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabDock_Image.ImageTransparency = 0.5
    TabDock_Image.Image = "rbxassetid://10734897387"
    TabDock_Image.Parent = TabDock

    local Exit = Instance.new("Frame")
    Exit.Name = "Exit"
    Exit.AnchorPoint = Vector2.new(1, 0.5)
    Exit.Size = UDim2.new(0, 35, 0, 30)
    Exit.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Exit.BackgroundTransparency = 1
    Exit.Position = UDim2.new(1, 0, 0.5, 0)
    Exit.BorderSizePixel = 0
    Exit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Exit.Parent = Header

    local Exit_Image = Instance.new("ImageLabel")
    Exit_Image.Name = "Exit_Image"
    Exit_Image.AnchorPoint = Vector2.new(0.5, 0.5)
    Exit_Image.Size = UDim2.new(0, 15, 0, 15)
    Exit_Image.Selectable = true
    Exit_Image.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Exit_Image.BackgroundTransparency = 1
    Exit_Image.Position = UDim2.new(0.5, 0, 0.5, 0)
    Exit_Image.Active = true
    Exit_Image.BorderSizePixel = 0
    Exit_Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Exit_Image.ImageTransparency = 0.5
    Exit_Image.Image = "rbxassetid://7072725342"
    Exit_Image.Parent = Exit

    local InnerPanel = Instance.new("Frame")
    InnerPanel.Name = "InnerPanel"
    InnerPanel.AnchorPoint = Vector2.new(1, 1)
    InnerPanel.Size = UDim2.new(1, 0, 1, -30)
    InnerPanel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    InnerPanel.BackgroundTransparency = 1
    InnerPanel.Position = UDim2.new(1, 0, 1, 0)
    InnerPanel.BorderSizePixel = 0
    InnerPanel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InnerPanel.Parent = Panel

    local Darker = Instance.new("Frame")
    Darker.Name = "Darker"
    Darker.ZIndex = 3
    Darker.Size = UDim2.new(1, 0, 1, 0)
    Darker.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Darker.BackgroundTransparency = 1
    Darker.BorderSizePixel = 0
    Darker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Darker.Parent = InnerPanel

    local DarkerCorner = Instance.new("UICorner")
    DarkerCorner.Name = "DarkerCorner"
    DarkerCorner.CornerRadius = UDim.new(0, 4)
    DarkerCorner.Parent = Darker

    local TabTextIndicator = Instance.new("TextLabel")
    TabTextIndicator.Name = "TabTextIndicator"
    TabTextIndicator.ZIndex = 3
    TabTextIndicator.AnchorPoint = Vector2.new(1, 1)
    TabTextIndicator.AutomaticSize = Enum.AutomaticSize.XY
    TabTextIndicator.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabTextIndicator.BackgroundTransparency = 1
    TabTextIndicator.Position = UDim2.new(1, 0, 1, 0)
    TabTextIndicator.BorderSizePixel = 0
    TabTextIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabTextIndicator.FontSize = Enum.FontSize.Size18
    TabTextIndicator.TextSize = 16
    TabTextIndicator.Text = ""
    TabTextIndicator.TextTransparency = 1
    TabTextIndicator.TextColor3 = Color3.fromRGB(85, 85, 255)
    TabTextIndicator.TextYAlignment = Enum.TextYAlignment.Bottom
    TabTextIndicator.Font = Enum.Font.GothamBold
    TabTextIndicator.TextXAlignment = Enum.TextXAlignment.Right
    TabTextIndicator.Parent = Darker

    local TabTextIndicatorPadding = Instance.new("UIPadding")
    TabTextIndicatorPadding.Name = "TabTextIndicatorPadding"
    TabTextIndicatorPadding.PaddingBottom = UDim.new(0, 10)
    TabTextIndicatorPadding.PaddingRight = UDim.new(0, 10)
    TabTextIndicatorPadding.Parent = TabTextIndicator

    local InnerPanelCorner = Instance.new("UICorner")
    InnerPanelCorner.Name = "InnerPanelCorner"
    InnerPanelCorner.CornerRadius = UDim.new(0, 6)
    InnerPanelCorner.Parent = InnerPanel

    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.ZIndex = 0
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Size = UDim2.new(1, 47, 1, 47)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.BorderSizePixel = 0
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.ImageTransparency = 0.5
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.Parent = Main

    MetroLibrary:OnClick(
        TabDock,
        function()
            if TabDock_Image.ImageTransparency == 0.5 then
                MetroLibrary:Tweens(
                    {
                        {
                            TabDock_Image,
                            0.2,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {ImageTransparency = 0, ImageColor3 = Color3.fromRGB(85, 85, 255)}
                        },
                        {
                            SidePanel,
                            0.3,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {AnchorPoint = Vector2.new(0, 0)}
                        },
                        {Darker, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {BackgroundTransparency = 0.4}},
                        {TabTextIndicator, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {TextTransparency = 0}}
                    }
                )
            elseif TabDock_Image.ImageTransparency == 0 then
                MetroLibrary:Tweens(
                    {
                        {
                            TabDock_Image,
                            0.2,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {ImageTransparency = 0.5, ImageColor3 = Color3.fromRGB(255, 255, 255)}
                        },
                        {
                            SidePanel,
                            0.3,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {AnchorPoint = Vector2.new(1, 0)}
                        },
                        {Darker, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {BackgroundTransparency = 1}},
                        {TabTextIndicator, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, {TextTransparency = 1}}
                    }
                )
            end
        end
    )

    MetroLibrary:OnClick(
        Exit,
        function()
            Metro_GUI:Destroy()
        end
    )

    local WindowFunctions = {}

    local CreatedTabs = {}

    function WindowFunctions:Tab(Options)
        local Options = Options or {}
        Options.Name = Options.Name or ("Home" .. math.random(1000, 10000))
        Options.Image = Options.Image or "rbxassetid://10723365987"

        local Tab = Instance.new("ScrollingFrame")
        Tab.Name = "Tab_" .. Options.Name
        Tab.AnchorPoint = Vector2.new(0.5, 0.5)
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.Selectable = false
        Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Tab.BackgroundTransparency = 1
        Tab.Position = UDim2.new(0.5, 0, 0.5, 0)
        Tab.BorderSizePixel = 0
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 1
        Tab.Visible = false
        Tab.Parent = InnerPanel

        local TabListLayout = Instance.new("UIListLayout")
        TabListLayout.Name = "TabListLayout"
        TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabListLayout.Padding = UDim.new(0, 10)
        TabListLayout.Parent = Tab

        local TabPadding = Instance.new("UIPadding")
        TabPadding.Name = "TabPadding"
        TabPadding.PaddingTop = UDim.new(0, 10)
        TabPadding.PaddingBottom = UDim.new(0, 10)
        TabPadding.PaddingLeft = UDim.new(0, 10)
        TabPadding.PaddingRight = UDim.new(0, 10)
        TabPadding.Parent = Tab

        local TabCorner = Instance.new("UICorner")
        TabCorner.Name = "TabCorner"
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = Tab

        local TabButton = Instance.new("Frame")
        TabButton.Name = "TabButton"
        TabButton.ZIndex = 4
        TabButton.AnchorPoint = Vector2.new(0.5, 0)
        TabButton.Size = UDim2.new(0, 30, 0, 30)
        TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabButton.BackgroundTransparency = 1
        TabButton.Position = UDim2.new(0.5, 0, 0, 0)
        TabButton.BorderSizePixel = 0
        TabButton.BackgroundColor3 = Color3.fromRGB(85, 85, 255)
        TabButton.Parent = Buttons

        local TabButtonImage = Instance.new("ImageLabel")
        TabButtonImage.Name = "TabButtonImage"
        TabButtonImage.ZIndex = 4
        TabButtonImage.AnchorPoint = Vector2.new(0.5, 0.5)
        TabButtonImage.Size = UDim2.new(1, -10, 1, -10)
        TabButtonImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabButtonImage.BackgroundTransparency = 1
        TabButtonImage.Position = UDim2.new(0.5, 0, 0.5, 0)
        TabButtonImage.BorderSizePixel = 0
        TabButtonImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButtonImage.Image = Options.Image
        TabButtonImage.ImageTransparency = 0.5
        TabButtonImage.Parent = TabButton

        MetroLibrary:OnClick(
            TabButton,
            function()
                for _, Tabs in pairs(InnerPanel:GetChildren()) do
                    if Tabs:IsA("ScrollingFrame") and Tabs ~= Tab then
                        Tabs.Visible = false
                    end
                end

                Tab.Visible = true

                TabTextIndicator.Text = Options.Name

                MetroLibrary:Tweens(
                    {
                        {
                            Indicator,
                            0.2,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {
                                Position = UDim2.new(
                                    0.5,
                                    0,
                                    0,
                                    TabButton.AbsolutePosition.Y - SidePanel.AbsolutePosition.Y
                                )
                            }
                        },
                        {
                            TabButton.TabButtonImage,
                            0.3,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {ImageTransparency = 0}
                        }
                    }
                )

                for _, TabBtn in pairs(Buttons:GetChildren()) do
                    if TabBtn:IsA("Frame") and TabBtn ~= TabButton then
                        MetroLibrary:Tween(
                            TabBtn.TabButtonImage,
                            0.3,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {ImageTransparency = 0.5}
                        )
                    end
                end
            end
        )

        local TabFunctions = {}

        function TabFunctions:Select()
            Tab.Visible = true

            TabTextIndicator.Text = Options.Name

            MetroLibrary:Tweens(
                {
                    {
                        Indicator,
                        0.2,
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        {Position = UDim2.new(0.5, 0, 0, TabButton.AbsolutePosition.Y - SidePanel.AbsolutePosition.Y)}
                    },
                    {
                        TabButton.TabButtonImage,
                        0.3,
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        {ImageTransparency = 0}
                    }
                }
            )

            for _, TabBtn in pairs(Buttons:GetChildren()) do
                if TabBtn:IsA("Frame") and TabBtn ~= TabButton then
                    MetroLibrary:Tween(
                        TabBtn.TabButtonImage,
                        0.3,
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        {ImageTransparency = 0.5}
                    )
                end
            end
        end

        function TabFunctions:Section(Options)
            local Options = Options or {}
            Options.Name = Options.Name or "Section"

            local Section = Instance.new("Frame")
            Section.Name = "Section"
            Section.AutomaticSize = Enum.AutomaticSize.Y
            Section.Size = UDim2.new(1, 0, 0, 0)
            Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Section.BackgroundTransparency = 1
            Section.BorderSizePixel = 0
            Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Section.Parent = Tab

            local SectionFunctions = {}

            function SectionFunctions:SubSection(Options)
                local Options = Options or {}
                Options.Name = Options.Name or false
                Options.AnchorPoint = Options.AnchorPoint or Vector2.new(0, 0)
                Options.Position = Options.Position or UDim2.new(0, 0, 0, 0)
                Options.Size = Options.Size or UDim2.new(0.5, -5, 0, 0)

                local Subsection = Instance.new("Frame")
                Subsection.Name = "Subsection_" .. (Options.Name or "Noname")
                Subsection.AnchorPoint = Options.AnchorPoint
                Subsection.AutomaticSize = Enum.AutomaticSize.Y
                Subsection.Position = Options.Position
                Subsection.Size = Options.Size
                Subsection.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Subsection.BorderSizePixel = 0
                Subsection.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                Subsection.Parent = Section

                local SubsectionCorner = Instance.new("UICorner")
                SubsectionCorner.Name = "SubsectionCorner"
                SubsectionCorner.CornerRadius = UDim.new(0, 4)
                SubsectionCorner.Parent = Subsection

                local Title = Instance.new("TextLabel")
                Title.Name = "Title"
                Title.Size = UDim2.new(0.5, 0, 0, 30)
                Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Title.BackgroundTransparency = 1
                Title.BorderSizePixel = 0
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.FontSize = Enum.FontSize.Size14
                Title.TextSize = 13
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.Font = Enum.Font.Gotham
                Title.Text = (Options.Name or "Noname")
                Title.TextTransparency = 0.5
                Title.TextXAlignment = Enum.TextXAlignment.Left
                Title.Visible = (Options.Name ~= false)
                Title.Parent = Subsection

                local SubsectionTitlePadding = Instance.new("UIPadding")
                SubsectionTitlePadding.Name = "SubsectionTitlePadding"
                SubsectionTitlePadding.PaddingLeft = UDim.new(0, 10)
                SubsectionTitlePadding.Parent = Title

                local Contents = Instance.new("Frame")
                Contents.Name = "Contents"
                Contents.AutomaticSize = Enum.AutomaticSize.Y
                Contents.Size = UDim2.new(1, 0, 0, 0)
                Contents.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Contents.BackgroundTransparency = 1
                Contents.Position = UDim2.new(0, 0, 0, (Options.Name == false and 10) or 30)
                Contents.BorderSizePixel = 0
                Contents.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Contents.Parent = Subsection

                local SubsectionContentsPadding = Instance.new("UIPadding")
                SubsectionContentsPadding.Name = "SubsectionContentsPadding"
                SubsectionContentsPadding.PaddingBottom = UDim.new(0, 15)
                SubsectionContentsPadding.PaddingLeft = UDim.new(0, 10)
                SubsectionContentsPadding.PaddingRight = UDim.new(0, 10)
                SubsectionContentsPadding.Parent = Contents

                local SubsectionContentsListLayout = Instance.new("UIListLayout")
                SubsectionContentsListLayout.Name = "SubsectionContentsListLayout"
                SubsectionContentsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                SubsectionContentsListLayout.Padding = UDim.new(0, 8)
                SubsectionContentsListLayout.Parent = Contents

                local SubsectionStroke = Instance.new("UIStroke")
                SubsectionStroke.Name = "SubsectionStroke"
                SubsectionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                SubsectionStroke.Transparency = 0.85
                SubsectionStroke.Thickness = 1.25
                SubsectionStroke.Color = Color3.fromRGB(255, 255, 255)
                SubsectionStroke.Parent = Subsection

                local SubSectionFunctions = {}

                function SubSectionFunctions:Textfield(Options)
                    local Options = Options or {}
                    Options.Name = Options.Name or "Textfield"

                    local Textfield = Instance.new("TextLabel")
                    Textfield.Name = "Textfield_" .. Options.Name
                    Textfield.Size = UDim2.new(1, 0, 0, 30)
                    Textfield.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Textfield.BackgroundTransparency = 0.5
                    Textfield.BorderSizePixel = 0
                    Textfield.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Textfield.FontSize = Enum.FontSize.Size14
                    Textfield.TextSize = 13
                    Textfield.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Textfield.Font = Enum.Font.Gotham
                    Textfield.Parent = Contents

                    local TextfieldStroke = Instance.new("UIStroke")
                    TextfieldStroke.Name = "TextfieldStroke"
                    TextfieldStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    TextfieldStroke.Transparency = 0.85
                    TextfieldStroke.Thickness = 1.25
                    TextfieldStroke.Color = Color3.fromRGB(255, 255, 255)
                    TextfieldStroke.Parent = Textfield

                    local TextfieldCorner = Instance.new("UICorner")
                    TextfieldCorner.Name = "TextfieldCorner"
                    TextfieldCorner.CornerRadius = UDim.new(0, 3)
                    TextfieldCorner.Parent = Textfield
                end

                function SubSectionFunctions:Button(Options)
                    local Options = Options or {}
                    Options.Name = Options.Name or "Button"
                    Options.Callback = Options.Callback or function()
                        end

                    local Button = Instance.new("TextButton")
                    Button.Name = "Button_" .. Options.Name
                    Button.Size = UDim2.new(0, 100, 0, 30)
                    Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Button.BackgroundTransparency = 0.5
                    Button.BorderSizePixel = 0
                    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Button.AutoButtonColor = false
                    Button.FontSize = Enum.FontSize.Size14
                    Button.Text = Options.Name
                    Button.TextSize = 13
                    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Button.Font = Enum.Font.Gotham
                    Button.Parent = Contents

                    local ButtonCorner = Instance.new("UICorner")
                    ButtonCorner.Name = "ButtonCorner"
                    ButtonCorner.CornerRadius = UDim.new(0, 3)
                    ButtonCorner.Parent = Button

                    local ButtonStroke = Instance.new("UIStroke")
                    ButtonStroke.Name = "ButtonStroke"
                    ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    ButtonStroke.Transparency = 0.85
                    ButtonStroke.Thickness = 1.25
                    ButtonStroke.Color = Color3.fromRGB(255, 255, 255)
                    ButtonStroke.Parent = Button

                    local ButtonPadding = Instance.new("UIPadding")
                    ButtonPadding.PaddingLeft = UDim.new(0, 10)
                    ButtonPadding.PaddingRight = UDim.new(0, 10)
                    ButtonPadding.Parent = Button

                    MetroLibrary:OnClick(
                        Button,
                        function()
                            Options.Callback(Button.Name)
                            makeRipple(Button, Color3.fromRGB(255, 255, 255))
                        end
                    )
                end

                function SubSectionFunctions:Slider(Options)
                    local Options = Options or {}
                    Options.Name = Options.Name or "Slider"
                    Options.Minimum = Options.Minimum or 0
                    Options.Maximum = Options.Maximum or 100
                    Options.Default = Options.Default or 0
                    Options.Callback = Options.Callback or function()
                        end

                    local Slider = Instance.new("Frame")
                    Slider.Name = "Slider_" .. Options.Name
                    Slider.Size = UDim2.new(1, 0, 0, 30)
                    Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Slider.BackgroundTransparency = 0.5
                    Slider.BorderSizePixel = 0
                    Slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Slider.Parent = Contents

                    local SliderCorner = Instance.new("UICorner")
                    SliderCorner.Name = "SliderCorner"
                    SliderCorner.CornerRadius = UDim.new(0, 3)
                    SliderCorner.Parent = Slider

                    local SliderStroke = Instance.new("UIStroke")
                    SliderStroke.Name = "SliderStroke"
                    SliderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    SliderStroke.Transparency = 0.85
                    SliderStroke.Thickness = 1.25
                    SliderStroke.Color = Color3.fromRGB(255, 255, 255)
                    SliderStroke.Parent = Slider

                    local Title = Instance.new("TextLabel")
                    Title.Name = "Title"
                    Title.ZIndex = 2
                    Title.Size = UDim2.new(0.5, 0, 1, 0)
                    Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Title.BackgroundTransparency = 1
                    Title.BorderSizePixel = 0
                    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Title.FontSize = Enum.FontSize.Size14
                    Title.TextSize = 13
                    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Title.Text = Options.Name
                    Title.Font = Enum.Font.Gotham
                    Title.TextXAlignment = Enum.TextXAlignment.Left
                    Title.Parent = Slider

                    local SliderTitlePadding = Instance.new("UIPadding")
                    SliderTitlePadding.Name = "SliderTitlePadding"
                    SliderTitlePadding.PaddingLeft = UDim.new(0, 10)
                    SliderTitlePadding.PaddingRight = UDim.new(0, 10)
                    SliderTitlePadding.Parent = Title

                    local Inner = Instance.new("Frame")
                    Inner.Name = "Inner"
                    Inner.Size =
                        UDim2.new(
                        ((Options.Default or Options.Minimum) - Options.Minimum) / (Options.Maximum - Options.Minimum),
                        0,
                        1,
                        0
                    )
                    Inner.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Inner.BackgroundTransparency = 0.5
                    Inner.BorderSizePixel = 0
                    Inner.BackgroundColor3 = Color3.fromRGB(85, 85, 255)
                    Inner.Parent = Slider

                    local SliderInnerStroke = Instance.new("UIStroke")
                    SliderInnerStroke.Name = "SliderInnerStroke"
                    SliderInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    SliderInnerStroke.Thickness = 1.25
                    SliderInnerStroke.Color = Color3.fromRGB(85, 85, 255)
                    SliderInnerStroke.Parent = Inner

                    local SliderInnerCorner = Instance.new("UICorner")
                    SliderInnerCorner.Name = "SliderInnerCorner"
                    SliderInnerCorner.CornerRadius = UDim.new(0, 3)
                    SliderInnerCorner.Parent = Inner

                    local Value = Instance.new("TextBox")
                    Value.Active = false
                    Value.Name = "Value"
                    Value.ZIndex = 2
                    Value.AnchorPoint = Vector2.new(1, 0.5)
                    Value.AutomaticSize = Enum.AutomaticSize.X
                    Value.Size = UDim2.new(0, 0, 1, 0)
                    Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Value.BackgroundTransparency = 1
                    Value.Position = UDim2.new(1, 0, 0.5, 0)
                    Value.BorderSizePixel = 0
                    Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Value.FontSize = Enum.FontSize.Size14
                    Value.TextSize = 13
                    Value.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Value.Text = math.floor(Options.Default * 100) / 100
                    Value.TextEditable = false
                    Value.Font = Enum.Font.Gotham
                    Value.TextXAlignment = Enum.TextXAlignment.Right
                    Value.ClearTextOnFocus = false
                    Value.Parent = Slider

                    local SliderValuePadding = Instance.new("UIPadding")
                    SliderValuePadding.Name = "SliderValuePadding"
                    SliderValuePadding.PaddingLeft = UDim.new(0, 10)
                    SliderValuePadding.PaddingRight = UDim.new(0, 10)
                    SliderValuePadding.Parent = Value

                    Value.Focused:Connect(
                        function()
                            if Value.Active == false then
                                Value:ReleaseFocus()
                            end
                        end
                    )

                    local isDragging = false

                    local function Slide()
                        local XSize = (MetroLibrary.Mouse.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X
                        XSize = math.clamp(XSize, 0, 1)

                        MetroLibrary:Tween(
                            Inner,
                            0.1,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {Size = UDim2.new(XSize, 0, 0, 30)}
                        )

                        local Dec2 =
                            (((XSize * Options.Maximum) / Options.Maximum) * (Options.Maximum - Options.Minimum) +
                            Options.Minimum) *
                            100
                        Dec2 = math.floor(Dec2)
                        Value.Text = Dec2 / 100
                        Options.Callback(tonumber(Value.Text))
                    end

                    Slider.InputBegan:Connect(
                        function(Input)
                            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                isDragging = true
                                Slide()
                            elseif Input.UserInputType == Enum.UserInputType.MouseButton3 then
                                Value.Active = true
                                Value.TextEditable = true
                                Value:CaptureFocus()
                                Value.Text = ""

                                Value.FocusLost:Once(
                                    function()
                                        Value.Active = false
                                        Value.TextEditable = false

                                        if tonumber(Value.Text) then
                                            Value.Text =
                                                math.floor(math.clamp(tonumber(Value.Text), Options.Minimum, Options.Maximum) * 100) / 100
                                            MetroLibrary:Tween(
                                                Inner,
                                                0.1,
                                                Enum.EasingStyle.Sine,
                                                Enum.EasingDirection.Out,
                                                {
                                                    Size = UDim2.new(
                                                        ((tonumber(Value.Text) or Options.Minimum) - Options.Minimum) /
                                                            (Options.Maximum - Options.Minimum),
                                                        0,
                                                        1,
                                                        0
                                                    )
                                                }
                                            )
                                        else
                                            Value.Text = math.floor(Options.Default * 100) / 100
                                            MetroLibrary:Tween(
                                                Inner,
                                                0.1,
                                                Enum.EasingStyle.Sine,
                                                Enum.EasingDirection.Out,
                                                {
                                                    Size = UDim2.new(
                                                        ((Options.Default or Options.Minimum) - Options.Minimum) /
                                                            (Options.Maximum - Options.Minimum),
                                                        0,
                                                        1,
                                                        0
                                                    )
                                                }
                                            )
                                        end

                                        Options.Callback(tonumber(Value.Text))
                                    end
                                )
                            end
                        end
                    )

                    Slider.InputEnded:Connect(
                        function(Input)
                            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                isDragging = false
                            end
                        end
                    )

                    MetroLibrary.Mouse.Move:Connect(
                        function()
                            if isDragging then
                                Slide()
                            end
                        end
                    )
                end

                function SubSectionFunctions:Toggle(Options)
                    local Options = Options or {}
                    Options.Name = Options.Name or "Toggle"
                    Options.Default = Options.Default or false
                    Options.Callback = Options.Callback or function()
                        end

                    local Toggle = Instance.new("Frame")
                    Toggle.Name = "Toggle_" .. Options.Name
                    Toggle.Size = UDim2.new(1, 0, 0, 30)
                    Toggle.ClipsDescendants = true
                    Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Toggle.BackgroundTransparency = 0.5
                    Toggle.BorderSizePixel = 0
                    Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Toggle.Parent = Contents

                    local ToggleStroke = Instance.new("UIStroke")
                    ToggleStroke.Name = "ToggleStroke"
                    ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    ToggleStroke.Transparency = 0.85
                    ToggleStroke.Thickness = 1.25
                    ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
                    ToggleStroke.Parent = Toggle

                    local Title = Instance.new("TextLabel")
                    Title.Name = "Title"
                    Title.ZIndex = 2
                    Title.Size = UDim2.new(0.5, 0, 1, 0)
                    Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Title.BackgroundTransparency = 1
                    Title.BorderSizePixel = 0
                    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Title.FontSize = Enum.FontSize.Size14
                    Title.TextSize = 13
                    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Title.Text = "Toggle"
                    Title.Font = Enum.Font.Gotham
                    Title.TextXAlignment = Enum.TextXAlignment.Left
                    Title.Parent = Toggle

                    local ToggleTitlePadding = Instance.new("UIPadding")
                    ToggleTitlePadding.Name = "ToggleTitlePadding"
                    ToggleTitlePadding.PaddingLeft = UDim.new(0, 10)
                    ToggleTitlePadding.PaddingRight = UDim.new(0, 10)
                    ToggleTitlePadding.Parent = Title

                    local Button = Instance.new("Frame")
                    Button.Name = "Button"
                    Button.AnchorPoint = Vector2.new(1, 0.5)
                    Button.Size = UDim2.new(0.5, 0, 1, 0)
                    Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Button.BackgroundTransparency = 1
                    Button.Position = UDim2.new(1, 0, 0.5, 0)
                    Button.BorderSizePixel = 0
                    Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Button.Parent = Toggle

                    local In = Instance.new("Frame")
                    In.Name = "In"
                    In.AnchorPoint = Vector2.new(1, 0.5)
                    In.Size = UDim2.new(0, 30, 1, -18)
                    In.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    In.BackgroundTransparency = 0.5
                    In.Position = UDim2.new(1, 0, 0.5, 0)
                    In.BorderSizePixel = 0
                    In.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    In.Parent = Button

                    local ButtonInCorner = Instance.new("UICorner")
                    ButtonInCorner.Name = "ButtonInCorner"
                    ButtonInCorner.CornerRadius = UDim.new(1, 0)
                    ButtonInCorner.Parent = In

                    local ButtonInPadding = Instance.new("UIPadding")
                    ButtonInPadding.Name = "ButtonInPadding"
                    ButtonInPadding.Parent = In

                    local Circle = Instance.new("Frame")
                    Circle.Name = "Circle"
                    Circle.AnchorPoint = Vector2.new(0, 0.5)
                    Circle.Size = UDim2.new(0, 15, 0, 15)
                    Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Circle.Position = UDim2.new(0, 0, 0.5, 0)
                    Circle.BorderSizePixel = 0
                    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Circle.Parent = In

                    local InCircleCorner = Instance.new("UICorner")
                    InCircleCorner.Name = "InCircleCorner"
                    InCircleCorner.CornerRadius = UDim.new(1, 0)
                    InCircleCorner.Parent = Circle

                    local ToggleButtonPadding = Instance.new("UIPadding")
                    ToggleButtonPadding.Name = "ToggleButtonPadding"
                    ToggleButtonPadding.PaddingRight = UDim.new(0, 8)
                    ToggleButtonPadding.Parent = Button

                    local ToggleCorner = Instance.new("UICorner")
                    ToggleCorner.Name = "ToggleCorner"
                    ToggleCorner.CornerRadius = UDim.new(0, 3)
                    ToggleCorner.Parent = Toggle

                    if Options.Default == true then
                        MetroLibrary:Tweens(
                            {
                                {
                                    In,
                                    0.3,
                                    Enum.EasingStyle.Sine,
                                    Enum.EasingDirection.Out,
                                    {BackgroundColor3 = Color3.fromRGB(85, 85, 255)}
                                },
                                {
                                    Circle,
                                    0.3,
                                    Enum.EasingStyle.Sine,
                                    Enum.EasingDirection.Out,
                                    {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0)}
                                }
                            }
                        )
                    end

                    MetroLibrary:OnClick(
                        Toggle,
                        function()
                            if Circle.AnchorPoint.X == 0 then
                                Options.Callback(true)
                                MetroLibrary:Tweens(
                                    {
                                        {
                                            In,
                                            0.3,
                                            Enum.EasingStyle.Sine,
                                            Enum.EasingDirection.Out,
                                            {BackgroundColor3 = Color3.fromRGB(85, 85, 255)}
                                        },
                                        {
                                            Circle,
                                            0.3,
                                            Enum.EasingStyle.Sine,
                                            Enum.EasingDirection.Out,
                                            {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0)}
                                        }
                                    }
                                )
                            elseif Circle.AnchorPoint.X == 1 then
                                Options.Callback(false)
                                MetroLibrary:Tweens(
                                    {
                                        {
                                            In,
                                            0.3,
                                            Enum.EasingStyle.Sine,
                                            Enum.EasingDirection.Out,
                                            {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                                        },
                                        {
                                            Circle,
                                            0.3,
                                            Enum.EasingStyle.Sine,
                                            Enum.EasingDirection.Out,
                                            {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0)}
                                        }
                                    }
                                )
                            end
                        end
                    )
                end

                function SubSectionFunctions:Inputfield(Options)
                    local Options = Options or {}
                    Options.Name = Options.Name or "Inputfield"
                    Options.Placeholder = Options.Placeholder or "Input here..."
                    Options.Default = Options.Default or ""
                    Options.Callback = Options.Callback or function()
                        end

                    local Inputfield = Instance.new("Frame")
                    Inputfield.Name = "Inputfield_" .. Options.Name
                    Inputfield.Size = UDim2.new(1, 0, 0, 30)
                    Inputfield.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Inputfield.BackgroundTransparency = 0.5
                    Inputfield.BorderSizePixel = 0
                    Inputfield.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Inputfield.Parent = Contents

                    local InputfieldCorner = Instance.new("UICorner")
                    InputfieldCorner.Name = "InputfieldCorner"
                    InputfieldCorner.CornerRadius = UDim.new(0, 3)
                    InputfieldCorner.Parent = Inputfield

                    local InputfieldStroke = Instance.new("UIStroke")
                    InputfieldStroke.Name = "InputfieldStroke"
                    InputfieldStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    InputfieldStroke.Transparency = 0.85
                    InputfieldStroke.Thickness = 1.25
                    InputfieldStroke.Color = Color3.fromRGB(255, 255, 255)
                    InputfieldStroke.Parent = Inputfield

                    local Title = Instance.new("TextLabel")
                    Title.Name = "Title"
                    Title.ZIndex = 2
                    Title.Size = UDim2.new(0.5, 0, 1, 0)
                    Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Title.BackgroundTransparency = 1
                    Title.BorderSizePixel = 0
                    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Title.FontSize = Enum.FontSize.Size14
                    Title.TextSize = 13
                    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Title.Text = Options.Name
                    Title.Font = Enum.Font.Gotham
                    Title.TextXAlignment = Enum.TextXAlignment.Left
                    Title.Parent = Inputfield

                    local InputfieldTitlePadding = Instance.new("UIPadding")
                    InputfieldTitlePadding.Name = "InputfieldTitlePadding"
                    InputfieldTitlePadding.PaddingLeft = UDim.new(0, 10)
                    InputfieldTitlePadding.PaddingRight = UDim.new(0, 10)
                    InputfieldTitlePadding.Parent = Title

                    local Value = Instance.new("TextBox")
                    Value.Name = "Value"
                    Value.ZIndex = 2
                    Value.AnchorPoint = Vector2.new(1, 0.5)
                    Value.Size = UDim2.new(1, 0, 1, 0)
                    Value.Selectable = false
                    Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Value.BackgroundTransparency = 1
                    Value.Position = UDim2.new(1, 0, 0.5, 0)
                    Value.Active = false
                    Value.BorderSizePixel = 0
                    Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Value.FontSize = Enum.FontSize.Size14
                    Value.PlaceholderColor3 = Color3.fromRGB(173, 173, 173)
                    Value.TextSize = 13
                    Value.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Value.PlaceholderText = Options.Placeholder
                    Value.Text = Options.Default
                    Value.Font = Enum.Font.Gotham
                    Value.TextXAlignment = Enum.TextXAlignment.Right
                    Value.ClearTextOnFocus = false
                    Value.Parent = Inputfield

                    local InputfieldValuePadding = Instance.new("UIPadding")
                    InputfieldValuePadding.Name = "InputfieldValuePadding"
                    InputfieldValuePadding.PaddingLeft = UDim.new(0, 10)
                    InputfieldValuePadding.PaddingRight = UDim.new(0, 10)
                    InputfieldValuePadding.Parent = Value

                    local LastText = Value.Text

                    Value.Focused:Connect(
                        function()
                            LastText = Value.Text
                            Value.Text = ""
                        end
                    )

                    Value.FocusLost:Connect(
                        function()
                            if #Value.Text < 1 then
                                Value.Text = LastText
                            end

                            Options.Callback(Value.Text)
                        end
                    )
                end

                function SubSectionFunctions:HorizontalAlignment(Options)
                    local Options = Options or {}
                    Options.Padding = Options.Padding or UDim.new(0, 8)
                    Options.Alignment = Options.Alignment or Enum.HorizontalAlignment.Center

                    local HorizontalAlignment = Instance.new("Frame")
                    HorizontalAlignment.Name = "HorizontalAlignment"
                    HorizontalAlignment.Size = UDim2.new(1, 0, 0, 0)
                    HorizontalAlignment.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    HorizontalAlignment.BackgroundTransparency = 1
                    HorizontalAlignment.BorderSizePixel = 0
                    HorizontalAlignment.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    HorizontalAlignment.Parent = Contents

                    local HorizontalAlignmentListLayout = Instance.new("UIListLayout")
                    HorizontalAlignmentListLayout.Name = "HorizontalAlignmentListLayout"
                    HorizontalAlignmentListLayout.FillDirection = Enum.FillDirection.Horizontal
                    HorizontalAlignmentListLayout.HorizontalAlignment = Options.Alignment
                    HorizontalAlignmentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    HorizontalAlignmentListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                    HorizontalAlignmentListLayout.Padding = Options.Padding
                    HorizontalAlignmentListLayout.Parent = HorizontalAlignment

                    local Buttons = 0

                    local HorizontalFunctions = {}

                    function HorizontalFunctions:Button(Options)
                        local Options = Options or {}
                        Options.Name = Options.Name or "Button"
                        Options.Callback = Options.Callback or function()
                            end

                        HorizontalAlignment.Size = UDim2.new(1, 0, 0, 30)

                        Buttons = Buttons + 1

                        local Button = Instance.new("TextButton")
                        Button.Name = "Button_" .. Options.Name
                        Button.Size = UDim2.new(0, 100, 0, 30)
                        Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        Button.BackgroundTransparency = 0.5
                        Button.BorderSizePixel = 0
                        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                        Button.AutoButtonColor = false
                        Button.FontSize = Enum.FontSize.Size14
                        Button.Text = Options.Name
                        Button.TextSize = 13
                        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Button.Font = Enum.Font.Gotham
                        Button.Parent = HorizontalAlignment

                        local ButtonCorner = Instance.new("UICorner")
                        ButtonCorner.Name = "ButtonCorner"
                        ButtonCorner.CornerRadius = UDim.new(0, 3)
                        ButtonCorner.Parent = Button

                        local ButtonStroke = Instance.new("UIStroke")
                        ButtonStroke.Name = "ButtonStroke"
                        ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        ButtonStroke.Transparency = 0.85
                        ButtonStroke.Thickness = 1.25
                        ButtonStroke.Color = Color3.fromRGB(255, 255, 255)
                        ButtonStroke.Parent = Button

                        local ButtonPadding = Instance.new("UIPadding")
                        ButtonPadding.PaddingLeft = UDim.new(0, 10)
                        ButtonPadding.PaddingRight = UDim.new(0, 10)
                        ButtonPadding.Parent = Button

                        MetroLibrary:OnClick(
                            Button,
                            function()
                                Options.Callback(Button.Name)
                                makeRipple(Button, Color3.fromRGB(255, 255, 255))
                            end
                        )

                        for _, Buttones in pairs(HorizontalAlignment:GetChildren()) do
                            if Buttones:IsA("TextButton") then
                                Buttones.Size =
                                    UDim2.new(0, (HorizontalAlignment.AbsoluteSize.X / Buttons) - (Buttons * 2), 0, 30)
                            end
                        end
                    end

                    return HorizontalFunctions
                end

                function SubSectionFunctions:Divider(Options)
                    local Options = Options or {}
                    Options.Size = Options.Size or UDim2.new(1, 0, 0, 10)

                    local Divider = Instance.new("Frame")
                    Divider.Name = "Divider"
                    Divider.Size = Options.Size
                    Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Divider.BackgroundTransparency = 1
                    Divider.BorderSizePixel = 0
                    Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Divider.Parent = Contents
                end

                function SubSectionFunctions:Dropdown(Options)
                    local Options = Options or {}
                    Options.Name = Options.Name or "Dropdown"
                    Options.Items = Options.Items or {"Pizza", "Chicken", "Lion", "King"}
                    Options.Default = Options.Default or 1
                    Options.CloseAfter = Options.CloseAfter or false
                    Options.Callback = Options.Callback or function()
                        end

                    local Dropdown = Instance.new("Frame")
                    Dropdown.Name = "Dropdown_" .. Options.Name
                    Dropdown.Size = UDim2.new(1, 0, 0, 30)
                    Dropdown.ClipsDescendants = true
                    Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Dropdown.BackgroundTransparency = 0.5
                    Dropdown.BorderSizePixel = 0
                    Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Dropdown.Parent = Contents

                    local DropdownCorner = Instance.new("UICorner")
                    DropdownCorner.Name = "DropdownCorner"
                    DropdownCorner.CornerRadius = UDim.new(0, 3)
                    DropdownCorner.Parent = Dropdown

                    local DropdownStroke = Instance.new("UIStroke")
                    DropdownStroke.Name = "DropdownStroke"
                    DropdownStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    DropdownStroke.Transparency = 0.85
                    DropdownStroke.Thickness = 1.25
                    DropdownStroke.Color = Color3.fromRGB(255, 255, 255)
                    DropdownStroke.Parent = Dropdown

                    local Header = Instance.new("Frame")
                    Header.Name = "Header"
                    Header.AnchorPoint = Vector2.new(0.5, 0)
                    Header.Size = UDim2.new(1, 0, 0, 30)
                    Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Header.BackgroundTransparency = 1
                    Header.Position = UDim2.new(0.5, 0, 0, 0)
                    Header.BorderSizePixel = 0
                    Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Header.Parent = Dropdown

                    local Docker = Instance.new("Frame")
                    Docker.Name = "Docker"
                    Docker.AnchorPoint = Vector2.new(1, 0.5)
                    Docker.Size = UDim2.new(0, 30, 0, 25)
                    Docker.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Docker.BackgroundTransparency = 1
                    Docker.Position = UDim2.new(1, 0, 0.5, 0)
                    Docker.BorderSizePixel = 0
                    Docker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Docker.Parent = Header

                    local DockerImage = Instance.new("ImageLabel")
                    DockerImage.Name = "DockerImage"
                    DockerImage.LayoutOrder = 7
                    DockerImage.ZIndex = 2
                    DockerImage.AnchorPoint = Vector2.new(0.5, 0.5)
                    DockerImage.Size = UDim2.new(0, 20, 0, 20)
                    DockerImage.Selectable = true
                    DockerImage.BackgroundTransparency = 1
                    DockerImage.Position = UDim2.new(0.5, 0, 0.5, 0)
                    DockerImage.Active = true
                    DockerImage.ImageRectOffset = Vector2.new(324, 524)
                    DockerImage.ImageRectSize = Vector2.new(36, 36)
                    DockerImage.Image = "rbxassetid://3926307971"
                    DockerImage.Parent = Docker

                    local Title = Instance.new("TextLabel")
                    Title.Name = "Title"
                    Title.ZIndex = 2
                    Title.Size = UDim2.new(0.5, 0, 1, 0)
                    Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Title.BackgroundTransparency = 1
                    Title.BorderSizePixel = 0
                    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Title.FontSize = Enum.FontSize.Size14
                    Title.TextSize = 13
                    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Title.Text = Options.Name
                    Title.Font = Enum.Font.Gotham
                    Title.TextXAlignment = Enum.TextXAlignment.Left
                    Title.Parent = Header

                    local TitlePadding = Instance.new("UIPadding")
                    TitlePadding.Name = "TitlePadding"
                    TitlePadding.PaddingLeft = UDim.new(0, 10)
                    TitlePadding.PaddingRight = UDim.new(0, 10)
                    TitlePadding.Parent = Title

                    local Contents = Instance.new("Frame")
                    Contents.Name = "Contents"
                    Contents.AnchorPoint = Vector2.new(0.5, 0)
                    Contents.Size = UDim2.new(1, 0, 1, 0)
                    Contents.ClipsDescendants = true
                    Contents.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Contents.BackgroundTransparency = 1
                    Contents.Position = UDim2.new(0.5, 0, 0, 30)
                    Contents.BorderSizePixel = 0
                    Contents.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Contents.Parent = Dropdown

                    local DropdownContentsPadding = Instance.new("UIPadding")
                    DropdownContentsPadding.Name = "DropdownContentsPadding"
                    DropdownContentsPadding.PaddingTop = UDim.new(0, 5)
                    DropdownContentsPadding.PaddingBottom = UDim.new(0, 10)
                    DropdownContentsPadding.PaddingLeft = UDim.new(0, 10)
                    DropdownContentsPadding.PaddingRight = UDim.new(0, 10)
                    DropdownContentsPadding.Parent = Contents

                    local Searcher = Instance.new("TextBox")
                    Searcher.Name = "Searcher"
                    Searcher.Size = UDim2.new(1, 0, 0, 30)
                    Searcher.Selectable = false
                    Searcher.BorderColor3 = Color3.fromRGB(255, 255, 255)
                    Searcher.BackgroundTransparency = 0.5
                    Searcher.Active = false
                    Searcher.BorderSizePixel = 0
                    Searcher.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    Searcher.FontSize = Enum.FontSize.Size14
                    Searcher.TextWrapped = true
                    Searcher.TextWrap = true
                    Searcher.TextSize = 13
                    Searcher.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Searcher.PlaceholderText = "Search..."
                    Searcher.Text = ""
                    Searcher.Font = Enum.Font.Gotham
                    Searcher.Parent = Contents

                    local SearcherCorner = Instance.new("UICorner")
                    SearcherCorner.Name = "SearcherCorner"
                    SearcherCorner.CornerRadius = UDim.new(0, 3)
                    SearcherCorner.Parent = Searcher

                    local SearcherStroke = Instance.new("UIStroke")
                    SearcherStroke.Name = "SearcherStroke"
                    SearcherStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    SearcherStroke.Transparency = 0.85
                    SearcherStroke.Thickness = 1.25
                    SearcherStroke.Color = Color3.fromRGB(255, 255, 255)
                    SearcherStroke.Parent = Searcher

                    local ListContainer = Instance.new("Frame")
                    ListContainer.Name = "ListContainer"
                    ListContainer.AnchorPoint = Vector2.new(1, 0)
                    ListContainer.Size = UDim2.new(1, 0, 1, -70)
                    ListContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ListContainer.BackgroundTransparency = 0.5
                    ListContainer.Position = UDim2.new(1, 0, 0, 40)
                    ListContainer.BorderSizePixel = 0
                    ListContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    ListContainer.Parent = Contents

                    local Scroller = Instance.new("ScrollingFrame")
                    Scroller.Name = "Scroller"
                    Scroller.AnchorPoint = Vector2.new(0.5, 0.5)
                    Scroller.Size = UDim2.new(1, 0, 1, 0)
                    Scroller.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Scroller.BackgroundTransparency = 1
                    Scroller.Position = UDim2.new(0.5, 0, 0.5, 0)
                    Scroller.Active = true
                    Scroller.BorderSizePixel = 0
                    Scroller.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Scroller.AutomaticCanvasSize = Enum.AutomaticSize.Y
                    Scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
                    Scroller.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
                    Scroller.ScrollBarThickness = 1
                    Scroller.Parent = ListContainer

                    local ScrollerListLayout = Instance.new("UIListLayout")
                    ScrollerListLayout.Name = "ScrollerListLayout"
                    ScrollerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    ScrollerListLayout.Parent = Scroller

                    local ListContainerPadding = Instance.new("UICorner")
                    ListContainerPadding.Name = "ListContainerPadding"
                    ListContainerPadding.CornerRadius = UDim.new(0, 3)
                    ListContainerPadding.Parent = ListContainer

                    local ListContainerStroke = Instance.new("UIStroke")
                    ListContainerStroke.Name = "ListContainerStroke"
                    ListContainerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    ListContainerStroke.Thickness = 1.25
                    ListContainerStroke.Color = Color3.fromRGB(85, 85, 255)
                    ListContainerStroke.Parent = ListContainer

                    Searcher:GetPropertyChangedSignal("Text"):Connect(
                        function()
                            for _, ItemButtons in pairs(Scroller:GetChildren()) do
                                if
                                    ItemButtons:IsA("TextButton") and
                                        ItemButtons.Name:gsub("Item_", ""):sub(1, #Searcher.Text) == Searcher.Text
                                 then
                                    ItemButtons.Visible = true
                                elseif
                                    ItemButtons:IsA("TextButton") and
                                        ItemButtons.Name:gsub("Item_", ""):sub(1, #Searcher.Text) ~= Searcher.Text
                                 then
                                    ItemButtons.Visible = false
                                end
                            end
                        end
                    )

                    MetroLibrary:OnClick(
                        Docker,
                        function()
                            if DockerImage.Rotation == 0 then
                                MetroLibrary:Tweens(
                                    {
                                        {
                                            DockerImage,
                                            0.2,
                                            Enum.EasingStyle.Sine,
                                            Enum.EasingDirection.Out,
                                            {Rotation = 180}
                                        },
                                        {
                                            Dropdown,
                                            0.3,
                                            Enum.EasingStyle.Sine,
                                            Enum.EasingDirection.Out,
                                            {Size = UDim2.new(1, 0, 0, 212)}
                                        }
                                    }
                                )
                            elseif DockerImage.Rotation == 180 then
                                MetroLibrary:Tweens(
                                    {
                                        {
                                            DockerImage,
                                            0.2,
                                            Enum.EasingStyle.Sine,
                                            Enum.EasingDirection.Out,
                                            {Rotation = 0}
                                        },
                                        {
                                            Dropdown,
                                            0.3,
                                            Enum.EasingStyle.Sine,
                                            Enum.EasingDirection.Out,
                                            {Size = UDim2.new(1, 0, 0, 30)}
                                        }
                                    }
                                )
                            end
                        end
                    )

                    for _, Item in pairs(Options.Items) do
                        local ItemButton = Instance.new("TextButton")
                        ItemButton.Name = "Item_" .. Item
                        ItemButton.ZIndex = 2
                        ItemButton.Size = UDim2.new(1, 0, 0, 25)
                        ItemButton.AutoButtonColor = false
                        ItemButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        ItemButton.BackgroundTransparency = 1
                        ItemButton.BorderSizePixel = 0
                        ItemButton.BackgroundColor3 = Color3.fromRGB(85, 85, 255)
                        ItemButton.FontSize = Enum.FontSize.Size14
                        ItemButton.Text = Item
                        ItemButton.TextSize = 13
                        ItemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ItemButton.Font = Enum.Font.Gotham
                        ItemButton.TextXAlignment = Enum.TextXAlignment.Left
                        ItemButton.Parent = Scroller

                        local ItemButtonPadding = Instance.new("UIPadding")
                        ItemButtonPadding.Name = "ItemButtonPadding"
                        ItemButtonPadding.PaddingLeft = UDim.new(0, 10)
                        ItemButtonPadding.Parent = ItemButton

                        if Options.Default == _ then
                            Options.Callback(Item)

                            for _, ItemButtons in pairs(Scroller:GetChildren()) do
                                if ItemButtons:IsA("TextButton") and ItemButtons ~= ItemButton then
                                    MetroLibrary:Tween(
                                        ItemButtons,
                                        0.3 / 2,
                                        Enum.EasingStyle.Sine,
                                        Enum.EasingDirection.Out,
                                        {BackgroundTransparency = 1}
                                    )
                                end
                            end

                            Title.Text = Options.Name .. " [" .. Item .. "]"

                            MetroLibrary:Tween(
                                ItemButton,
                                0.3,
                                Enum.EasingStyle.Sine,
                                Enum.EasingDirection.Out,
                                {BackgroundTransparency = 0.5}
                            )
                        end

                        MetroLibrary:OnClick(
                            ItemButton,
                            function()
                                Options.Callback(Item)

                                for _, ItemButtons in pairs(Scroller:GetChildren()) do
                                    if ItemButtons:IsA("TextButton") and ItemButtons ~= ItemButton then
                                        MetroLibrary:Tween(
                                            ItemButtons,
                                            0.3 / 2,
                                            Enum.EasingStyle.Sine,
                                            Enum.EasingDirection.Out,
                                            {BackgroundTransparency = 1}
                                        )
                                    end
                                end

                                if Options.CloseAfter then
                                    MetroLibrary:Tweens(
                                        {
                                            {
                                                DockerImage,
                                                0.2,
                                                Enum.EasingStyle.Sine,
                                                Enum.EasingDirection.Out,
                                                {Rotation = 0}
                                            },
                                            {
                                                Dropdown,
                                                0.3,
                                                Enum.EasingStyle.Sine,
                                                Enum.EasingDirection.Out,
                                                {Size = UDim2.new(1, 0, 0, 30)}
                                            }
                                        }
                                    )
                                end

                                Title.Text = Options.Name .. " [" .. Item .. "]"

                                MetroLibrary:Tween(
                                    ItemButton,
                                    0.3,
                                    Enum.EasingStyle.Sine,
                                    Enum.EasingDirection.Out,
                                    {BackgroundTransparency = 0.5}
                                )
                            end
                        )
                    end
                end

                local function getPlayers()
                    local Players = {}

                    for _, Player in pairs(game.Players:GetPlayers()) do
                        if (#game.Players:GetPlayers() > 1 and Player ~= game.Players.LocalPlayer or Player) then
                            table.insert(Players, Player)
                        end
                    end

                    return Players
                end

                local function getHeadshot(Player)
                    if Player:IsA("Player") then
                        local content, isReady =
                            game.Players:GetUserThumbnailAsync(
                            Player.UserId,
                            Enum.ThumbnailType.HeadShot,
                            Enum.ThumbnailSize.Size420x420
                        )

                        return content
                    end

                    return false
                end

                function SubSectionFunctions:Playerfield(Options)
                    local Options = Options or {}
                    Options.Size = Options.Size or UDim2.new(1, 0, 0, 50)
                    Options.DefaultPlayer = Options.DefaultPlayer or getPlayers()[1]
                    Options.Callback = Options.Callback or function()
                        end

                    local Playerfield = Instance.new("Frame")
                    Playerfield.Name = "Playerfield"
                    Playerfield.Size = Options.Size
                    Playerfield.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Playerfield.BackgroundTransparency = 1
                    Playerfield.BorderSizePixel = 0
                    Playerfield.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Playerfield.Parent = Contents

                    local PlayerfieldImage = Instance.new("ImageLabel")
                    PlayerfieldImage.Name = "PlayerfieldImage"
                    PlayerfieldImage.Size = UDim2.new(1, 0, 1, 0)
                    PlayerfieldImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    PlayerfieldImage.BackgroundTransparency = 1
                    PlayerfieldImage.BorderSizePixel = 0
                    PlayerfieldImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    PlayerfieldImage.Image = getHeadshot(Options.DefaultPlayer) or "rbxassetid://7072724538"
                    PlayerfieldImage.Parent = Playerfield

                    local PlayerfieldCorner = Instance.new("UICorner")
                    PlayerfieldCorner.Name = "PlayerfieldCorner"
                    PlayerfieldCorner.CornerRadius = UDim.new(1, 0)
                    PlayerfieldCorner.Parent = PlayerfieldImage

                    local PlayerfieldImageAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
                    PlayerfieldImageAspectRatioConstraint.Name = "PlayerfieldImageAspectRatioConstraint"
                    PlayerfieldImageAspectRatioConstraint.Parent = PlayerfieldImage

                    local Display = Instance.new("TextLabel")
                    Display.Name = "Display"
                    Display.AnchorPoint = Vector2.new(0, 1)
                    Display.Size = UDim2.new(1, -55, 0.5, 0)
                    Display.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Display.BackgroundTransparency = 1
                    Display.Position = UDim2.new(0, 55, 1, 0)
                    Display.BorderSizePixel = 0
                    Display.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Display.FontSize = Enum.FontSize.Size14
                    Display.TextSize = 14
                    Display.Text = "@" .. Options.DefaultPlayer.DisplayName
                    Display.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Display.TextYAlignment = Enum.TextYAlignment.Top
                    Display.Font = Enum.Font.Gotham
                    Display.TextTransparency = 0.5
                    Display.TextXAlignment = Enum.TextXAlignment.Left
                    Display.Parent = Playerfield

                    local DisplayPadding = Instance.new("UIPadding")
                    DisplayPadding.Name = "DisplayPadding"
                    DisplayPadding.Parent = Display

                    local Userbox = Instance.new("TextBox")
                    Userbox.Name = "Userbox"
                    Userbox.Size = UDim2.new(1, -55, 0.5, 0)
                    Userbox.Selectable = false
                    Userbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Userbox.BackgroundTransparency = 1
                    Userbox.Position = UDim2.new(0, 55, 0, 0)
                    Userbox.Active = false
                    Userbox.BorderSizePixel = 0
                    Userbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Userbox.FontSize = Enum.FontSize.Size18
                    Userbox.TextYAlignment = Enum.TextYAlignment.Bottom
                    Userbox.TextSize = 18
                    Userbox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Userbox.Text = Options.DefaultPlayer.Name
                    Userbox.Font = Enum.Font.Gotham
                    Userbox.TextXAlignment = Enum.TextXAlignment.Left
                    Userbox.Parent = Playerfield

                    Userbox.FocusLost:Connect(
                        function()
                            local LastUserText = Userbox.Text
                            local LastDisplayText = Display.Text

                            local Players = getPlayers()

                            local User = Userbox.Text

                            local newPlayer = false

                            for _, Player in pairs(Players) do
                                if
                                    (Player.Name:lower():sub(1, #User) == User:lower()) or
                                        (Player.DisplayName:lower():sub(1, #User) == User:lower())
                                 then
                                    newPlayer = Player
                                end
                            end

                            Options.Callback(newPlayer or false)

                            if newPlayer then
                                Userbox.Text = newPlayer.Name
                                Display.Text = "@" .. newPlayer.DisplayName
                                PlayerfieldImage.Image = getHeadshot(newPlayer)
                            else
                                Userbox.Text = LastUserText
                                Display.Text = "@" .. LastDisplayText
                            end
                        end
                    )

                    local UserboxPadding = Instance.new("UIPadding")
                    UserboxPadding.Name = "UserboxPadding"
                    UserboxPadding.Parent = Userbox
                end

                return SubSectionFunctions
            end

            return SectionFunctions
        end

        table.insert(CreatedTabs, TabFunctions)

        if CreatedTabs[1] == TabFunctions then
            TabFunctions:Select()
        end

        return TabFunctions
    end

    return WindowFunctions, Main
end

return MetroLibrary
