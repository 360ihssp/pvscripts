local Services = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    Workspace = workspace,
    RunService = game:GetService("RunService")
}

local PlayerData = {
    Player = Services.Players.LocalPlayer,
    DisplayName = Services.Players.LocalPlayer.DisplayName,
    Character = Services.Players.LocalPlayer.Character,
    Humanoid = nil,
    Camera = Services.Workspace.CurrentCamera,
    Backpack = Services.Players.LocalPlayer:WaitForChild("Backpack")
}

PlayerData.Humanoid = PlayerData.Character and PlayerData.Character:FindFirstChildOfClass("Humanoid")

local Remotes = {
    MuscleEvent = PlayerData.Player.muscleEvent
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local muscleEvent = Player:WaitForChild("muscleEvent")
local LocalPlayer = Players.LocalPlayer
local players = game:GetService("Players")
local player = players.LocalPlayer

local Utils = {}

function Utils.formatNumber(n)
    if n >= 1e15 then return string.format("%.1fqa", n / 1e15)
    elseif n >= 1e12 then return string.format("%.1ft", n / 1e12)
    elseif n >= 1e9 then return string.format("%.1fb", n / 1e9)
    elseif n >= 1e6 then return string.format("%.1fm", n / 1e6)
    elseif n >= 1e3 then return string.format("%.1fk", n / 1e3)
    else return tostring(n) end
end

function Utils.formatWithCommas(n)
    local formatted = tostring(math.floor(n))
    while true do
        formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        if k == 0 then break end
    end
    return formatted
end

function Utils.greeting()
    return "Hello " .. PlayerData.DisplayName
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/empresstreee/pvscripts/refs/heads/main/MukiUi", true))()

local window = library:AddWindow("TreeXMuki | Private Killing | " .. Utils.greeting(), {
    main_color = Color3.fromRGB(96, 96, 96),
    min_size = Vector2.new(500, 750)
})

local n="RobloxForwardPortals";game.DescendantAdded:Connect(function(v)if v.Name==n then v:Destroy()end end)for _,v in game:GetDescendants()do if v.Name==n then v:Destroy()end end

local Tabs = {
    Main = window:AddTab("   Main   "),
    Killing = window:AddTab("   Killing   "),
    GodMode = window:AddTab("   GodMode   "),
    Specs = window:AddTab("   Specs   "),
    Inventory = window:AddTab("   Inventory   "),
    Teleport = window:AddTab("   Teleports   ")
}
Tabs.Killing:Show()

local CreditsLabel = Tabs.Main:AddLabel("Credits: Tree")
CreditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditsLabel.Font = Enum.Font.PermanentMarker
CreditsLabel.TextSize = 50

Tabs.Main:AddLabel("————————————————————————————————")

local EssentialsLabel = Tabs.Main:AddLabel("Essentials:")
EssentialsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
EssentialsLabel.Font = Enum.Font.PermanentMarker
EssentialsLabel.TextSize = 35

Tabs.Main:AddButton("Loada Anti Lag", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/juywvm/-Roblox-Projects-/main/____Anti_Afk_Remastered_______"))()
end)

local Protection = {
    AntiFling = {Enabled = false},
    PositionLock = {Enabled = false, Position = nil}
}

local function eAntiFling()
	if not Protection.AntiFling.Enabled or not PlayerData.Player.Character then return end
	if not PlayerData.Player.Character:FindFirstChild("HumanoidRootPart") then return end
	if PlayerData.Player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") and 
	   PlayerData.Player.Character.HumanoidRootPart.BodyVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
		PlayerData.Player.Character.HumanoidRootPart.BodyVelocity:Destroy()
	end
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(100000, 0, 100000)
	bv.Velocity = Vector3.new(0, 0, 0)
	bv.P = 1250
	bv.Parent = PlayerData.Player.Character.HumanoidRootPart
end

local function dAntiFling()
	if not PlayerData.Player.Character or not PlayerData.Player.Character:FindFirstChild("HumanoidRootPart") then return end
	if PlayerData.Player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") and 
	   PlayerData.Player.Character.HumanoidRootPart.BodyVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
		PlayerData.Player.Character.HumanoidRootPart.BodyVelocity:Destroy()
	end
end

Tabs.Main:AddSwitch("Anti Fling", function(bool)
	Protection.AntiFling.Enabled = bool
	if bool then eAntiFling() else dAntiFling() end
end):Set(false)

PlayerData.Player.CharacterAdded:Connect(function(newChar)
	newChar:WaitForChild("HumanoidRootPart", 5)
	if Protection.AntiFling.Enabled then eAntiFling() end
end)

local function lockPosition()
	eAntiFling()
	if not Protection.PositionLock.Enabled or not Protection.PositionLock.Position or not PlayerData.Player.Character then return end
	if not PlayerData.Player.Character:FindFirstChild("HumanoidRootPart") then return end
	if PlayerData.Player.Character.HumanoidRootPart:FindFirstChild("PositionLocker") then
		PlayerData.Player.Character.HumanoidRootPart.PositionLocker.Position = Protection.PositionLock.Position
	else
		dAntiFling()
		local bp = Instance.new("BodyPosition")
		bp.Name = "PositionLocker"
		bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bp.Position = Protection.PositionLock.Position
		bp.P = 100000
		bp.Parent = PlayerData.Player.Character.HumanoidRootPart
	end
end

local function unlockPosition()
	if PlayerData.Player.Character and PlayerData.Player.Character:FindFirstChild("HumanoidRootPart") then
		if PlayerData.Player.Character.HumanoidRootPart:FindFirstChild("PositionLocker") then
			PlayerData.Player.Character.HumanoidRootPart.PositionLocker:Destroy()
		end
	end
	Protection.PositionLock.Position = nil
end

Tabs.Main:AddSwitch("Lock Position", function(bool)
	Protection.PositionLock.Enabled = bool
	if bool then
		if PlayerData.Player.Character and PlayerData.Player.Character:FindFirstChild("HumanoidRootPart") then
			Protection.PositionLock.Position = PlayerData.Player.Character.HumanoidRootPart.Position
		end
		lockPosition()
	else
		unlockPosition()
	end
end)

PlayerData.Player.CharacterAdded:Connect(function(newChar)
	if Protection.PositionLock.Enabled and newChar:WaitForChild("HumanoidRootPart", 5) then
		Protection.PositionLock.Position = newChar.HumanoidRootPart.Position
		lockPosition()
	end
end)

task.spawn(function()
	while true do
		if Protection.PositionLock.Enabled then lockPosition() end
		task.wait(0.1)
	end
end)

Tabs.Main:AddButton("Load Infinite Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

local ShowPetsSwitch = Tabs.Main:AddSwitch("Show Pets", function(bool)
    if PlayerData.Player:FindFirstChild("hidePets") then
        PlayerData.Player.hidePets.Value = bool
    end
end)
ShowPetsSwitch:Set(false)

local ShowOtherPetsSwitch = Tabs.Main:AddSwitch("Show other Pets", function(bool)
	if PlayerData.Player:FindFirstChild("showOtherPetsOn") then
		PlayerData.Player.showOtherPetsOn.Value = bool
	end
end)
ShowOtherPetsSwitch:Set(false)

Tabs.Main:AddButton("Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, lp)
end)

local HideFramesSwitch = Tabs.Main:AddSwitch("Hide Frames", function(bool)
    for _, obj in pairs(ReplicatedStorage:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not bool
        end
    end
end)
HideFramesSwitch:Set(true)

local WaterParts = {
	Parts = {},
	PartSize = 2048,
	TotalDistance = 50000,
	StartPosition = Vector3.new(-2, -9.5, -2)
}

task.spawn(function()
	for x = 0, math.ceil(WaterParts.TotalDistance / WaterParts.PartSize) - 1 do
		for z = 0, math.ceil(WaterParts.TotalDistance / WaterParts.PartSize) - 1 do
			for i, offset in ipairs({
				{x * WaterParts.PartSize, z * WaterParts.PartSize, "Side_" .. x .. "_" .. z},
				{-x * WaterParts.PartSize, z * WaterParts.PartSize, "LeftRight_" .. x .. "_" .. z},
				{-x * WaterParts.PartSize, -z * WaterParts.PartSize, "UpLeft_" .. x .. "_" .. z},
				{x * WaterParts.PartSize, -z * WaterParts.PartSize, "UpRight_" .. x .. "_" .. z}
			}) do
				local part = Instance.new("Part")
				part.Size = Vector3.new(WaterParts.PartSize, 1, WaterParts.PartSize)
				part.Position = WaterParts.StartPosition + Vector3.new(offset[1], 0, offset[2])
				part.Anchored = true
				part.Transparency = 1
				part.CanCollide = true
				part.Name = "Part_" .. offset[3]
				part.Parent = Services.Workspace
				table.insert(WaterParts.Parts, part)
			end
		end
	end
end)

local WalkOnWaterSwitch = Tabs.Main:AddSwitch("Walk on Water", function(bool)
	for _, part in ipairs(WaterParts.Parts) do
		if part and part.Parent then part.CanCollide = bool end
	end
end)
WalkOnWaterSwitch:Set(true)

Tabs.Main:AddSwitch("Fast Punch", function(state)
	_G.autoPunchActive = state
	local player = LocalPlayer
	local function apply(punch)
		if not punch then return end
		local attackTime = punch:FindFirstChild("attackTime")
		if attackTime then
			attackTime.Value = 0
		end
	end
	local function equipPunch()
		if not _G.autoPunchActive then return end
		local char = player.Character
		if not char then return end
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if not humanoid then return end
		local backpack = player.Backpack
		if not backpack then return end
		local punch = backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
		if not punch then return end
		humanoid:EquipTool(punch)
		apply(punch)
	end
	if state then
		player.CharacterAdded:Connect(function()
			task.wait(0.01)
			equipPunch()
		end)
		task.spawn(function()
			task.wait(0.1)
			equipPunch()
		end)
		task.spawn(function()
			while _G.autoPunchActive do
				local char = player.Character
				local punch = char and char:FindFirstChild("Punch")
				if punch then
					apply(punch)
				end
				task.wait(0.1)
			end
		end)
		task.spawn(function()
			while _G.autoPunchActive do
				local punch = player.Character and player.Character:FindFirstChild("Punch")
				if punch then
					punch:Activate()
				end
				task.wait()
			end
		end)
	end
end)

local function checkCharacter()
	if not Services.Players.LocalPlayer.Character then
		repeat task.wait() until Services.Players.LocalPlayer.Character
	end
	return Services.Players.LocalPlayer.Character
end

local function gettool()
	for _, v in pairs(Services.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.Name == "Punch" and Services.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			Services.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
		end
	end
	Services.Players.LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
	Services.Players.LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local function isPlayerAlive(player)
	return player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and 
		player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function killPlayer(target)
	if not isPlayerAlive(target) or not checkCharacter():FindFirstChild("LeftHand") then return end
	pcall(function()
		firetouchinterest(target.Character.HumanoidRootPart, checkCharacter().LeftHand, 0)
		firetouchinterest(target.Character.HumanoidRootPart, checkCharacter().LeftHand, 1)
		gettool()
	end)
end

MiscellaneousLabel = Tabs.Killing:AddLabel("Miscellaneous:")
MiscellaneousLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MiscellaneousLabel.Font = Enum.Font.PermanentMarker
MiscellaneousLabel.TextSize = 35

local StatPetEquipDropdown = Tabs.Killing:AddDropdown("Stat Pet Equip", function(text)
	for _, folder in pairs(Services.Players.LocalPlayer.petsFolder:GetChildren()) do
		if folder:IsA("Folder") then
			for _, pet in pairs(folder:GetChildren()) do
				Services.ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
			end
		end
	end
	task.wait(0.1)
	local petsToEquip = {}
	for _, pet in pairs(Services.Players.LocalPlayer.petsFolder.Unique:GetChildren()) do
		if pet.Name == text then table.insert(petsToEquip, pet) end
	end
	for i = 1, math.min(8, #petsToEquip) do
		Services.ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", petsToEquip[i])
		task.wait(0.1)
	end
end)

for _, petName in ipairs({"Wild Wizard", "Mighty Monster"}) do
	StatPetEquipDropdown:Add(petName)
end

Tabs.Killing:AddSwitch("Remove attack Animations", function(bool)
	if bool then
		local blockedAnimations = {
			["rbxassetid://3638729053"] = true,
			["rbxassetid://3638767427"] = true,
		}
		local function setupAnimationBlocking()
			local char = Services.Players.LocalPlayer.Character
			if not char or not char:FindFirstChild("Humanoid") then
				return
			end
			for _, track in pairs(PlayerData.Humanoid:GetPlayingAnimationTracks()) do
				if track.Animation then
					local animId = track.Animation.AnimationId
					local animName = track.Name:lower()
					if
						blockedAnimations[animId]
						or animName:match("punch")
						or animName:match("attack")
						or animName:match("right")
					then
						track:Stop()
					end
				end
			end
			_G.AnimBlockConnection = PlayerData.Humanoid.AnimationPlayed:Connect(function(track)
				if track.Animation then
					local animId = track.Animation.AnimationId
					local animName = track.Name:lower()
					if
						blockedAnimations[animId]
						or animName:match("punch")
						or animName:match("attack")
						or animName:match("right")
					then
						track:Stop()
					end
				end
			end)
		end
		local function processTool(tool)
			if tool and (tool.Name == "Punch" or tool.Name:match("Attack") or tool.Name:match("Right")) then
				if not tool:GetAttribute("ActivatedOverride") then
					tool:SetAttribute("ActivatedOverride", true)
					_G.ToolConnections = _G.ToolConnections or {}
					_G.ToolConnections[tool] = tool.Activated:Connect(function()
						task.wait(0.01)
						local char = Services.Players.LocalPlayer.Character
						if char and char:FindFirstChild("Humanoid") then
							for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
								if track.Animation then
									local animId = track.Animation.AnimationId
									local animName = track.Name:lower()
									if
										blockedAnimations[animId]
										or animName:match("punch")
										or animName:match("attack")
										or animName:match("right")
									then
										track:Stop()
									end
								end
							end
						end
					end)
				end
			end
		end
		local function overrideToolActivation()
			for _, tool in pairs(Services.Players.LocalPlayer.Backpack:GetChildren()) do
				processTool(tool)
			end
			local char = Services.Players.LocalPlayer.Character
			if char then
				for _, tool in pairs(char:GetChildren()) do
					if tool:IsA("Tool") then
						processTool(tool)
					end
				end
			end
			_G.BackpackAddedConnection = Services.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(child)
				if child:IsA("Tool") then
					task.wait(0.1)
					processTool(child)
				end
			end)
			if char then
				_G.CharacterToolAddedConnection = char.ChildAdded:Connect(function(child)
					if child:IsA("Tool") then
						task.wait(0.1)
						processTool(child)
					end
				end)
			end
		end
		_G.AnimMonitorConnection = Services.RunService.Heartbeat:Connect(function()
			if tick() % 0.5 < 0.01 then
				local char = Services.Players.LocalPlayer.Character
				if char and char:FindFirstChild("Humanoid") then
					for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
						if track.Animation then
							local animId = track.Animation.AnimationId
							local animName = track.Name:lower()
							if
								blockedAnimations[animId]
								or animName:match("punch")
								or animName:match("attack")
								or animName:match("right")
							then
								track:Stop()
							end
						end
					end
				end
			end
		end)
		_G.CharacterAddedConnection = Services.Players.LocalPlayer.CharacterAdded:Connect(function(newChar)
			task.wait(1)
			setupAnimationBlocking()
			overrideToolActivation()
			if _G.CharacterToolAddedConnection then
				_G.CharacterToolAddedConnection:Disconnect()
			end
			_G.CharacterToolAddedConnection = newChar.ChildAdded:Connect(function(child)
				if child:IsA("Tool") then
					task.wait(0.1)
					processTool(child)
				end
			end)
		end)
		setupAnimationBlocking()
		overrideToolActivation()
	else
		if _G.AnimBlockConnection then
			_G.AnimBlockConnection:Disconnect()
			_G.AnimBlockConnection = nil
		end
		if _G.AnimMonitorConnection then
			_G.AnimMonitorConnection:Disconnect()
			_G.AnimMonitorConnection = nil
		end
		if _G.CharacterAddedConnection then
			_G.CharacterAddedConnection:Disconnect()
			_G.CharacterAddedConnection = nil
		end
		if _G.BackpackAddedConnection then
			_G.BackpackAddedConnection:Disconnect()
			_G.BackpackAddedConnection = nil
		end
		if _G.CharacterToolAddedConnection then
			_G.CharacterToolAddedConnection:Disconnect()
			_G.CharacterToolAddedConnection = nil
		end
		if _G.ToolConnections then
			for tool, connection in pairs(_G.ToolConnections) do
				if connection then
					connection:Disconnect()
				end
				if tool and tool:GetAttribute("ActivatedOverride") then
					tool:SetAttribute("ActivatedOverride", nil)
				end
			end
			_G.ToolConnections = nil
		end
	end
end)

local DisableEggState = {
	enabled = false,
	connections = {}
}

local function noEgg(tool)
	for _, desc in ipairs(tool:GetDescendants()) do
		if desc:IsA("Script") or desc:IsA("LocalScript") then
			if desc:IsA("LocalScript") then desc.Disabled = true else desc:Destroy() end
		end
		if desc:IsA("RemoteEvent") then pcall(function() desc.FireServer = function() end end) end
	end
end

local function setupEggDisable()
	for _, container in ipairs({PlayerData.Player.Backpack, PlayerData.Player.Character}) do
		if container then
			for _, tool in ipairs(container:GetChildren()) do
				if tool:IsA("Tool") and tool.Name == "Protein Egg" then noEgg(tool) end
			end
			local conn = container.ChildAdded:Connect(function(child)
				if DisableEggState.enabled and child:IsA("Tool") and child.Name == "Protein Egg" then 
					task.defer(noEgg, child) 
				end
			end)
			table.insert(DisableEggState.connections, conn)
		end
	end
end

local function cleanupEggDisable()
	for _, conn in ipairs(DisableEggState.connections) do
		conn:Disconnect()
	end
	DisableEggState.connections = {}
end

Tabs.Killing:AddSwitch("Block eating Eggs", function(bool)
	DisableEggState.enabled = bool
	if bool then
		setupEggDisable()
	else
		cleanupEggDisable()
	end
end)

PlayerData.Player.CharacterAdded:Connect(function(character)
	if DisableEggState.enabled then
		cleanupEggDisable()
		task.wait(0.1)
		setupEggDisable()
	end
end)

local sizeToSet = 0/0
local megaSwitchEnabled = false

local posLockConnection
local safePlatform

local REMOTE = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("changeSpeedSizeRemote")

local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHRP(char)
    return char:WaitForChild("HumanoidRootPart")
end

local function moveToolToCharacter(toolName)
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    local tool = backpack:FindFirstChild(toolName)
    if tool then
        tool.Parent = LocalPlayer.Character
    end
end

Tabs.Killing:AddSwitch("Egg + Nan Combo [Spawn]", function(state)
    megaSwitchEnabled = state
    if state then
        local posX, posY, posZ = 100000, -200, 100000
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        safePlatform = Instance.new("Part")
        safePlatform.Size = Vector3.new(50, 1, 50)
        safePlatform.Position = Vector3.new(posX, posY - 3, posZ)
        safePlatform.Anchored = true
        safePlatform.CanCollide = true
        safePlatform.Color = Color3.fromRGB(255, 0, 0)
        safePlatform.Name = "SafePlatform"
        safePlatform.Parent = workspace
        task.wait(0.1)
        humanoidRootPart.CFrame = CFrame.new(16.07, 9.08, 133.8)
        local currentPos = humanoidRootPart.CFrame
        posLockConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = currentPos
            end
        end)
        task.spawn(function()
            while megaSwitchEnabled do
                pcall(function()
                    game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", sizeToSet)
                end)
                local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
                if punch then
                    punch.Parent = LocalPlayer.Character
                end
                local egg = LocalPlayer.Backpack:FindFirstChild("Protein Egg")
                if egg then
                    egg.Parent = LocalPlayer.Character
                end
                local punchTool = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character:FindFirstChild("Punch")
                if punchTool then
                    if punchTool.Parent ~= LocalPlayer.Character then
                        punchTool.Parent = LocalPlayer.Character
                    end
                    LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                    LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                end
                task.wait(0.01)
            end
        end)
    else
        if posLockConnection then
            posLockConnection:Disconnect()
            posLockConnection = nil
        end
        if safePlatform then
            safePlatform:Destroy()
            safePlatform = nil
        end
    end
end)

Tabs.Killing:AddSwitch("NaN + Egg [UnderWater] {Anti Slam}", function(state)
    megaSwitchEnabled = state
    if state then
        local posX, posY, posZ = 100000, -200, 100000
        local character = getCharacter()
        local humanoidRootPart = getHRP(character)
        safePlatform = Instance.new("Part")
        safePlatform.Size = Vector3.new(50, 1, 50)
        safePlatform.Position = Vector3.new(posX, posY - 3, posZ)
        safePlatform.Anchored = true
        safePlatform.CanCollide = true
        safePlatform.Color = Color3.fromRGB(255, 0, 0)
        safePlatform.Name = "SafePlatform"
        safePlatform.Parent = workspace
        task.wait(0.1)
        humanoidRootPart.CFrame = CFrame.new(posX, posY, posZ)
        local lockedCFrame = humanoidRootPart.CFrame
        posLockConnection = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = lockedCFrame
            end
        end)
        task.spawn(function()
            while megaSwitchEnabled do
                pcall(function()
                    REMOTE:InvokeServer("changeSize", sizeToSet)
                end)
                moveToolToCharacter("Punch")
                moveToolToCharacter("Protein Egg")
                local punchTool =
                    LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
                    or LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Punch")
                if punchTool and punchTool.Parent == LocalPlayer.Character then
                    LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                    LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                end
                task.wait(0.01)
            end
        end)
    else
        if posLockConnection then
            posLockConnection:Disconnect()
            posLockConnection = nil
        end
        if safePlatform then
            safePlatform:Destroy()
            safePlatform = nil
        end
    end
end)

Tabs.Killing:AddLabel("————————————————————————————————")

KillAllLabel = Tabs.Killing:AddLabel("Kill All:")
KillAllLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KillAllLabel.Font = Enum.Font.PermanentMarker
KillAllLabel.TextSize = 35

_G.whitelistedPlayers = _G.whitelistedPlayers or {}

_G.blacklistedPlayers = _G.blacklistedPlayers or {}

local function isWhitelisted(player)
	for _, name in ipairs(_G.whitelistedPlayers) do
		if name:lower() == player.Name:lower() then return true end
	end
	return false
end

local function isBlacklisted(player)
	for _, name in ipairs(_G.blacklistedPlayers) do
		if name:lower() == player.Name:lower() then return true end
	end
	return false
end

local AddToWhitelistDropdown = Tabs.Killing:AddDropdown("Add to Whitelist", function(selectedText)
	local playerName = selectedText:match("| (.+)$")
	if playerName then
		playerName = playerName:gsub("^%s*(.-)%s*$", "%1")
		for _, name in ipairs(_G.whitelistedPlayers) do
			if name:lower() == playerName:lower() then return end
		end
		table.insert(_G.whitelistedPlayers, playerName)
	end
end)

Tabs.Killing:AddSwitch("Whitelist Friends", function(bool)
	_G.whitelistFriends = bool
	if bool then
		for _, player in pairs(Services.Players:GetPlayers()) do
			if player ~= Services.Players.LocalPlayer and player:IsFriendsWith(Services.Players.LocalPlayer.UserId) then
				if not isWhitelisted(player) then 
					table.insert(_G.whitelistedPlayers, player.Name) 
				end
			end
		end
		_G.friendWhitelistConnection = Services.Players.PlayerAdded:Connect(function(player)
			if _G.whitelistFriends and player:IsFriendsWith(Services.Players.LocalPlayer.UserId) then
				if not isWhitelisted(player) then
					table.insert(_G.whitelistedPlayers, player.Name)
				end
			end
		end)
		_G.friendCheckLoop = task.spawn(function()
			while _G.whitelistFriends do
				task.wait(3)
				for _, player in pairs(Services.Players:GetPlayers()) do
					if player ~= Services.Players.LocalPlayer and player:IsFriendsWith(Services.Players.LocalPlayer.UserId) then
						if not isWhitelisted(player) then
							table.insert(_G.whitelistedPlayers, player.Name)
							print("New Friend added to your Whitelist:", player.Name)
						end
					end
				end
			end
		end)
	else
		if _G.friendWhitelistConnection then
			_G.friendWhitelistConnection:Disconnect()
			_G.friendWhitelistConnection = nil
		end
		if _G.friendCheckLoop then
			task.cancel(_G.friendCheckLoop)
			_G.friendCheckLoop = nil
		end
	end
end)

Tabs.Killing:AddSwitch("Kill All", function(bool)
	_G.killAll = bool
	if bool then
		if not _G.killAllConnection then
			_G.killAllConnection = Services.RunService.Heartbeat:Connect(function()
				if _G.killAll then
					for _, player in ipairs(Services.Players:GetPlayers()) do
						if player ~= Services.Players.LocalPlayer and not isWhitelisted(player) then killPlayer(player) end
					end
				end
			end)
		end
	else
		if _G.killAllConnection then _G.killAllConnection:Disconnect() _G.killAllConnection = nil end
	end
end)

Tabs.Killing:AddLabel("————————————————————————————————")

TargetingLabel = Tabs.Killing:AddLabel("Targeting:")
TargetingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetingLabel.Font = Enum.Font.PermanentMarker
TargetingLabel.TextSize = 35

local AddToBlacklistDropdown = Tabs.Killing:AddDropdown("Add to Blacklist", function(selectedText)
	local playerName = selectedText:match("| (.+)$")
	if playerName then
		playerName = playerName:gsub("^%s*(.-)%s*$", "%1")
		if not isBlacklisted({Name = playerName}) then table.insert(_G.blacklistedPlayers, playerName) end
	end
end)

for _, player in ipairs(Services.Players:GetPlayers()) do
	if player ~= Services.Players.LocalPlayer then
		AddToWhitelistDropdown:Add(player.DisplayName .. " | " .. player.Name)
		AddToBlacklistDropdown:Add(player.DisplayName .. " | " .. player.Name)
	end
end

Services.Players.PlayerAdded:Connect(function(player)
	if player ~= Services.Players.LocalPlayer then
		AddToWhitelistDropdown:Add(player.DisplayName .. " | " .. player.Name)
		AddToBlacklistDropdown:Add(player.DisplayName .. " | " .. player.Name)
	end
end)

local autoBringEnabled = false
local autoBringConnection

local function getRootPart(character)
    return character and character:FindFirstChild("HumanoidRootPart")
end

local function isBlacklistedPlayer(player)
    return _G.blacklistedPlayers and table.find(_G.blacklistedPlayers, player.Name)
end

local function isAlive(player)
    return isPlayerAlive(player)
end

local function zeroVelocity(rootPart)
    rootPart.Velocity = Vector3.zero
    if typeof(rootPart.AssemblyLinearVelocity) == "Vector3" then
        rootPart.AssemblyLinearVelocity = Vector3.zero
        rootPart.AssemblyAngularVelocity = Vector3.zero
    end
end

Tabs.Killing:AddSwitch("Kill [Bring]", function(state)
    autoBringEnabled = state
    if state then
        if autoBringConnection then
            autoBringConnection:Disconnect()
            autoBringConnection = nil
        end
        autoBringConnection = RunService.Heartbeat:Connect(function()
            if not autoBringEnabled then return end
            local character = LocalPlayer.Character
            local rootPart = getRootPart(character)
            if not rootPart then return end
            local targetCFrame = rootPart.CFrame * CFrame.new(0, 0, -4)
            local players = Players:GetPlayers()
            for i = 1, #players do
                local player = players[i]
                if player ~= LocalPlayer then
                    if isBlacklistedPlayer(player) and isAlive(player) then
                        local targetRoot = getRootPart(player.Character)

                        if targetRoot then
                            pcall(function()
                                targetRoot.CFrame = targetCFrame
                                zeroVelocity(targetRoot)
                            end)

                            killPlayer(player)
                        end
                    end
                end
            end
        end)
    else
        if autoBringConnection then
            autoBringConnection:Disconnect()
            autoBringConnection = nil
        end
    end
end)

Tabs.Killing:AddSwitch("Kill [No Bring]", function(bool)
	_G.killBlacklistedOnly = bool
	if bool then
		if not _G.blacklistKillConnection then
			_G.blacklistKillConnection = Services.RunService.Heartbeat:Connect(function()
				if _G.killBlacklistedOnly then
					for _, player in ipairs(Services.Players:GetPlayers()) do
						if player ~= Services.Players.LocalPlayer and isBlacklisted(player) then killPlayer(player) end
					end
				end
			end)
		end
	else
		if _G.blacklistKillConnection then _G.blacklistKillConnection:Disconnect() _G.blacklistKillConnection = nil end
	end
end)

local isEnabled = false
local characterAddedConnection = nil
local savedCFrame = nil

_G.blacklistedPlayers = _G.blacklistedPlayers or {}

local function isBlacklisted(player)
	if not player then return false end
	for _, name in ipairs(_G.blacklistedPlayers) do
		if player.Name == name then
			return true
		end
	end
	return false
end

local function isAlive(player)
	if not player or not player.Character then return false end
	local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
	local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
	return humanoid and rootPart and humanoid.Health > 0
end

local function getTargets()
	local targets = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= Player and isBlacklisted(player) and isAlive(player) then
			table.insert(targets, player)
		end
	end
	return targets
end

local function performKill()
	for _, target in ipairs(getTargets()) do
		local character = Player.Character
		if not character then return end
		local myRoot = character:FindFirstChild("HumanoidRootPart")
		local targetRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
		if myRoot and targetRoot then
			savedCFrame = myRoot.CFrame
			myRoot.CFrame = targetRoot.CFrame
			killPlayer(target)
			task.wait(0.05)
			if savedCFrame then
				myRoot.CFrame = savedCFrame
			end
			savedCFrame = nil
		end
	end
end

local function startKillTeleport()
	if isEnabled then return end
	isEnabled = true
	characterAddedConnection = Player.CharacterAdded:Connect(function()
		if isEnabled then
			task.wait(0.15)
			performKill()
		end
	end)
	task.spawn(function()
		while isEnabled do
			performKill()
			task.wait(0.2)
		end
	end)
end

local function stopKillTeleport()
	isEnabled = false
	savedCFrame = nil
	if characterAddedConnection then
		characterAddedConnection:Disconnect()
		characterAddedConnection = nil
	end
end

Tabs.Killing:AddSwitch("Kill [Teleport]", function(enabled)
	if enabled then
		startKillTeleport()
	else
		stopKillTeleport()
	end
end):Set(false)

local SpectateData = {
	SelectedPlayer = nil,
	SelectedPlayerUserId = nil,
	Spectating = false,
	CurrentTargetConnection = nil,
	LocalPlayerRespawnConnection = nil,
	CameraMonitorLoop = nil
}

getgenv().SpectateState = getgenv().SpectateState or {
	SavedUserId = nil,
	IsSpectating = false
}

local function stopSpectating()
	if SpectateData.CurrentTargetConnection then
		SpectateData.CurrentTargetConnection:Disconnect()
		SpectateData.CurrentTargetConnection = nil
	end
	if SpectateData.CameraMonitorLoop then
		SpectateData.CameraMonitorLoop = false
	end
	local localPlayer = Services.Players.LocalPlayer
	if localPlayer.Character then
		local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			PlayerData.Camera.CameraSubject = humanoid
			PlayerData.Camera.CameraType = Enum.CameraType.Custom
		end
	end
	if PlayerData.Humanoid then
		PlayerData.Camera.CameraSubject = PlayerData.Humanoid
	end
end

local function startCameraMonitor()
	if SpectateData.CameraMonitorLoop then
		SpectateData.CameraMonitorLoop = false
		task.wait(0.1)
	end
	SpectateData.CameraMonitorLoop = true
	task.spawn(function()
		while SpectateData.CameraMonitorLoop do
			task.wait(0.1)
			if SpectateData.Spectating and SpectateData.SelectedPlayer then
				local targetChar = SpectateData.SelectedPlayer.Character
				if targetChar then
					local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
					if targetHumanoid then
						if PlayerData.Camera.CameraSubject ~= targetHumanoid then
							PlayerData.Camera.CameraSubject = targetHumanoid
						end
					end
				end
			else
				break
			end
		end
	end)
end

local function updateSpectateTarget(player)
	if not player then
		if SpectateData.SelectedPlayerUserId then
			for _, p in ipairs(Services.Players:GetPlayers()) do
				if p.UserId == SpectateData.SelectedPlayerUserId then
					player = p
					SpectateData.SelectedPlayer = player
					break
				end
			end
		end
		if not player and getgenv().SpectateState.SavedUserId then
			for _, p in ipairs(Services.Players:GetPlayers()) do
				if p.UserId == getgenv().SpectateState.SavedUserId then
					player = p
					SpectateData.SelectedPlayer = player
					SpectateData.SelectedPlayerUserId = p.UserId
					break
				end
			end
		end
		if not player then
			stopSpectating()
			return
		end
	end
	SpectateData.SelectedPlayerUserId = player.UserId
	SpectateData.SelectedPlayer = player
	if SpectateData.CurrentTargetConnection then
		SpectateData.CurrentTargetConnection:Disconnect()
		SpectateData.CurrentTargetConnection = nil
	end
	local function setCamera(char)
		if not SpectateData.Spectating or SpectateData.SelectedPlayerUserId ~= player.UserId then
			return
		end
		local humanoid = char:WaitForChild("Humanoid", 3)
		if humanoid and SpectateData.Spectating and SpectateData.SelectedPlayerUserId == player.UserId then
			PlayerData.Camera.CameraSubject = humanoid
		end
	end
	if player.Character then
		setCamera(player.Character)
	end
	SpectateData.CurrentTargetConnection = player.CharacterAdded:Connect(function(newChar)
		if SpectateData.Spectating and SpectateData.SelectedPlayerUserId == player.UserId then
			setCamera(newChar)
		end
	end)
end

local function updatePlayerList()
	return Services.Players:GetPlayers()
end

local ChoosePlayerDropdown = Tabs.Killing:AddDropdown("Choose Player", function(text)
	for _, player in ipairs(updatePlayerList()) do
		local optionText = player.DisplayName .. " | " .. player.Name
		if text == optionText then
			SpectateData.SelectedPlayer = player
			SpectateData.SelectedPlayerUserId = player.UserId
			getgenv().SpectateState.SavedUserId = player.UserId
			if SpectateData.Spectating then
				updateSpectateTarget(player)
			end
			break
		end
	end
end)

Tabs.Killing:AddSwitch("Spectate", function(bool)
	SpectateData.Spectating = bool
	getgenv().SpectateState.IsSpectating = bool
	if SpectateData.Spectating then
		if SpectateData.SelectedPlayerUserId then
			getgenv().SpectateState.SavedUserId = SpectateData.SelectedPlayerUserId
		end
		updateSpectateTarget()
		startCameraMonitor()
	else
		stopSpectating()
		task.wait(0.1)
		local localPlayer = Services.Players.LocalPlayer
		if localPlayer.Character then
			local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				PlayerData.Camera.CameraSubject = humanoid
			end
		end
		getgenv().SpectateState.IsSpectating = false
	end
end)

for _, player in ipairs(updatePlayerList()) do
	ChoosePlayerDropdown:Add(player.DisplayName .. " | " .. player.Name)
end

Services.Players.PlayerAdded:Connect(function(player)
	ChoosePlayerDropdown:Add(player.DisplayName .. " | " .. player.Name)
	if getgenv().SpectateState.IsSpectating and getgenv().SpectateState.SavedUserId == player.UserId then
		SpectateData.Spectating = true
		SpectateData.SelectedPlayer = player
		SpectateData.SelectedPlayerUserId = player.UserId
		updateSpectateTarget(player)
	end
end)

Services.Players.PlayerRemoving:Connect(function(player)
	if player.UserId == SpectateData.SelectedPlayerUserId then
		if SpectateData.Spectating then
			stopSpectating()
			SpectateData.SelectedPlayer = nil
			SpectateData.CurrentTargetConnection = nil
			local localPlayer = Services.Players.LocalPlayer
			if localPlayer.Character and PlayerData.Humanoid then
				PlayerData.Camera.CameraSubject = PlayerData.Humanoid
			end
		end
	end
end)

if SpectateData.LocalPlayerRespawnConnection then
	SpectateData.LocalPlayerRespawnConnection:Disconnect()
end

SpectateData.LocalPlayerRespawnConnection = Services.Players.LocalPlayer.CharacterAdded:Connect(function(char)
	local humanoid = char:WaitForChild("Humanoid", 3)
	if humanoid then
		PlayerData.Humanoid = humanoid
	end
	task.wait(0.1)
	if getgenv().SpectateState.IsSpectating then
		SpectateData.Spectating = true
		updateSpectateTarget()
		startCameraMonitor()
	else
		if PlayerData.Humanoid then
			PlayerData.Camera.CameraSubject = PlayerData.Humanoid
		end
	end
end)

Tabs.Killing:AddLabel("————————————————————————————————")

local WhitelistLabel = Tabs.Killing:AddLabel("Whitelist: None")

WhitelistLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
WhitelistLabel.Font = Enum.Font.PermanentMarker
WhitelistLabel.TextSize = 35

Tabs.Killing:AddButton("Clear Whitelist", function() _G.whitelistedPlayers = {} end)

local BlacklistLabel = Tabs.Killing:AddLabel("Blacklist: None")

BlacklistLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
BlacklistLabel.Font = Enum.Font.PermanentMarker
BlacklistLabel.TextSize = 35

Tabs.Killing:AddButton("Clear Blacklist", function() _G.blacklistedPlayers = {} end)

task.spawn(function()
	while true do
		WhitelistLabel.Text = #_G.whitelistedPlayers == 0 and "Whitelist: None" or "Whitelist: " .. table.concat(_G.whitelistedPlayers, ", ")
		BlacklistLabel.Text = #_G.blacklistedPlayers == 0 and "Blacklist: None" or "Blacklist: " .. table.concat(_G.blacklistedPlayers, ", ")
		task.wait(0.01)
	end
end)

local fileName = "Blacklist"..LocalPlayer.Name..".txt"
local blacklistWords = {}
local active = {}
local attackDelay = 0.01
local characterLoaded = false
local autoPunchActive = false

local function trim(s) 
	return s:match("^%s*(.-)%s*$") 
end

local function parseList(text)
	blacklistWords = {}
	if not text or text == "" then return end
	for w in string.gmatch(text, "[^,]+") do
		local t = trim(w):lower()
		if t ~= "" then table.insert(blacklistWords, t) end
	end
end

if isfile(fileName) then
	parseList(readfile(fileName))
else
	writefile(fileName, "")
end

local function saveList()
	writefile(fileName, table.concat(blacklistWords, ","))
end

local function nameMatchesAny(player)
	if not player then return false end
	local dn = (player.DisplayName or ""):lower()
	for _, w in ipairs(blacklistWords) do
		if w ~= "" and string.find(dn, w, 1, true) then
			return true
		end
	end
	return false
end

local function refreshActive()
	for k in pairs(active) do active[k] = nil end

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and nameMatchesAny(plr) then
			active[plr] = true
		end
	end
end

function isAnyActive()
	for _ in pairs(active) do
		return true
	end
	return false
end

local function getHands(char)
	repeat task.wait() until char and char:FindFirstChild("RightHand")
	local right = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
	local left = char:FindFirstChild("LeftHand") or char:FindFirstChild("Left Arm")
	return right, left
end

local function ensurePunchEquipped()
	if not isAnyActive() then return nil end
	local char = LocalPlayer.Character
	if not char then return nil end
	local punch = char:FindFirstChild("Punch") or LocalPlayer.Backpack:FindFirstChild("Punch")
	if punch and punch.Parent ~= char then
		punch.Parent = char
	end
	if not punch then
		task.defer(function()
			for i = 1, 40 do
				if not isAnyActive() then return end
				local p = LocalPlayer.Backpack:FindFirstChild("Punch")
				if p then
					p.Parent = LocalPlayer.Character
					break
				end
				task.wait(0.1)
			end
		end)
	end
	return char:FindFirstChild("Punch")
end

local function waitForCharacter()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	characterLoaded = true
	task.spawn(function()
		repeat task.wait() until LocalPlayer:FindFirstChild("Backpack")
		if isAnyActive() then
			for i = 1, 60 do
				local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
				if punch then
					punch.Parent = char
					break
				end
				task.wait(0.1)
			end
		end
	end)
	return char
end

ClanBlacklistLabel = Tabs.Killing:AddLabel("")

ClanBlacklistLabel.Text = (#blacklistWords == 0 and "Clan Blacklist: None" or "Clan Blacklist: "..table.concat(blacklistWords, ","))

ClanBlacklistLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
ClanBlacklistLabel.Font = Enum.Font.PermanentMarker
ClanBlacklistLabel.TextSize = 35

local AddToBlacklistBox = Tabs.Killing:AddTextBox("Add to Blacklist", function(txt)
	parseList((table.concat(blacklistWords, ",")..","..txt))
	saveList()
	ClanBlacklistLabel.Text = (#blacklistWords == 0 and "Clan Blacklist: None" or "Clan Blacklist: "..table.concat(blacklistWords, ","))
	refreshActive()
	if not isAnyActive() then autoPunchActive = false end
end, {["placeholder"] = "Ej: KTA, DTH, SC, TUE, ZE, BMX"})

AddToBlacklistBox.Font = Enum.Font.PermanentMarker

local RemoveFromClanBlacklistBox = Tabs.Killing:AddTextBox("Remove from Clan Blacklist", function(txt)
	local toRemove = {}
	for w in string.gmatch(txt, "[^,]+") do
		local t = trim(w):lower()
		if t ~= "" then table.insert(toRemove, t) end
	end
	for _, word in ipairs(toRemove) do
		for i = #blacklistWords, 1, -1 do
			if blacklistWords[i] == word then
				table.remove(blacklistWords, i)
			end
		end
	end
	saveList()
	ClanBlacklistLabel.Text = (#blacklistWords == 0 and "Clan Blacklist: None" or "Clan Blacklist: "..table.concat(blacklistWords, ","))
	refreshActive()
	if not isAnyActive() then autoPunchActive = false end
end)

RemoveFromClanBlacklistBox.Font = Enum.Font.PermanentMarker

RunService.Heartbeat:Connect(function()
	refreshActive()
end)

task.spawn(function()
	while true do
		task.wait(attackDelay)
		if not isAnyActive() then
			continue
		end
		if not LocalPlayer.Character then continue end
		if not characterLoaded then continue end
		local punch = ensurePunchEquipped()
		if not punch then continue end
		local char = LocalPlayer.Character
		local rightHand, leftHand = getHands(char)
		for plr in pairs(active) do
			if plr and plr.Character then
				local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
				local hum = plr.Character:FindFirstChild("Humanoid")
				if hrp and hum and hum.Health > 0 then
					pcall(function()
						LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
						LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
					end)
					pcall(function()
						firetouchinterest(rightHand, hrp, 1)
						firetouchinterest(leftHand, hrp, 1)
						firetouchinterest(rightHand, hrp, 0)
						firetouchinterest(leftHand, hrp, 0)
					end)
				end
			end
		end
	end
end)

Players.PlayerAdded:Connect(function(plr)
	plr:GetPropertyChangedSignal("DisplayName"):Connect(function()
		refreshActive()
	end)
end)

LocalPlayer.CharacterAdded:Connect(function()
	characterLoaded = false
	task.wait(0.1)

	waitForCharacter()
	refreshActive()

	if isAnyActive() then
		task.defer(function()
			for i = 1, 50 do
				if not isAnyActive() then break end
				ensurePunchEquipped()
				task.wait(0.1)
			end
		end)
	end
end)
waitForCharacter()
refreshActive()

MiscLabel = Tabs.GodMode:AddLabel("Misc:")

MiscLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MiscLabel.Font = Enum.Font.PermanentMarker
MiscLabel.TextSize = 35

local PROTEIN_EGG = "Protein Egg"

local rEvents = ReplicatedStorage:WaitForChild("rEvents")
local changeSpeedSizeRemote = rEvents:WaitForChild("changeSpeedSizeRemote")

local size2CounterBlacklist = {}

local cState = {
    active = false,
    isNaN = false,
    deaths = {},
    killsGained = 0,
    lastKills = 0,
    needed = 1,
    lastChar = nil,
    lastHealth = 100,
    heartbeatConn = nil,
}

local function getLeaderstatsKills()
    local success, value = pcall(function()
        local leaderstats = Player:FindFirstChild("leaderstats")
        if not leaderstats then
            return 0
        end
        local kills = leaderstats:FindFirstChild("Kills")
        if kills and kills:IsA("ValueBase") then
            return kills.Value
        end
        return 0
    end)
    return success and value or 0
end

local function setPlayerSize(size)
    pcall(function()
        changeSpeedSizeRemote:InvokeServer("changeSize", size)
    end)
end

local function equipCounterEgg()
    if not cState.isNaN then
        return
    end
    local character = Player.Character
    if not character then
        return
    end
    local count = 0
    for _, item in ipairs(character:GetChildren()) do
        if item.Name == PROTEIN_EGG then
            count += 1

            if count > 1 then
                item.Parent = Player.Backpack
            end
        end
    end
    if count == 0 then
        local egg = Player.Backpack:FindFirstChild(PROTEIN_EGG)

        if egg then
            egg.Parent = character
        end
    end
end

local function unequipCounterEgg()
    local character = Player.Character
    if not character then
        return
    end
    for _, item in ipairs(character:GetChildren()) do
        if item.Name == PROTEIN_EGG then
            item.Parent = Player.Backpack
        end
    end
end

local function resetCounterToSize2()
    cState.isNaN = false
    cState.killsGained = 0
    table.clear(cState.deaths)

    cState.lastKills = getLeaderstatsKills()
    setPlayerSize(2)
    unequipCounterEgg()
end

local function registerCounterDeath()
    if not cState.active or cState.isNaN then
        return
    end
    local now = tick()
    table.insert(cState.deaths, now)
    while #cState.deaths > 0 and now - cState.deaths[1] > 5 do
        table.remove(cState.deaths, 1)
    end
    if #cState.deaths >= 2 then
        cState.isNaN = true
        cState.killsGained = 0
        cState.lastKills = getLeaderstatsKills()
        setPlayerSize(0 / 0)
    end
end

local function counterHeartbeat()
    if not cState.active then
        return
    end
    local currentChar = Player.Character
    if currentChar ~= cState.lastChar then
        if cState.lastChar and currentChar then
            registerCounterDeath()
        end

        cState.lastChar = currentChar
        cState.lastHealth = 100
    end
    if currentChar then
        local humanoid = currentChar:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if humanoid.Health <= 0 and cState.lastHealth > 0 then
                registerCounterDeath()
            end
            cState.lastHealth = humanoid.Health
        end
    end
    if cState.isNaN then
        local kills = getLeaderstatsKills()
        if kills > cState.lastKills then
            cState.lastKills = kills
            cState.killsGained += 1

            if cState.killsGained >= cState.needed then
                resetCounterToSize2()
            end
        end
        equipCounterEgg()
    end
end

local NaNSize2Dropdown = Tabs.GodMode:AddLabel("Blacklist: None")

NaNSize2Dropdown.TextColor3 = Color3.fromRGB(255, 0, 0)
NaNSize2Dropdown.Font = Enum.Font.PermanentMarker
NaNSize2Dropdown.TextSize = 35

local function updateBlacklistLabel()
    if #size2CounterBlacklist == 0 then
        NaNSize2Dropdown.Text = "Blacklist: None"
    else
        NaNSize2Dropdown.Text =
            "Blacklist: " .. table.concat(size2CounterBlacklist, ", ")
    end
end

local NaNSize2Dropdown = Tabs.GodMode:AddDropdown("Add to Blacklist", function(selectedText)
    local playerName = selectedText:match("| (.+)$")
    if not playerName then
        return
	end
    playerName = playerName:gsub("^%s*(.-)%s*$", "%1")
    for _, name in ipairs(size2CounterBlacklist) do
        if name:lower() == playerName:lower() then
            return
        end
    end
    table.insert(size2CounterBlacklist, playerName)
    updateBlacklistLabel()
end)

Tabs.GodMode:AddSwitch("NaN + size 2", function(enabled)
    if enabled then
        cState.active = true
        cState.isNaN = false
        table.clear(cState.deaths)
        cState.killsGained = 0
        cState.lastKills = getLeaderstatsKills()
        cState.lastChar = Player.Character
        cState.lastHealth = 100
        cState.needed = math.max(1, #size2CounterBlacklist * 2)
        setPlayerSize(2)
        unequipCounterEgg()
        if cState.heartbeatConn then
            cState.heartbeatConn:Disconnect()
        end
        cState.heartbeatConn =
            RunService.Heartbeat:Connect(counterHeartbeat)
    else
        cState.active = false
        if cState.heartbeatConn then
            cState.heartbeatConn:Disconnect()
            cState.heartbeatConn = nil
        end
        setPlayerSize(2)
        unequipCounterEgg()
    end
end)

for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= Player then
        NaNSize2Dropdown:Add(plr.DisplayName .. " | " .. plr.Name)
    end
end

Players.PlayerAdded:Connect(function(plr)
    if plr ~= Player then
        NaNSize2Dropdown:Add(plr.DisplayName .. " | " .. plr.Name)
    end
end)

Tabs.GodMode:AddButton("Clear Blacklist", function()
    table.clear(size2CounterBlacklist)
    updateBlacklistLabel()
end)

updateBlacklistLabel()

local equipEvent = ReplicatedStorage.rEvents.equipPetEvent

local equipEvent = ReplicatedStorage.rEvents.equipPetEvent

local cache = {
	WildWizard = {},
	MightyMonster = {}
}

local function cachePets()
	cache.WildWizard = {}
	cache.MightyMonster = {}
	local unique = player:FindFirstChild("petsFolder") and player.petsFolder:FindFirstChild("Unique")
	if not unique then
		return
	end
	for _, p in pairs(unique:GetChildren()) do
		if p.Name == "Wild Wizard" then
			table.insert(cache.WildWizard, p)
		elseif p.Name == "Mighty Monster" then
			table.insert(cache.MightyMonster, p)
		end
	end
end

local function equipOnRespawn(petList)
	cachePets()
	for i = 1, math.min(8, # petList) do
		pcall(function()
			equipEvent:FireServer("equipPet", petList[i])
		end)
	end
end

local wwRespawnEnabled = false

local mmRespawnEnabled = false

local character = player.Character or player.CharacterAdded:Wait()

player.CharacterAdded:Connect(function()
	task.wait(0.35)
	cachePets()
	if wwRespawnEnabled then
		equipOnRespawn(cache.WildWizard)
	end
	if mmRespawnEnabled then
		equipOnRespawn(cache.MightyMonster)
	end
end)

Tabs.GodMode:AddSwitch("Spawn with Pack HP", function(enabled)
	mmRespawnEnabled = enabled
end):Set(false)

Tabs.GodMode:AddSwitch("Spawn with Pack DMG", function(enabled)
	wwRespawnEnabled = enabled
end):Set(false)

local equipEvent = ReplicatedStorage.rEvents.equipPetEvent

local min = math.min
local pcall = pcall

local cache = {
	WildWizard = {},
	MightyMonster = {}
}

local active = false
local loopRunning = false
local spamDelay = 0.35

local function cachePets()
	local wild = cache.WildWizard
	local mighty = cache.MightyMonster
	table.clear(wild)
	table.clear(mighty)
	local petsFolder = player:FindFirstChild("petsFolder")
	if not petsFolder then return end
	local unique = petsFolder:FindFirstChild("Unique")
	if not unique then return end
	local children = unique:GetChildren()
	for i = 1, #children do
		local p = children[i]
		local name = p.Name
		if name == "Wild Wizard" then
			wild[#wild + 1] = p
		elseif name == "Mighty Monster" then
			mighty[#mighty + 1] = p
		end
	end
end

local function fire(action, pet)
	pcall(equipEvent.FireServer, equipEvent, action, pet)
end

local function swap(unequipList, equipList)
	for i = 1, #unequipList do
		fire("unequipPet", unequipList[i])
	end
	local limit = min(8, #equipList)
	for i = 1, limit do
		fire("equipPet", equipList[i])
	end
end

local function unequipAll()
	for i = 1, #cache.WildWizard do
		fire("unequipPet", cache.WildWizard[i])
	end
	for i = 1, #cache.MightyMonster do
		fire("unequipPet", cache.MightyMonster[i])
	end
end

local function runLoop()
	if loopRunning then return end
	loopRunning = true
	task.spawn(function()
		while active do
			swap(cache.MightyMonster, cache.WildWizard)
			task.wait(spamDelay)
			if not active then break end
			swap(cache.WildWizard, cache.MightyMonster)
			task.wait(spamDelay)
		end
		loopRunning = false
	end)
end

Tabs.GodMode:AddSwitch("Pack Spam", function(enabled)
	if active == enabled then return end
	active = enabled
	if enabled then
		cachePets()
		runLoop()
	else
		unequipAll()
	end
end)

local PackSpamDropdown = Tabs.GodMode:AddDropdown("Pack spam Speed", function(text)
	if text == "Slow" then
		spamDelay = 0.7
	elseif text == "Normal" then
		spamDelay = 0.35
	elseif text == "Fast" then
		spamDelay = 0.175
	elseif text == "Very Fast" then
		spamDelay = 0.0875
	end
end)

PackSpamDropdown:Add("Slow")
PackSpamDropdown:Add("Normal")
PackSpamDropdown:Add("Fast")
PackSpamDropdown:Add("Very Fast")

local rEvents = ReplicatedStorage:WaitForChild("rEvents", 5)
local equipPetEvent = rEvents and rEvents:WaitForChild("equipPetEvent", 5)

local petsFolder = player:WaitForChild("petsFolder", 10)
local uniqueFolder = petsFolder and petsFolder:WaitForChild("Unique", 10)
local mightyMonsters = {}

local function rebuildMightyList()
    table.clear(mightyMonsters)
    if not uniqueFolder then return end
    for _, pet in ipairs(uniqueFolder:GetChildren()) do
        if pet.Name == "Mighty Monster" then
            mightyMonsters[#mightyMonsters + 1] = pet
        end
    end
end

if uniqueFolder then
    rebuildMightyList()
    uniqueFolder.ChildAdded:Connect(function(child)
        if child.Name == "Mighty Monster" then
            mightyMonsters[#mightyMonsters + 1] = child
        end
    end)
    uniqueFolder.ChildRemoved:Connect(function(child)
        for i = #mightyMonsters, 1, -1 do
            if mightyMonsters[i] == child then
                mightyMonsters[i] = mightyMonsters[#mightyMonsters]
                mightyMonsters[#mightyMonsters] = nil
                break
            end
        end
    end)
end

local function equipCycle()
    if not petsFolder or not equipPetEvent then return end
    local folders = petsFolder:GetChildren()
    for i = 1, #folders do
        local folder = folders[i]
        if folder:IsA("Folder") then
            local pets = folder:GetChildren()
            for j = 1, #pets do
                equipPetEvent:FireServer("unequipPet", pets[j])
            end
        end
    end
    local limit = (#mightyMonsters < 8) and #mightyMonsters or 8
    for i = 1, limit do
        local pet = mightyMonsters[i]
        if pet and pet.Parent then
            equipPetEvent:FireServer("equipPet", pet)
        end
    end
end

local lastRespawnTime = os.clock()
local currentHum = nil

player.CharacterAdded:Connect(function(char)
    lastRespawnTime = os.clock()
    currentHum = char:WaitForChild("Humanoid", 5)
end)

if player.Character then 
    currentHum = player.Character:FindFirstChild("Humanoid") 
end

local isSpamming = false

Tabs.GodMode:AddSwitch("Monster Spam", function(b)
    isSpamming = b
    if b then
        task.spawn(function()
            while isSpamming do
                local isDead = not currentHum or currentHum.Health <= 0
                local recentlySpawned = (os.clock() - lastRespawnTime) <= 3
                if isDead or recentlySpawned then
                    equipCycle()
                end
                task.wait(0.1)
            end
        end)
    end
end):Set(false)

Tabs.GodMode:AddButton("Equip monsters Once", function()
    equipCycle()
end)

Tabs.GodMode:AddLabel("————————————————————————————————")

local GodModeKillLabel = Tabs.GodMode:AddLabel("GodMode Kill:")

GodModeKillLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
GodModeKillLabel.Font = Enum.Font.PermanentMarker
GodModeKillLabel.TextSize = 35

local selectedGodModeTarget = nil

local godModeTargetDropdown = Tabs.GodMode:AddDropdown("Select Target", function(text)
	for _, plr in ipairs(Players:GetPlayers()) do
		local optionText = plr.DisplayName .. " | " .. plr.Name
		if text == optionText then
			selectedGodModeTarget = plr
			break
		end
	end
end)

for _, plr in ipairs(Players:GetPlayers()) do
	if plr ~= Player then
		godModeTargetDropdown:Add(plr.DisplayName .. " | " .. plr.Name)
	end
end

Players.PlayerAdded:Connect(function(plr)
	if plr ~= Player then
		godModeTargetDropdown:Add(plr.DisplayName .. " | " .. plr.Name)
	end
end)

Players.PlayerRemoving:Connect(function(plr)
	if selectedGodModeTarget == plr then
		selectedGodModeTarget = nil
	end
	godModeTargetDropdown:Clear()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= Player then
			godModeTargetDropdown:Add(p.DisplayName .. " | " .. p.Name)
		end
	end
end)

local godModeActive = false

local godModeThreads = {}

local function stopGodMode()
	godModeActive = false
	for _, thread in ipairs(godModeThreads) do
		if thread then
			task.cancel(thread)
		end
	end
	godModeThreads = {}
end

local function startGodMode()
	godModeActive = true
	local slamThread = task.spawn(function()
		while godModeActive do
			local char = Player.Character
			if char then
				pcall(function()
					local groundSlam = Player.Backpack:FindFirstChild("Ground Slam")
					if groundSlam and not char:FindFirstChild("Ground Slam") then
						groundSlam.Parent = char
					end
				end)
				local equippedSlam = char:FindFirstChild("Ground Slam")
				if equippedSlam then
					local attackTime = equippedSlam:FindFirstChild("attackTime")
					if attackTime then
						attackTime.Value = 0
					end
					muscleEvent:FireServer("slam")
					equippedSlam:Activate()
				end
				local rEvents = ReplicatedStorage:WaitForChild("rEvents")
				local brawlEvent = rEvents:WaitForChild("brawlEvent")
				if brawlEvent then
					local args = {
						"joinBrawl"
					}
					brawlEvent:FireServer(unpack(args))
				end
			end
			task.wait(0.05)
		end
	end)
	table.insert(godModeThreads, slamThread)
	local tpThread = task.spawn(function()
		while godModeActive do
			if selectedGodModeTarget and selectedGodModeTarget.Character then
				local targetHrp = selectedGodModeTarget.Character:FindFirstChild("HumanoidRootPart")
				local myChar = Player.Character
				if targetHrp and myChar then
					local myHrp = myChar:FindFirstChild("HumanoidRootPart")
					if myHrp then
						myHrp.CFrame = targetHrp.CFrame
						myHrp.Velocity = Vector3.zero
						myHrp.RotVelocity = Vector3.zero
					end
				end
			end
			task.wait(0.03)
		end
	end)
	table.insert(godModeThreads, tpThread)
end

local GodModeSwitch = Tabs.GodMode:AddSwitch("GodMode Kill", function(bool)
	if bool then
		startGodMode()
	else
		stopGodMode()
	end
end)

Tabs.GodMode:AddButton("Size 1", function()
    game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
end)

Tabs.GodMode:AddButton("Size 2", function()
    game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 2)
end)

Tabs.GodMode:AddButton("Size 15", function()
    game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 15)
end)

local PlayerStatsLabel = Tabs.Specs:AddLabel("Stats:")

PlayerStatsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerStatsLabel.Font = Enum.Font.PermanentMarker
PlayerStatsLabel.TextSize = 35

local StatsLabel = Enum.Font.PermanentMarker

local SpecsData = {
	PlayerToInspect = nil,
	EmojiMap = {
		["Strength"] = utf8.char(0x1F4AA),
		["Durability"] = utf8.char(0x1F6E1),
	},
	StatDefinitions = {
		{name = "Strength", statName = "Strength"},
		{name = "Durability", statName = "Durability"},
	},
	StatLabels = {}
}

local specdropdown = Tabs.Specs:AddDropdown("Choose Player", function(text)
	for _, player in ipairs(Services.Players:GetPlayers()) do
		if text == player.DisplayName .. " | " .. player.Name then
			SpecsData.PlayerToInspect = player
			break
		end
	end
end)

for _, player in ipairs(Services.Players:GetPlayers()) do
	specdropdown:Add(player.DisplayName .. " | " .. player.Name)
end

Services.Players.PlayerAdded:Connect(function(player)
	specdropdown:Add(player.DisplayName .. " | " .. player.Name)
end)

Services.Players.PlayerRemoving:Connect(function()
	specdropdown:Clear()
	for _, p in ipairs(Services.Players:GetPlayers()) do
		specdropdown:Add(p.DisplayName .. " | " .. p.Name)
	end
end)

for _, info in ipairs(SpecsData.StatDefinitions) do
	local label = Tabs.Specs:AddLabel(
		SpecsData.EmojiMap[info.name] .. " " .. info.name .. ": N/A"
	)
	label.Font = StatsLabel
	SpecsData.StatLabels[info.name] = label
end

local function updateStatLabels(targetPlayer)
	if not targetPlayer then return end
	if not targetPlayer:FindFirstChild("leaderstats") then return end
	for _, info in ipairs(SpecsData.StatDefinitions) do
		local statObject =
			targetPlayer.leaderstats:FindFirstChild(info.statName)
			or targetPlayer:FindFirstChild(info.statName)
		if statObject then
			SpecsData.StatLabels[info.name].Text =
				string.format(
					"%s %s: %s (%s)",
					SpecsData.EmojiMap[info.name] or "",
					info.name,
					Utils.formatNumber(statObject.Value),
					Utils.formatWithCommas(statObject.Value)
				)
		else
			SpecsData.StatLabels[info.name].Text =
				SpecsData.EmojiMap[info.name] .. " " .. info.name .. ": 0 (0)"
		end
	end
end

task.spawn(function()
	while true do
		if SpecsData.PlayerToInspect then
			updateStatLabels(SpecsData.PlayerToInspect)
		end
		task.wait(0.1)
	end
end)

Tabs.Specs:AddLabel("———————————————————————————————————")

local OtherStatsLabel = Tabs.Specs:AddLabel("Advanced Stats:")
OtherStatsLabel.Font = StatsLabel
OtherStatsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
OtherStatsLabel.TextSize = 35

local function createStatLabel(text)
	local label = Tabs.Specs:AddLabel(text)
	label.Font = StatsLabel
	return label
end

local AdvancedStats = {
	HealthLabel = createStatLabel("🛡️ Enemy Health: N/A"),
	EnemyDamageLabel = createStatLabel("💥 Enemy Damage: N/A"),
	PlayerHealthLabel = createStatLabel("🛡️ Your Health: N/A"),
	PlayerDamageLabel = createStatLabel("💥 Your Damage: N/A"),
	HitsToKillLabel = createStatLabel("👊 Hits to Kill: N/A")
}

local StatsCache = {
	health = 0,
	enemyDamage = 0,
	playerHealth = 0,
	playerDamage = 0,
	hitsToKill = "N/A"
}

local function calculatePlayerHealth(targetPlayer)
	if not targetPlayer then return 0 end
	local durabilityStat =
		targetPlayer:FindFirstChild("Durability")
		or (targetPlayer:FindFirstChild("leaderstats") and targetPlayer.leaderstats:FindFirstChild("Durability"))

	if not durabilityStat then return 0 end
	local totalMultiplier = 1
	if targetPlayer:FindFirstChild("ultimatesFolder")
		and targetPlayer.ultimatesFolder:FindFirstChild("Infernal Health") then
		totalMultiplier += 0.15 * (targetPlayer.ultimatesFolder["Infernal Health"].Value or 0)
	end
	if targetPlayer:FindFirstChild("equippedPets") then
		for _, petValue in ipairs(targetPlayer.equippedPets:GetChildren()) do
			if petValue:IsA("ObjectValue") and petValue.Value then
				local name = string.lower(petValue.Value.Name)
				if name:match("mighty") and name:match("monster") then
					totalMultiplier += 0.5
				end
				if name:match("small") and name:match("fry") then
					totalMultiplier += 0.25
				end
			end
		end
	end
	return durabilityStat.Value * totalMultiplier
end

local function calculatePlayerDamage(targetPlayer)
	if not targetPlayer then return 0 end
	if not targetPlayer:FindFirstChild("leaderstats") then return 0 end
	if not targetPlayer.leaderstats:FindFirstChild("Strength") then return 0 end
	local baseDamage = targetPlayer.leaderstats.Strength.Value * 0.0666666666667
	local totalMultiplier = 1
	if targetPlayer:FindFirstChild("ultimatesFolder")
		and targetPlayer.ultimatesFolder:FindFirstChild("Demon Damage") then
		totalMultiplier += 0.1 * (targetPlayer.ultimatesFolder["Demon Damage"].Value or 0)
	end
	if targetPlayer:FindFirstChild("equippedPets") then
		for _, petValue in ipairs(targetPlayer.equippedPets:GetChildren()) do
			if petValue:IsA("ObjectValue") and petValue.Value then
				local name = string.lower(petValue.Value.Name)
				if name:match("wild") and name:match("wizard") then
					totalMultiplier += 0.5
				end
				if name:match("chaos") and name:match("sorcerer") then
					totalMultiplier += 0.25
				end
			end
		end
	end
	return baseDamage * totalMultiplier
end

local function updateAdvancedStats(targetPlayer)
	if not targetPlayer then return end
	StatsCache.health = calculatePlayerHealth(targetPlayer)
	StatsCache.enemyDamage = calculatePlayerDamage(targetPlayer)
	StatsCache.playerHealth = calculatePlayerHealth(PlayerData.Player)
	StatsCache.playerDamage = calculatePlayerDamage(PlayerData.Player)
	StatsCache.hitsToKill =
		StatsCache.playerDamage <= 0 and "∞"
		or (math.ceil(StatsCache.health / StatsCache.playerDamage) > 200 and "∞"
		or (math.ceil(StatsCache.health / StatsCache.playerDamage) < 1 and "instant"
		or math.ceil(StatsCache.health / StatsCache.playerDamage)))
	AdvancedStats.HealthLabel.Text =
		string.format("🛡️ Enemy Health: %s (%s)",
			Utils.formatNumber(StatsCache.health),
			Utils.formatWithCommas(StatsCache.health)
		)
	AdvancedStats.EnemyDamageLabel.Text =
		string.format("💥 Enemy Damage: %s (%s)",
			Utils.formatNumber(StatsCache.enemyDamage),
			Utils.formatWithCommas(StatsCache.enemyDamage)
		)
	AdvancedStats.PlayerHealthLabel.Text =
		string.format("🛡️ Your Health: %s (%s)",
			Utils.formatNumber(StatsCache.playerHealth),
			Utils.formatWithCommas(StatsCache.playerHealth)
		)
	AdvancedStats.PlayerDamageLabel.Text =
		string.format("💥 Your Damage: %s (%s)",
			Utils.formatNumber(StatsCache.playerDamage),
			Utils.formatWithCommas(StatsCache.playerDamage)
		)
	AdvancedStats.HitsToKillLabel.Text =
		string.format("👊 Hits to Kill: %s", tostring(StatsCache.hitsToKill))
end

task.spawn(function()
	while true do
		updateAdvancedStats(SpecsData.PlayerToInspect)
		task.wait(0.1)
	end
end)

local InventoryLabel = Tabs.Inventory:AddLabel("Inventory:")

InventoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InventoryLabel.Font = Enum.Font.PermanentMarker
InventoryLabel.TextSize = 35

local EggEaterData = {Running = false}

task.spawn(function()
	while true do
		if EggEaterData.Running then
			local tool = PlayerData.Player.Character:FindFirstChild("Protein Egg") or PlayerData.Player.Backpack:FindFirstChild("Protein Egg")
			if tool then PlayerData.Player.muscleEvent:FireServer("proteinEgg", tool) end
			task.wait(0.1)
		else
			task.wait(1)
		end
	end
end)

Tabs.Inventory:AddSwitch("Eat all Eggs", function(state) EggEaterData.Running = state end):Set(false)

local BoostData = {
	ItemList = {"Tropical Shake", "Energy Shake", "Protein Bar", "TOUGH Bar", "Protein Shake", "ULTRA Shake", "Energy Bar"},
	Running = false
}

task.spawn(function()
	while true do
		if BoostData.Running then
			for _, itemName in ipairs(BoostData.ItemList) do
				local tool = PlayerData.Player.Character:FindFirstChild(itemName) or PlayerData.Player.Backpack:FindFirstChild(itemName)
				if tool then
					local parts = {}
					for word in itemName:gmatch("%S+") do table.insert(parts, word:lower()) end
					for i = 2, #parts do parts[i] = parts[i]:sub(1, 1):upper() .. parts[i]:sub(2) end
					for i = 1, 10 do PlayerData.Player.muscleEvent:FireServer(table.concat(parts), tool) end
				end
			end
		end
		task.wait(0.1)
	end
end)

Tabs.Inventory:AddSwitch("Eat everything Except Eggs", function(state) BoostData.Running = state end)

Tabs.Inventory:AddLabel("————————————————————————————————")

local EggGiftingLabel = Tabs.Inventory:AddLabel("Egg Gifting:")

EggGiftingLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
EggGiftingLabel.Font = Enum.Font.PermanentMarker
EggGiftingLabel.TextSize = 35

local EggGifterData = {ProteinEggLabel = Tabs.Inventory:AddLabel("Eggs: 0"), SelectedPlayer = nil, EggCount = 0}

EggGifterData.ProteinEggLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
EggGifterData.ProteinEggLabel.Font = Enum.Font.PermanentMarker
EggGifterData.ProteinEggLabel.TextSize = 35

local playerDropdown = Tabs.Inventory:AddDropdown("Choose Player", function(name)
    local username = name:match(" | (.+)") or name
    EggGifterData.SelectedPlayer = Services.Players:FindFirstChild(username)
end)

for _, player in ipairs(Services.Players:GetPlayers()) do
    if player ~= Services.Players.LocalPlayer then
        playerDropdown:Add(player.DisplayName .. " | " .. player.Name)
    end
end

Services.Players.PlayerAdded:Connect(function(player)
    if player ~= Services.Players.LocalPlayer then
        playerDropdown:Add(player.DisplayName .. " | " .. player.Name)
    end
end)

Services.Players.PlayerRemoving:Connect(function(player)
    playerDropdown:Remove(player.DisplayName .. " | " .. player.Name)
    if EggGifterData.SelectedPlayer == player then EggGifterData.SelectedPlayer = nil end
end)

local AmountLabel = Tabs.Inventory:AddTextBox("Amount:", function(Text) EggGifterData.EggCount = tonumber(Text) end)

AmountLabel.Font = Enum.Font.PermanentMarker

Tabs.Inventory:AddButton("Start Gifting", function()
    if EggGifterData.SelectedPlayer and EggGifterData.EggCount and EggGifterData.EggCount > 0 then
        local egg = Services.Players.LocalPlayer.consumablesFolder:FindFirstChild("Protein Egg")
        if egg then
            for i = 1, EggGifterData.EggCount do
                pcall(function()
                    Services.ReplicatedStorage.rEvents.giftRemote:InvokeServer("giftRequest", EggGifterData.SelectedPlayer, egg)
                end)
                task.wait(0.1)
            end
        end
    end
end)

Tabs.Inventory:AddLabel("————————————————————————————————")

local ShakeGiftingLabel = Tabs.Inventory:AddLabel("Shake Gifting:")

ShakeGiftingLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
ShakeGiftingLabel.Font = Enum.Font.PermanentMarker
ShakeGiftingLabel.TextSize = 35

local ShakeGifterData = {TropicalShakeLabel = Tabs.Inventory:AddLabel("Tropical Shakes: 0"), SelectedPlayer = nil, ShakeCount = 0}

ShakeGifterData.TropicalShakeLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
ShakeGifterData.TropicalShakeLabel.Font = Enum.Font.PermanentMarker
ShakeGifterData.TropicalShakeLabel.TextSize = 35

local playerDropdown3 = Tabs.Inventory:AddDropdown("Choose Player", function(name)
	local usernameone = name:match(" | (.+)") or name
	ShakeGifterData.SelectedPlayer = Services.Players:FindFirstChild(usernameone)
end)

for _, player in ipairs(Services.Players:GetPlayers()) do
	if player ~= Services.Players.LocalPlayer then
		playerDropdown3:Add(player.DisplayName .. " | " .. player.Name)
	end
end

Services.Players.PlayerAdded:Connect(function(player)
	if player ~= Services.Players.LocalPlayer then
		playerDropdown3:Add(player.DisplayName .. " | " .. player.Name)
	end
end)

Services.Players.PlayerRemoving:Connect(function(player)
	playerDropdown3:Remove(player.DisplayName .. " | " .. player.Name)
	if ShakeGifterData.SelectedPlayer == player then ShakeGifterData.SelectedPlayer = nil end
end)

local AmountLabel1 = Tabs.Inventory:AddTextBox("Amount:", function(Text) ShakeGifterData.ShakeCount = tonumber(Text) end)

AmountLabel1.Font = Enum.Font.PermanentMarker

Tabs.Inventory:AddButton("Start Gifting", function()
	if ShakeGifterData.SelectedPlayer and ShakeGifterData.ShakeCount and ShakeGifterData.ShakeCount > 0 then
		for i = 1, ShakeGifterData.ShakeCount do
			Services.ReplicatedStorage.rEvents.giftRemote:InvokeServer("giftRequest", ShakeGifterData.SelectedPlayer, 
				Services.Players.LocalPlayer.consumablesFolder:FindFirstChild("Tropical Shake"))
		end
	end
end)

task.spawn(function()
	while true do
		local proteinEggCount = 0
		local tropicalShakeCount = 0
		if PlayerData.Backpack then
			for _, item in ipairs(PlayerData.Backpack:GetChildren()) do
				if item.Name == "Protein Egg" then proteinEggCount = proteinEggCount + 1
				elseif item.Name == "Tropical Shake" then tropicalShakeCount = tropicalShakeCount + 1 end
			end
		end
		EggGifterData.ProteinEggLabel.Text = "Protein Eggs: " .. proteinEggCount
		ShakeGifterData.TropicalShakeLabel.Text = "Tropical Shakes: " .. tropicalShakeCount
		task.wait(7.5)
	end
end)

local MainLabel = Tabs.Teleport:AddLabel("Main:")

MainLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MainLabel.Font = Enum.Font.PermanentMarker
MainLabel.TextSize = 35

local teleportLocations = {
	{name = "Tiny Island", pos = CFrame.new(-37.1, 9.2, 1919)},
	{name = "Main Island", pos = CFrame.new(16.07, 9.08, 133.8)},
	{name = "Beach", pos = CFrame.new(-8, 9, -169.2)}
}

for _, loc in ipairs(teleportLocations) do
	Tabs.Teleport:AddButton(loc.name, function()
		if PlayerData.Player.Character and PlayerData.Player.Character:FindFirstChild("HumanoidRootPart") then
			PlayerData.Player.Character.HumanoidRootPart.CFrame = loc.pos
		end
	end)
end

local GymsLabel = Tabs.Teleport:AddLabel("Gyms:")

GymsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
GymsLabel.Font = Enum.Font.PermanentMarker
GymsLabel.TextSize = 35

local gymLocations = {
	{name = "Muscle king Gym", pos = CFrame.new(-8665.4, 17.21, -5792.9)},
	{name = "Jungle Gym", pos = CFrame.new(-8543, 6.8, 2400)},
	{name = "Legends Gym", pos = CFrame.new(4516, 991.5, -3856)},
	{name = "Infernal Gym", pos = CFrame.new(-6759, 7.36, -1284)},
	{name = "Mythical Gym", pos = CFrame.new(2250, 7.37, 1073.2)},
	{name = "Frost Gym", pos = CFrame.new(-2623, 7.36, -409)}
}

for _, gym in ipairs(gymLocations) do
	Tabs.Teleport:AddButton(gym.name, function()
		if PlayerData.Player.Character and PlayerData.Player.Character:FindFirstChild("HumanoidRootPart") then
			PlayerData.Player.Character.HumanoidRootPart.CFrame = gym.pos
		end
	end)
end

local OtherLabel = Tabs.Teleport:AddLabel("Other:")
OtherLabel.Font = Enum.Font.PermanentMarker
OtherLabel.TextSize = 35

local GymLocations = {
	{name = "Tiny Island", pos = CFrame.new(-37.1, 9.2, 1919)},
	{name = "Main Island", pos = CFrame.new(16.07, 9.08, 133.8)},
	{name = "Beach", pos = CFrame.new(-8, 9, -169.2)},
	{name = "Muscle king Gym", pos = CFrame.new(-8665.4, 17.21, -5792.9)},
	{name = "Jungle Gym", pos = CFrame.new(-8543, 6.8, 2400)},
	{name = "Legends Gym", pos = CFrame.new(4516, 991.5, -3856)},
	{name = "Infernal Gym", pos = CFrame.new(-6759, 7.36, -1284)},
	{name = "Mythical Gym", pos = CFrame.new(2250, 7.37, 1073.2)},
	{name = "Frost Gym", pos = CFrame.new(-2623, 7.36, -409)}
}

local isGymTeleportEnabled = false

local gymLocationCount = #GymLocations
local localPlayer = PlayerData.Player
local stepWait = task.wait

local function getHumanoidRootPart()
	local character = localPlayer.Character
	if not character then return nil end
	return character:FindFirstChild("HumanoidRootPart")
end

Tabs.Teleport:AddSwitch("Gym Teleport", function(enabled)
	isGymTeleportEnabled = enabled
	if enabled then
		task.spawn(function()
			local currentIndex = 1
			while isGymTeleportEnabled do
				local hrp = getHumanoidRootPart()
				if hrp then
					local location = GymLocations[currentIndex]
					hrp.CFrame = location.pos
					currentIndex = (currentIndex % gymLocationCount) + 1
				end
				stepWait(0.01)
			end
		end)
	end
end)

local autoTeleportEnabled = false

local humanoidRootPart
local targetPositionCFrame = CFrame.new(-8, 0, -1000)

local function onCharacterAdded(character)
    humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
end

localPlayer.CharacterAdded:Connect(onCharacterAdded)
if localPlayer.Character then
    onCharacterAdded(localPlayer.Character)
end

Tabs.Teleport:AddSwitch("Auto TP to Water", function(enabled)
    autoTeleportEnabled = enabled
end)

RunService.Heartbeat:Connect(function()
    if not autoTeleportEnabled then return end
    if not humanoidRootPart or not humanoidRootPart.Parent then return end
    humanoidRootPart.CFrame = targetPositionCFrame
end)