local players = game:GetService("Players")
local player = players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")
local replicatedStorage = game:GetService("ReplicatedStorage")
local muscleEvent = player:WaitForChild("muscleEvent")
local leaderstats = player:WaitForChild("leaderstats")
local rebirthsStat = leaderstats:WaitForChild("Rebirths")
local displayName = player.DisplayName
local virtualUser = game:GetService("VirtualUser")
local lighting = game:GetService("Lighting")
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/imhenne187/SilenceElerium/refs/heads/main/src/SilenceEleriumLibrary.luau", true))()
local window = library:AddWindow("Foxxy | Main - Hello " .. displayName, {
 title_bar = {Color3.fromRGB(40, 1, 55), Color3.fromRGB(20, 1, 28), Color3.fromRGB(25, 1, 14)},
 title_bar_transparency = 0.2,
 background = {Color3.fromRGB(40, 1, 55), Color3.fromRGB(20, 1, 28), Color3.fromRGB(25, 1, 14)},
 background_transparency = 0.1,
 main_color = Color3.fromRGB(40, 1, 55),
 min_size = Vector2.new(400, 330),
})
player.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
end)
local function deleteAds()
    for _, portal in pairs(game:GetDescendants()) do
        if portal.Name == "RobloxForwardPortals" then
            portal:Destroy()
        end
    end
    if _G.ads then
        _G.ads:Disconnect()
    end
    _G.ads = game.DescendantAdded:Connect(function(descendant)
        if descendant.Name == "RobloxForwardPortals" then
            descendant:Destroy()
        end
    end)
end
deleteAds()
local MainTab = window:AddTab("Main")
MainTab:Show()
MainTab:AddLabel("Protection and Visuals:").TextSize = 20
MainTab:AddButton("Execute Infinite Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
MainTab:AddButton("Execute Anti Lag", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/juywvm/-Roblox-Projects-/main/____Anti_Afk_Remastered_______"))()
end)
MainTab:AddButton("Rejoin", function()
    local TeleportService = game:GetService("TeleportService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)
local running = false
local running = false
local running = false
local running = false
local thread
local running = false
local thread
local antiKnockbackSwitch = MainTab:AddSwitch("Anti Fling", function(bool)
    if bool then
        local playerName = game.Players.LocalPlayer.Name
        local character = game.Workspace:FindFirstChild(playerName)
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.P = 1250
                bodyVelocity.Parent = rootPart
            end
        end
    else
        local playerName = game.Players.LocalPlayer.Name
        local character = game.Workspace:FindFirstChild(playerName)
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
                if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
                    existingVelocity:Destroy()
                end
            end
        end
    end
end)
antiKnockbackSwitch:Set(true)
local posLocked = false
local lockedPosition = nil
local function lockPosition()
    if not posLocked or not lockedPosition then
        return
    end
    local currentCharacter = player.Character
    if not currentCharacter then
        return
    end
    local rootPart = currentCharacter:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        return
    end
    local existingPosition = rootPart:FindFirstChild("PositionLocker")
    if existingPosition then
        existingPosition.Position = lockedPosition
    else
        local bodyPosition = Instance.new("BodyPosition")
        bodyPosition.Name = "PositionLocker"
        bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyPosition.Position = lockedPosition
        bodyPosition.P = 100000
        bodyPosition.Parent = rootPart
    end
end
local function unlockPosition()
    local currentCharacter = player.Character
    if currentCharacter then
        local rootPart = currentCharacter:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local existingPosition = rootPart:FindFirstChild("PositionLocker")
            if existingPosition then
                existingPosition:Destroy()
            end
        end
    end
    lockedPosition = nil
end
local lockPositionSwitch = MainTab:AddSwitch("Lock Position", function(bool)
    posLocked = bool
    if bool then
        local currentRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if currentRootPart then
            lockedPosition = currentRootPart.Position
        end
        lockPosition()
    else
        unlockPosition()
    end
end)
player.CharacterAdded:Connect(function(newCharacter)
    local rootPart = newCharacter:WaitForChild("HumanoidRootPart", 5)
    if posLocked and rootPart then
        lockedPosition = rootPart.Position
        lockPosition()
    end
end)
task.spawn(function()
    while true do
        if posLocked then
            lockPosition()
        end
        task.wait(0.1)
    end
end)
local showPetsSwitch = MainTab:AddSwitch("Show Pets", function(bool)
    local player = game:GetService("Players").LocalPlayer
    if player:FindFirstChild("hidePets") then
        player.hidePets.Value = bool
    end
end)
showPetsSwitch:Set(false)
local showOthersPetsSwitch = MainTab:AddSwitch("Show Others Pets", function(bool)
    local player = game:GetService("Players").LocalPlayer
    if player:FindFirstChild("showOtherPetsOn") then
        player.showOtherPetsOn.Value = bool
    end
end)
showOthersPetsSwitch:Set(false)
local blockedFrames = {
    "strengthFrame",
    "durabilityFrame",
    "agilityFrame",
    "evilKarmaFrame",
    "goodKarmaFrame",
}
local hideStatFramesSwitch = MainTab:AddSwitch("Hide Stat Frames", function(bool)
    if bool then
        for _, name in ipairs(blockedFrames) do
            local frame = replicatedStorage:FindFirstChild(name)
            if frame and frame:IsA("GuiObject") then
                frame.Visible = false
            end
        end
        if not _G.frameMonitorConnection then
            _G.frameMonitorConnection = replicatedStorage.ChildAdded:Connect(function(child)
                for _, name in ipairs(blockedFrames) do
                    if child.Name == name and child:IsA("GuiObject") then
                        child.Visible = false
                    end
                end
            end)
        end
    else
        for _, name in ipairs(blockedFrames) do
            local frame = replicatedStorage:FindFirstChild(name)
            if frame and frame:IsA("GuiObject") then
                frame.Visible = true
            end
        end
        if _G.frameMonitorConnection then
            _G.frameMonitorConnection:Disconnect()
            _G.frameMonitorConnection = nil
        end
    end
end)
hideStatFramesSwitch:Set(true)
local parts = {}
local partSize = 2048
local totalDistance = 50000
local startPosition = Vector3.new(-2, -9.5, -2)
local function createAllParts()
    local numberOfParts = math.ceil(totalDistance / partSize)
    for x = 0, numberOfParts - 1 do
        for z = 0, numberOfParts - 1 do
            local function createPart(pos, name)
                local part = Instance.new("Part")
                part.Size = Vector3.new(partSize, 1, partSize)
                part.Position = pos
                part.Anchored = true
                part.Transparency = 1
                part.CanCollide = true
                part.Name = name
                part.Parent = workspace
                return part
            end
            table.insert(parts, createPart(startPosition + Vector3.new(x*partSize,0,z*partSize), "Part_Side_"..x.."_"..z))
            table.insert(parts, createPart(startPosition + Vector3.new(-x*partSize,0,z*partSize), "Part_LeftRight_"..x.."_"..z))
            table.insert(parts, createPart(startPosition + Vector3.new(-x*partSize,0,-z*partSize), "Part_UpLeft_"..x.."_"..z))
            table.insert(parts, createPart(startPosition + Vector3.new(x*partSize,0,-z*partSize), "Part_UpRight_"..x.."_"..z))
        end
    end
end
task.spawn(createAllParts)
local walkOnWaterSwitch = MainTab:AddSwitch("Walk On Water", function(bool)
    for _, part in ipairs(parts) do
        if part and part.Parent then
            part.CanCollide = bool
        end
    end
end)
walkOnWaterSwitch:Set(true)