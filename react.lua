-- React + GUI movible en TPS Street Soccer

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local reachDistance = 6

-- Función para tocar partes (React)
local function touchParts(part1, part2)
    firetouchinterest(part1, part2, 0)
    firetouchinterest(part1, part2, 1)
end

-- Función React
local function react()
    local character = player.Character
    if not character then return end

    local ball = workspace:FindFirstChild("TPSSystem") and workspace.TPSSystem:FindFirstChild("TPS")
    if not ball then return end

    local leftLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftLowerLeg")
    local rightLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightLowerLeg")

    if leftLeg and (ball.Position - leftLeg.Position).Magnitude <= reachDistance then
        touchParts(leftLeg, ball)
    end

    if rightLeg and (ball.Position - rightLeg.Position).Magnitude <= reachDistance then
        touchParts(rightLeg, ball)
    end
end

-- Loop React con delay variable
local function runReactLoop()
    while true do
        react()
        task.wait(math.random(50,150)/1000)
    end
end

-- Crear GUI

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ReactKenyaGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 100)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true -- Esto permite mover el frame con mouse/touch

-- Imagen de fondo
local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Size = UDim2.new(1, 0, 1, 0)
ImageLabel.Position = UDim2.new(0, 0, 0, 0)
ImageLabel.Image = "https://cdn.discordapp.com/attachments/1395910854133813410/1396707851279401081/file_00000000e53861f8b8c7f3ca52eb2fc0.png"
ImageLabel.BackgroundTransparency = 1
ImageLabel.Parent = Frame

-- Texto título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "REACT : KENYA"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextStrokeColor3 = Color3.new(0, 0, 0)
Title.TextStrokeTransparency = 0
Title.Parent = Frame

-- Botón cerrar
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.AutoButtonColor = true
CloseButton.Parent = Frame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Ejecutar React solo si estás en TPS Street Soccer
if game.PlaceId == 1597763879 or game.PlaceId == 335760407 then
    task.spawn(runReactLoop)
    print("[React] React Kenya activo con GUI")
else
    warn("[React] No estás en TPS Street Soccer, React no se activó")
end
