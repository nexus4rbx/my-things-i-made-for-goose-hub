-- by nsyn
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GooseHubGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local function createNotification(text, hasProgressBar)
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Parent = screenGui
    notificationFrame.Size = UDim2.new(0, 300, 0, 60)
    notificationFrame.Position = UDim2.new(1, -320, 1, -70)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    notificationFrame.BackgroundTransparency = 0.8
    notificationFrame.BorderSizePixel = 0
    notificationFrame.ZIndex = 10

    local notificationLabel = Instance.new("TextLabel")
    notificationLabel.Parent = notificationFrame
    notificationLabel.Size = UDim2.new(1, -50, 1, 0)
    notificationLabel.Position = UDim2.new(0, 10, 0, 0)
    notificationLabel.Text = text
    notificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    notificationLabel.TextScaled = true
    notificationLabel.Font = Enum.Font.FredokaOne
    notificationLabel.BackgroundTransparency = 1
    notificationLabel.ZIndex = 11

    if hasProgressBar then
        local progressBar = Instance.new("Frame")
        progressBar.Parent = notificationFrame
        progressBar.Size = UDim2.new(0, 0, 0, 5)
        progressBar.Position = UDim2.new(0, 0, 1, -5)
        progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        progressBar.BorderSizePixel = 0
        progressBar.ZIndex = 11

        local duration = 2.5
        local elapsedTime = 0
        local runService = game:GetService("RunService")

        local function updateProgressBar()
            local dt = runService.RenderStepped:Wait()
            elapsedTime = elapsedTime + dt
            local progress = math.clamp(elapsedTime / duration, 0, 1)
            progressBar.Size = UDim2.new(progress, 0, 0, 5)
            if elapsedTime >= duration then
                notificationFrame:Destroy()
            end
        end

        runService.RenderStepped:Connect(updateProgressBar)
    end
end

local function createArrayList()
    local arrayFrame = Instance.new("Frame")
    arrayFrame.Name = "ArrayListFrame"
    arrayFrame.Parent = screenGui
    arrayFrame.Size = UDim2.new(0, 300, 0, 350)
    arrayFrame.Position = UDim2.new(0, 10, 0, 70)
    arrayFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    arrayFrame.BackgroundTransparency = 0.8
    arrayFrame.BorderSizePixel = 0
    arrayFrame.ZIndex = 10

    local titleFrame = Instance.new("Frame")
    titleFrame.Parent = arrayFrame
    titleFrame.Size = UDim2.new(1, 0, 0, 40)
    titleFrame.Position = UDim2.new(0, 0, 0, 0)
    titleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    titleFrame.BackgroundTransparency = 0.7
    titleFrame.BorderSizePixel = 0
    titleFrame.ZIndex = 11

    local title = Instance.new("TextLabel")
    title.Parent = titleFrame
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "Arraylist by nsyn"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.FredokaOne
    title.BackgroundTransparency = 1
    title.ZIndex = 12

    local itemTexts = {"Blade Ball", "Goose Hub v4"}
    table.sort(itemTexts)

    for i, text in ipairs(itemTexts) do
        local itemFrame = Instance.new("Frame")
        itemFrame.Parent = arrayFrame
        itemFrame.Size = UDim2.new(1, 0, 0, 40)
        itemFrame.Position = UDim2.new(0, 0, 0, 50 * i + 40)
        itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        itemFrame.BackgroundTransparency = 0.7
        itemFrame.BorderSizePixel = 0
        itemFrame.ZIndex = 11

        local item = Instance.new("TextLabel")
        item.Parent = itemFrame
        item.Size = UDim2.new(1, 0, 1, 0)
        item.Position = UDim2.new(0, 10, 0, 0)
        item.Text = text
        item.TextColor3 = Color3.fromRGB(255, 255, 255)
        item.TextScaled = true
        item.Font = Enum.Font.FredokaOne
        item.BackgroundTransparency = 1
        item.ZIndex = 12
    end

    return arrayFrame
end

local function createCustomizationPanel(arrayFrame)
    local customizationFrame = Instance.new("Frame")
    customizationFrame.Name = "CustomizationFrame"
    customizationFrame.Parent = screenGui
    customizationFrame.Size = UDim2.new(0, 300, 0, 100)
    customizationFrame.Position = UDim2.new(0, 10, 0, 420)
    customizationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    customizationFrame.BackgroundTransparency = 0.8
    customizationFrame.BorderSizePixel = 0
    customizationFrame.ZIndex = 10

    local fontColorButton = Instance.new("TextButton")
    fontColorButton.Parent = customizationFrame
    fontColorButton.Size = UDim2.new(0, 140, 0, 40)
    fontColorButton.Position = UDim2.new(0, 10, 0, 10)
    fontColorButton.Text = "Change Font Color"
    fontColorButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    fontColorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    fontColorButton.TextScaled = true
    fontColorButton.Font = Enum.Font.FredokaOne

    fontColorButton.MouseButton1Click:Connect(function()
        local newColor = Color3.fromRGB(math.random(255), math.random(255), math.random(255))
        for _, itemFrame in ipairs(arrayFrame:GetChildren()) do
            if itemFrame:IsA("Frame") and itemFrame.Name ~= "TitleFrame" then
                for _, item in ipairs(itemFrame:GetChildren()) do
                    if item:IsA("TextLabel") then
                        item.TextColor3 = newColor
                    end
                end
            end
        end
    end)

    local toggleBackgroundButton = Instance.new("TextButton")
    toggleBackgroundButton.Parent = customizationFrame
    toggleBackgroundButton.Size = UDim2.new(0, 140, 0, 40)
    toggleBackgroundButton.Position = UDim2.new(0, 160, 0, 10)
    toggleBackgroundButton.Text = "Toggle Background"
    toggleBackgroundButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleBackgroundButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBackgroundButton.TextScaled = true
    toggleBackgroundButton.Font = Enum.Font.FredokaOne

    local backgroundVisible = true
    toggleBackgroundButton.MouseButton1Click:Connect(function()
        backgroundVisible = not backgroundVisible
        for _, itemFrame in ipairs(arrayFrame:GetChildren()) do
            if itemFrame:IsA("Frame") and itemFrame.Name ~= "TitleFrame" then
                itemFrame.BackgroundTransparency = backgroundVisible and 0.7 or 1
            end
        end
    end)
end

local arrayFrame = createArrayList()
createNotification("Goose Hub Loaded", true)
createCustomizationPanel(arrayFrame)
