local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local WIDTH = 300
local TITLE_HEIGHT = 45
local CONTENT_HEIGHT = 170
local MINIMIZED = false

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, WIDTH, 0, TITLE_HEIGHT + CONTENT_HEIGHT)
MainFrame.Position = UDim2.new(0.5, -WIDTH/2, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- TITLE BAR
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1,0,0,TITLE_HEIGHT)
TitleBar.BackgroundColor3 = Color3.fromRGB(40,40,40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- Title centrado
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,1,0)
Title.BackgroundTransparency = 1
Title.Text = "OBBY GUI"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.TextYAlignment = Enum.TextYAlignment.Center
Title.Parent = TitleBar

-- MINIMIZE BUTTON
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0,30,0,30)
MinBtn.Position = UDim2.new(1,-35,0,7)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.Parent = TitleBar

-- CONTENT FRAME
local Content = Instance.new("Frame")
Content.Position = UDim2.new(0,0,0,TITLE_HEIGHT)
Content.Size = UDim2.new(1,0,0,CONTENT_HEIGHT)
Content.BackgroundColor3 = Color3.fromRGB(40,40,40)
Content.BorderSizePixel = 0
Content.Parent = MainFrame

-- BUTTON CREATOR
local function makeButton(text, y, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.85,0,0,40)
    b.Position = UDim2.new(0.075,0,0,y)
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 18
    b.Parent = Content
    b.MouseButton1Click:Connect(callback)
end

makeButton("Auto obby", 10, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text72/refs/heads/main/Text72.lua", true))()
end)

makeButton("Auto obby v2", 60, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text71/refs/heads/main/Text71.lua", true))()
end)

makeButton("Auto obby manual", 110, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text73/refs/heads/main/Text73.lua", true))()
end)

-- MINIMIZE LOGIC
MinBtn.MouseButton1Click:Connect(function()
    MINIMIZED = not MINIMIZED
    local targetSize = MINIMIZED and TITLE_HEIGHT or (TITLE_HEIGHT + CONTENT_HEIGHT)
    TweenService:Create(
        MainFrame,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, WIDTH, 0, targetSize)}
    ):Play()
    MinBtn.Text = MINIMIZED and "+" or "-"
end)

-- DRAG SEGURO (PC y Móvil)
local dragging, dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
