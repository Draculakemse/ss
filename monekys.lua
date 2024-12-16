repeat task.wait() until game:IsLoaded() and game:GetService("ReplicatedStorage"):FindFirstChild("ClientModules") and game:GetService("ReplicatedStorage").ClientModules:FindFirstChild("Core") and game:GetService("ReplicatedStorage").ClientModules.Core:FindFirstChild("UIManager") and game:GetService("ReplicatedStorage").ClientModules.Core:FindFirstChild("UIManager").Apps:FindFirstChild("TransitionsApp") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TransitionsApp") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TransitionsApp"):FindFirstChild("Whiteout")

local RS = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClientData = require(RS.ClientModules.Core.ClientData)
local Player = game:GetService("Players").LocalPlayer
local RouterClient = require(RS.ClientModules.Core:WaitForChild("RouterClient"):WaitForChild("RouterClient"))
local Main_Menu = require(RS.ClientModules.Core.UIManager.Apps.MainMenuApp)
local VirtualInputManager = game:GetService("VirtualInputManager")
local LiveOpsMapSwap = require(RS.SharedModules.Game.LiveOpsMapSwap)

local MinigameClient = require(RS.ClientModules.Game.MinigameHelpers.MinigameClient)
local SpleefMinigameClient = require(RS.SharedModules.ContentPacks.Winter2024.Minigames.SpleefMinigameClient)
local FrostclawsRevengeMinigameClient = require(RS.SharedModules.ContentPacks.Winter2024.Minigames.FrostclawsRevengeMinigameClient)

game.Players.LocalPlayer.Idled:Connect(function() 
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame) 
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame) 
end)

for i, v in pairs(debug.getupvalue(RouterClient.init, 7)) do
    v.Name = i
end

-- Press Button Functions
function FireButton(PassOn, dialogFramePass)
	task.wait()
	local dialogFrame = dialogFramePass or "NormalDialog"
	for i, v in pairs(Player.PlayerGui.DialogApp.Dialog[dialogFrame].Buttons:GetDescendants()) do
		if v.Name == "TextLabel" then
			if v.Text == PassOn then
                task.wait(2)
                firesignal(v.Parent.Parent.MouseButton1Down)
                firesignal(v.Parent.Parent.MouseButton1Click)
                firesignal(v.Parent.Parent.MouseButton1Up)
				break
			end
		end
	end
end

function clickGuiButton(button: Instance, xOffset: number, yOffset: number)
    if typeof(button) ~= "Instance" then print("button is not a Instance") return end
	local xOffset = xOffset or 60
	local yOffset = yOffset or 60

	task.wait()
	VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset, button.AbsolutePosition.Y + yOffset, 0, true, game, 1)
	task.wait()
	VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset, button.AbsolutePosition.Y + yOffset, 0, false, game, 1)
	task.wait()
end

-- Daily Rewards Func
local function dailyLoginAppClick()
	if not Player.PlayerGui.DailyLoginApp.Enabled then return end
	Player.PlayerGui.DailyLoginApp:WaitForChild("Frame")
	Player.PlayerGui.DailyLoginApp.Frame:WaitForChild("Body")
	Player.PlayerGui.DailyLoginApp.Frame.Body:WaitForChild("Buttons")
	for _, v in Player.PlayerGui.DailyLoginApp.Frame.Body.Buttons:GetDescendants() do
		if v.Name == "TextLabel" then
			if v.Text == "CLOSE" then
				clickGuiButton(v.Parent.Parent)
				task.wait(1)
			elseif v.Text == "CLAIM!" then
				firesignal(v.Parent.Parent.MouseButton1Down)
				firesignal(v.Parent.Parent.MouseButton1Click)
				firesignal(v.Parent.Parent.MouseButton1Up)
				task.wait(.2)
				firesignal(v.Parent.Parent.MouseButton1Down)
				firesignal(v.Parent.Parent.MouseButton1Click)
				firesignal(v.Parent.Parent.MouseButton1Up)
			end
		end
	end
