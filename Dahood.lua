-- UI code (same as before)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SkinSpawnerGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0, 30)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Text = "Enter Skin Name"
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 18
TextLabel.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 40)
TextBox.PlaceholderText = "e.g., thug, rich, clown"
TextBox.Text = ""
TextBox.TextSize = 16
TextBox.Font = Enum.Font.SourceSans
TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Parent = Frame

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0.5, 0, 0, 35)
Button.Position = UDim2.new(0.25, 0, 1, -45)
Button.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Text = "Spawn"
Button.Font = Enum.Font.Gotham
Button.TextSize = 16
Button.Parent = Frame

-- Skin definitions (visual)
local skins = {
    ["thug"] = {
        Shirt = 1440767602,  -- black hoodie
        Pants = 1440767661,  -- black jeans
        Accessories = { 74891252 } -- bandana
    },
    ["rich"] = {
        Shirt = 398634942,  -- tux
        Pants = 398635081,
        Accessories = { 4512208494 } -- shades
    },
    ["clown"] = {
        Shirt = 383840372,
        Pants = 383840621,
        Accessories = { 182859319 } -- clown wig
    }
}

-- Function to apply a visual skin
local function applySkin(skinName)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local skin = skins[string.lower(skinName)]

    if not skin then
        warn("Skin not found.")
        return
    end

    -- Clear current clothing/accessories
    for _, v in pairs(character:GetChildren()) do
        if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then
            v:Destroy()
        end
    end

    -- Apply new shirt
    if skin.Shirt then
        local shirt = Instance.new("Shirt")
        shirt.ShirtTemplate = "rbxassetid://" .. skin.Shirt
        shirt.Parent = character
    end

    -- Apply new pants
    if skin.Pants then
        local pants = Instance.new("Pants")
        pants.PantsTemplate = "rbxassetid://" .. skin.Pants
        pants.Parent = character
    end

    -- Add accessories
    for _, accId in pairs(skin.Accessories or {}) do
        local accessory = game:GetService("InsertService"):LoadAsset(accId)
        local accessoryItem = accessory:FindFirstChildWhichIsA("Accessory")
        if accessoryItem then
            accessoryItem.Parent = character
        end
        accessory:Destroy()
    end

    print("Applied skin:", skinName)
end

-- Connect button
Button.MouseButton1Click:Connect(function()
    local input = TextBox.Text
    if input ~= "" then
        applySkin(input)
    else
        warn("Please enter a skin name.")
    end
end)
