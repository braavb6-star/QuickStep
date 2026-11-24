
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "QuickStep"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(220, 145)
frame.Position = UDim2.new(0.5, -110, 0.5, -72)
frame.BackgroundColor3 = Color3.fromRGB(18, 20, 29)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius =
    UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "QUICK STEP"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.Parent = frame

local info = Instance.new("TextLabel")
info.Position = UDim2.fromOffset(5, 38)
info.Size = UDim2.new(1, -10, 0, 28)
info.BackgroundTransparency = 1
info.Text = "Nearest: None"
info.TextColor3 = Color3.new(1,1,1)
info.TextSize = 12
info.Parent = frame

local btn = Instance.new("TextButton")
btn.Position = UDim2.fromOffset(10, 78)
btn.Size = UDim2.new(1, -20, 0, 45)
btn.BackgroundColor3 = Color3.fromRGB(0, 130, 220)
btn.Text = "TELEPORT"
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 15
btn.Parent = frame

Instance.new("UICorner", btn).CornerRadius =
    UDim.new(0, 9)

local function nearestPlayer()
    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local best, distance = nil, math.huge

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local c = p.Character
            local r = c and c:FindFirstChild("HumanoidRootPart")
            local h = c and c:FindFirstChildOfClass("Humanoid")

            if r and h and h.Health > 0 then
                local d = (root.Position-r.Position).Magnitude
                if d < distance then
                    best = r
                    distance = d
                end
            end
        end
    end

    return best, distance
end

btn.MouseButton1Click:Connect(function()
    local target, distance = nearestPlayer()

    if target then
        info.Text = target.Parent.Name ..
            " | " .. math.floor(distance) .. " studs"

        -- لا يوجد نقل فعلي هنا؛ يلزم منطق انتقال
        -- ينفذه السيرفر في تجربة تملكها.
    else
        info.Text = "No player found"
    end
end)

gui.Parent = game:GetService("CoreGui")