end

-- Dismiss Popups
RoleChooserDialogConnection = Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog:GetPropertyChangedSignal("Visible"):Connect(function()
	task.wait()
	if Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Visible then
		firesignal(Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Down)
		firesignal(Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Click)
		firesignal(Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Up)
		RoleChooserDialogConnection:Disconnect()
	end
end)

RobuxProductDialogConnection1 = Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog:GetPropertyChangedSignal("Visible"):Connect(function()
	if not Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Visible then return end
	Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog:WaitForChild("Buttons")
	task.wait()
	for _, v in Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Buttons:GetDescendants() do
		if v.Name == "TextLabel" then
			if v.Text == "No Thanks" then
				firesignal(v.Parent.Parent.MouseButton1Down)
				firesignal(v.Parent.Parent.MouseButton1Click)
				firesignal(v.Parent.Parent.MouseButton1Up)
				RobuxProductDialogConnection1:Disconnect()
			end
		end
	end
end)


RobuxProductDialogConnection2 = Player.PlayerGui.DialogApp.Dialog:GetPropertyChangedSignal("Visible"):Connect(function()
	if not Player.PlayerGui.DialogApp.Dialog.Visible then return end
	Player.PlayerGui.DialogApp.Dialog:WaitForChild("RobuxProductDialog")
	if not Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Visible then return end
	Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog:WaitForChild("Buttons")
	task.wait()
	for _, v in Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Buttons:GetDescendants() do
		if v.Name == "TextLabel" then
			if v.Text == "No Thanks" then
				firesignal(v.Parent.Parent.MouseButton1Down)
				firesignal(v.Parent.Parent.MouseButton1Click)
				firesignal(v.Parent.Parent.MouseButton1Up)
				RobuxProductDialogConnection2:Disconnect()
			end
		end
	end
end)


DailyClaimConnection = Player.PlayerGui.DailyLoginApp:GetPropertyChangedSignal("Enabled"):Connect(function()
	dailyLoginAppClick()
end)

--[[
Player.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal("Visible"):Connect(function()
    if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
        Player.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild("Info")
        Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild("TextLabel")
        Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
            task.wait(2)
            if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("You have been awarded") or Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("was added to your inventory") then
                for i, v in pairs(Player.PlayerGui.DialogApp.Dialog["NormalDialog"].Buttons:GetDescendants()) do
                    if v.Name == "TextLabel" then
                        if v.Text == "Awesome!" then
                            clickGuiButton(v.Parent.Parent)
                            break
                        end
                    end
                end
            elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Are you subscribed") then
                FireButton("No")
            elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("You found a") or Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Subscribe to") then
                for i, v in pairs(Player.PlayerGui.DialogApp.Dialog["NormalDialog"].Buttons:GetDescendants()) do
                    if v.Name == "TextLabel" then
                        if v.Text == "Okay" then
                            clickGuiButton(v.Parent.Parent)
                            break
                        end
                    end
                end
            end
        end)
    end
end)
]]

repeat task.wait(1) until Player.PlayerGui.NewsApp.Enabled

if Player.PlayerGui.NewsApp.Enabled then
	local AbsPlay = Player.PlayerGui.NewsApp
		:WaitForChild("EnclosingFrame")
		:WaitForChild("MainFrame")
		:WaitForChild("Contents")
		:WaitForChild("PlayButton")

	firesignal(AbsPlay.MouseButton1Down)
	firesignal(AbsPlay.MouseButton1Click)
	firesignal(AbsPlay.MouseButton1Up)
end

if Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Visible then --Baby, ChooseParent
	firesignal(Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Click)
	RoleChooserDialogConnection:Disconnect()
end

-- Load in house
ReplicatedStorage:WaitForChild("API"):WaitForChild("HousingAPI/SetDoorLocked"):InvokeServer(true)
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
Player.PlayerGui.DialogApp.Enabled = false

--[[
if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Thanks for subscribing!") then
	FireButton("Okay")
end

if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Are you subscribed") then
	FireButton("No")
end

if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("You have been awarded") then
	FireButton("Awesome!")
end
]]

dailyLoginAppClick()

-- Minigame Code

Player.PlayerGui.FrostclawsRevengeUpgradeApp.Background.Upgrades.ChildAdded:Connect(function(child)
    if child.Name ~= "Upgrade1" then return end
    child:WaitForChild("Icon")
    child.Icon:WaitForChild("Container")
    child.Icon.Container:WaitForChild("Button")

    local count = 0
    repeat
        task.wait(1)
        if child:FindFirstChild("Icon") then
            firesignal(child.Icon.Container.Button.Activated)
        end
        count += 1
    until not Player.PlayerGui.FrostclawsRevengeUpgradeApp.Enabled or count > 15

    print("[Rolox Event Script] : Upgrade Selected")
end)

function farmGingerbreads()
    local GingerbreadMarkers = RS.Resources.IceSkating.GingerbreadMarkers
    for _, v in GingerbreadMarkers:GetChildren() do
        if v:IsA("BasePart") and not ClientData.get_data()[Player.Name].winter_2024_gingerbread_captured_list[v.Name] then
            RS.API:FindFirstChild("WinterEventAPI/PickUpGingerbread"):InvokeServer(v.Name)
        end
    end
    RS.API:FindFirstChild("WinterEventAPI/RedeemPendingGingerbread"):FireServer()
end

function getEventCurrency()
    return (ClientData.get_data()[Player.Name][require(RS.SharedModules.SharedDB.AltCurrencyData)["name"]] or 0)
end

function ChangeDestination(zone)
    print("Old Destination:", FrostclawsRevengeMinigameClient["join_zone_destination_id"])
    FrostclawsRevengeMinigameClient["join_zone_destination_id"] = zone
    print("New Destination:", FrostclawsRevengeMinigameClient["join_zone_destination_id"])
end

local function createLobby()
    return RS.API["MinigameAPI/LobbyCreate"]:InvokeServer("frostclaws_revenge")
end

local function startLobby()
    RS.API["MinigameAPI/LobbyStart"]:FireServer()
end

function getMinigameId()
    local gameId
    local model = workspace.Interiors:FindFirstChildWhichIsA("Model")
    if not model then
        local count = 0
        repeat
            task.wait(1)
            count += 1
            model = workspace.Interiors:FindFirstChildWhichIsA("Model")
        until model  or count > 30
        if count > 30 then
            print("wouldnt get model")
            return nil
        end
    end

    if model then
        local count = 0
        repeat
            if model.Name:match("FrostclawsRevengeInterior") then
                gameId = model.Name:split("::")[2]
            end
            count += 1
            task.wait(1)
        until gameId or count > 30
    end
  
    return gameId
end

function isGameActive()
    if workspace.Interiors:FindFirstChildWhichIsA("Model") then
        return (workspace.Interiors:FindFirstChildWhichIsA("Model").Name):match("Frostclaw")
    end
end

local function hitEnemy(name, gameId)
    local args = {
        [1] = "frostclaws_revenge::"..gameId,
        [2] = "hit_enemies",
        [3] = {
            [1] = name
        },
        [4] = "sword_slash"
    }

    ReplicatedStorage.API["MinigameAPI/MessageServer"]:FireServer(unpack(args))
end

function StartGame()
    local minigameId = getMinigameId()
    if not minigameId then return end

    local isGameActive = true

    while isGameActive do
        for _, v in workspace.Minigames[`FrostclawsRevengeInterior::{minigameId}`]:WaitForChild("FrostclawsRevengeEnemies"):GetChildren() do
            hitEnemy(v.Name, minigameId)
        end
        
        local minigameStateFolder = workspace.StaticMap:FindFirstChild(`frostclaws_revenge::{minigameId}_minigame_state`)
        if not minigameStateFolder then print("game over or no folder") break end
        isGameActive = minigameStateFolder:WaitForChild("is_game_active").Value
        task.wait()
    end

    local count = 0
    repeat
        count += 1
        task.wait(1)
    until not workspace.Minigames:FindFirstChild(`FrostclawsRevengeInterior::{minigameId}`) or count > 30
end

function CreateAndStartLobby()
    if not createLobby() then
        createLobby()
    end

    local count = 0
    local name
    repeat
        startLobby()
        count += 1
        task.wait(2)
        local model = workspace.Interiors:FindFirstChildWhichIsA("Model")
        if model then
            name = model.Name:match("FrostclawsRevengeInterior")
            print(name)
        end
    until name == "FrostclawsRevengeInterior" or count > 30
    if count > 30 then
        return false
    end

    return true
end

function CreatePlatform()
    if workspace:FindFirstChild("TempPartA") then 
        workspace.TempPartA:Destroy() 
    end
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then  
        game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = true
        local a = Instance.new("Part", workspace)
        a.Size = Vector3.new(500,0,500)
        a.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -2, 0)
        a.CanCollide = true 
        a.Anchored = true 
        a.Transparency = 1 
        a.Name = "TempPartA"
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a.CFrame + Vector3.new(0, 1, 0)
        Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
    end
end

-- Optimization
require(RS.ClientModules.Core.UIManager.Apps.TransitionsApp).transition = function() return end 
require(RS.ClientModules.Core.UIManager.Apps.TransitionsApp).sudden_fill = function() return end
if Player.PlayerGui.TransitionsApp:FindFirstChild("Whiteout").Visible then 
    Player.PlayerGui.TransitionsApp:FindFirstChild("Whiteout").Visible = false 
end

networkSettings = settings().Network
renderSettings = settings().Rendering
physicsSettings = settings()['Physics']
gameSettings = settings()["Game Options"]
userGameSettings = UserSettings():FindService("UserGameSettings") or UserSettings():GetService("UserGameSettings")

-- -- Render Settings
renderSettings.QualityLevel = Enum.QualityLevel.Level01
renderSettings.ShowBoundingBoxes = false
renderSettings.RenderCSGTrianglesDebug = false
renderSettings.MeshCacheSize = 0
renderSettings.GraphicsMode = Enum.GraphicsMode.NoGraphics
renderSettings.MeshCacheSize = Enum.MeshPartDetailLevel.Level01
renderSettings.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
renderSettings.EagerBulkExecution = false
renderSettings.EnableFRM = true
renderSettings.AutoFRMLevel = 0
renderSettings.ExportMergeByMaterial = false
renderSettings.ReloadAssets = false 
renderSettings.MeshPartDetailLevel = "Level00"
renderSettings.QualityLevel = "Level01"
renderSettings.EditQualityLevel = "Level01"

-- -- User Game Settings
userGameSettings.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
userGameSettings.HasEverUsedVR = false 
userGameSettings.ChatVisible = false
userGameSettings.AllTutorialsDisabled = false
userGameSettings.Fullscreen = false
userGameSettings.GraphicsQualityLevel = 0
userGameSettings.SavedQualityLevel = 0 


--Physics Settings 
physicsSettings.AllowSleep = true 
physicsSettings.AreAnchorsShown = false 
physicsSettings.AreAssembliesShown = false 
physicsSettings.AreAssemblyCentersOfMassShown = false 
physicsSettings.AreAwakePartsHighlighted = false 
physicsSettings.AreBodyTypesShown = false 
physicsSettings.AreCollisionCostsShown = false 
physicsSettings.AreConstraintForcesShownForSelectedOrHoveredInstances = false 
physicsSettings.AreContactForcesShownForSelectedOrHoveredAssemblies = false 
physicsSettings.AreContactIslandsShown = false 
physicsSettings.AreContactPointsShown = false 
physicsSettings.AreJointCoordinatesShown = false 
physicsSettings.AreMagnitudesShownForDrawnForcesAndTorques = false 
physicsSettings.AreMechanismsShown = false 
physicsSettings.AreModelCoordsShown = false 
physicsSettings.AreOwnersShown = false 
physicsSettings.ArePartCoordsShown = false 
physicsSettings.AreRegionsShown = false 
physicsSettings.AreSolverIslandsShown = false 
physicsSettings.AreTerrainReplicationRegionsShown = false 
physicsSettings.AreTimestepsShown = false 
physicsSettings.AreUnalignedPartsShown = false 
physicsSettings.AreWorldCoordsShown = false 
physicsSettings.DisableCSGv2 = true 
physicsSettings.ForceDrawScale = 0 
physicsSettings.IsInterpolationThrottleShown = false 
physicsSettings.IsReceiveAgeShown = false 
physicsSettings.IsTreeShown = false 
physicsSettings.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
physicsSettings.ShowDecompositionGeometry = false 
physicsSettings.ThrottleAdjustTime = 1

-- Network Settings
networkSettings.PrintPhysicsErrors = false
networkSettings.PrintJoinSizeBreakdown = false
networkSettings.PrintStreamInstanceQuota = false
networkSettings.RandomizeJoinInstanceOrder = false
networkSettings.RenderStreamedRegions = false
networkSettings.ShowActiveAnimationAsset = false

print("[Optimizer] : Level 1 Executed")

function Optimizer()
    UserSettings():GetService("UserGameSettings").MasterVolume = 0
    local decalsyeeted = true
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    sethiddenproperty(l,"Technology",2)
    sethiddenproperty(t,"Decoration",false)
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat,false)
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = 0
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "0"
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
    task.wait()
    for i, v in pairs(w:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") and decalsyeeted then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        elseif v:IsA("SpecialMesh") and decalsyeeted  then
            v.TextureId=0
        elseif v:IsA("ShirtGraphic") and decalsyeeted then
            v.Graphic=1
        end
    end
    for i = 1,#l:GetChildren() do
        e=l:GetChildren()[i]
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
    w.DescendantAdded:Connect(function(v)
        pcall(function()
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") and decalsyeeted then
                v.Material = "Plastic"
                v.Reflectance = 0
                v.TextureID = 10385902758728957
            elseif v:IsA("SpecialMesh") and decalsyeeted then
                v.TextureId=0
            elseif v:IsA("ShirtGraphic") and decalsyeeted then
                v.ShirtGraphic=1
            end
        end)
        task.wait()
    end)

    workspace.Terrain.WaterReflectance = 0
    workspace.Terrain.WaterTransparency = 1
    workspace.Terrain.WaterWaveSize = 0
    workspace.Terrain.WaterWaveSpeed = 0

    for i,v in pairs(game.Lighting:GetChildren()) do 
        if v:IsA("Model") then
            v:Destroy()
        elseif v.Name:match("Weather") then 
            v:Destroy()
        end 
    end
    game.Lighting.Brightness = 0

    game.Lighting.ChildAdded:Connect(function()
        for i,v in pairs(game.Lighting:GetChildren()) do 
            if v:IsA("Model") then
                v:Destroy()
            elseif v.Name:match("Weather") then 
                v:Destroy()
            end 
        end
        game.Lighting.Brightness = 0
    end)
    print("[Optimizer] : Level 2 Executed")
end

workspace.Pets.ChildAdded:Connect(function(c)
    task.wait(1)
    for i, v in pairs(workspace.Pets:GetChildren()) do
        v.Parent = game.ReplicatedStorage
    end
end)

workspace.PlayerCharacters.ChildAdded:Connect(function(c)
    task.wait(1)
    for i, v in pairs(workspace.PlayerCharacters:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            v.Parent = game.ReplicatedStorage
        end
    end
end)

workspace.Interiors.ChildAdded:Connect(function(c)
    task.wait(0.1)
    if c.Name == "Winter2024Shop" then
        CreatePlatform()
        for i,v in pairs(workspace.Interiors.Winter2024Shop:GetChildren()) do
            if v.Name == "Visual" or v.Name == "Mannequins" or v.Name == "ShopPedestals" then
                if v.Name == "Visual" then
                    for l,o in pairs(workspace.Interiors.Winter2024Shop.Visual:GetChildren()) do
                        if o.Name ~= "Model" then
                            o.Parent = game.ReplicatedStorage
                        end
                    end
                else
                    v.Parent = game.ReplicatedStorage
                end
                task.wait()
            end
        end
    elseif c.Name:match("FrostclawsRevengeInterior") then
        for i,v in pairs(c:GetDescendants()) do
            if v.Name == "Visual" then
                v.Parent = game.ReplicatedStorage
                task.wait()
            end
        end
        if workspace:FindFirstChildWhichIsA("Terrain") then workspace.Terrain:Clear() end
    end
end)

Optimizer()

pcall(function()
    for i,v in pairs(game:GetService("ReplicatedStorage").ClientServices:GetDescendants()) do 
        if v:IsA("ModuleScript") and require(v) and require(v).init and v.Name ~= "DoorsClient" and v.Name ~= "ResetHandler" then 
        require(v).init = function() return end 
        end 
    end 
    for i,v in pairs(require(game:GetService("ReplicatedStorage").ClientModules.Core.WeatherClient.WeatherClient)) do 
        if type(v) == "function" then 
        v = function() return end 
        end
    end   
    for i,v in pairs(game:GetService("ReplicatedStorage").ClientModules.Game.PetEntities.PetPerformancesFolder.Emotes:GetChildren()) do 
        if v:IsA("ModuleScript") then 
            require(v).step = function() return end 
        end
    end    
    for i,v in pairs(game:GetService("ReplicatedStorage").ClientModules.Game.PetEntities.PetReactions:GetChildren()) do 
        require(v).init_reaction = function() return end 
    end  
    for i,v in pairs(game:GetService("ReplicatedStorage").ClientModules.Game.PetEntities.PetPerformancesFolder.Transitions:GetChildren()) do 
        if v:IsA("ModuleScript") then 
            require(v).step = function() return end 
        end
    end   
    for Data,Effect in pairs(require(game:GetService("ReplicatedStorage").ClientModules.Core.UIManager.Apps.SpecialEffectsApp)) do 
        if type(Data) == "function" then 
            Data = function() return end 
        end
    end
    print("[Optimizer] : Level 3 Executed")
end)

spawn(function()
    while task.wait() do
        Winter2024AdventManager = ClientData.get_data()[game.Players.LocalPlayer.Name]["winter_2024_advent_manager"]
        if not Winter2024AdventManager["rewards_claimed"][#Winter2024AdventManager["replicated_rewards"]] then
            RS.API:WaitForChild("WinterEventAPI/AdventCalendarTryTakeReward"):InvokeServer(i)
        end

        farmGingerbreads()

        task.wait(200)
    end
end)

--ChangeDestination("School")
Player.Character.HumanoidRootPart.Anchored = true

while task.wait() do
    local startGingerbread = getEventCurrency()
    print("[Rolox Event Script] : Start Gingerbread:", startGingerbread)

    local gameStartTime = tick()
   
    if CreateAndStartLobby() then
        print("[Rolox Event Script] : Minigame Started")
        StartGame()
    end

    print("[Rolox Event Script] : Game Over! Took", math.floor(tick()-gameStartTime), "seconds long!")

    print("[Rolox Event Script] : Gained Gingerbread:", getEventCurrency()-startGingerbread)
    print("[Rolox Event Script] : Total Gingerbread:", getEventCurrency())

    pcall(CreatePlatform)
end
