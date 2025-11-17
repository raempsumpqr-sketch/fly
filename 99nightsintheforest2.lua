-- The original Rayfield loader and initialization from the Gist:
if not game.Players.LocalPlayer.PlayerScripts:FindFirstChild("Loaded") then
    local data = Instance.new("NumberValue") 
    data.Name = "Loaded"
    data.Parent = game.Players.LocalPlayer.PlayerScripts
    print("Loaded Scripts")

    local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    
    local event = ""
    local fling = false
    local opt = false
    local antiteleport = false
    local range = 15
    local partsdipping = false
    -- Create the main window
    local noclip = false
    local speed = 16
    local infjump = false
    local fakerun = false
    local infjumpv2 = false
    local antifling = false
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local bodyVelocity = Instance.new("BodyVelocity")

    -- --- START OF CUSTOM FLY LOGIC ---

    local function toggleFly(plr, isFlying)
        local char = plr.Character
        if not char then return end

        if isFlying then
            -- Create a massless, non-collidable part to sit on
            local seat = Instance.new("Part")
            seat.Name = "FlySeatPart"
            seat.Transparency = 1
            seat.CanCollide = false
            seat.Anchored = false
            seat.Massless = true
            seat.Parent = char
            seat.CFrame = char.HumanoidRootPart.CFrame
            
            -- Use a VehicleSeat to control player movement
            local vehicleSeat = Instance.new("VehicleSeat", seat)
            vehicleSeat.Disabled = true 
            vehicleSeat:Sit(char.Humanoid)
            
            plr:SetAttribute("IsFlying", true)
            plr:SetAttribute("FlySeat", vehicleSeat)
        else
            -- Stop flying: remove the seat and reset state
            local vehicleSeat = plr:GetAttribute("FlySeat")
            if vehicleSeat and vehicleSeat.Parent then
                vehicleSeat.Parent:Destroy()
            end
            plr:SetAttribute("IsFlying", false)
            plr:SetAttribute("FlySeat", nil)
            -- Character will automatically stand up
        end
    end

    -- --- END OF CUSTOM FLY LOGIC ---
    
    local Window = Rayfield:CreateWindow({
        Name = "W112ND",
        LoadingTitle = "Please wait",
        LoadingSubtitle = "By windows11_2nd",
        ShowText = "W112ND",
        ConfigurationSaving = { Enabled = true, FolderName = "Exploits", FileName = "Tools" },
        Discord = { Enabled = false, Invite = "", RememberJoins = true },
        KeySystem = false
    })

    Rayfield:Notify({ Title = "Warning", Content = "This is the only OFFICAL W112ND watch out for fake versions.", Duration = 4 }) 

    -- Create a tab
    local Tab = Window:CreateTab("Universial", 4483362458)
    local Tab2 = Window:CreateTab("MM2", 4483362458)
    local Tab3 = Window:CreateTab("Fred's House", 4483362458)

    -- --- ADDING THE FLY TOGGLE HERE ---
    Tab:CreateToggle({
        Name = "Easy Fly (Educational)",
        CurrentValue = false,
        Flag = "EasyFlying",
        Callback = function(Value)
            toggleFly(player, Value)
        end,
    })
    -- --- END OF FLY TOGGLE ADDITION ---

    -- ... [Rest of the original Gist script continues here, including all other buttons and toggles] ...
    
    Tab:CreateButton({ Name = "Get all tools", Callback = function() Rayfield:Notify({ Title = "Message", Content = "Getting all tools!", Duration = 4 }) for i,v in pairs(game:GetDescendants()) do if v:IsA("Tool") then v:Clone().Parent = game.Players.LocalPlayer.Backpack end end end }) 
    
    -- ... (The rest of the Gist content) ...

    -- Optimized render loop and other functions from the original script...
    local function render() 
        local char = player.Character 
        if not char then return end 
        for _, v in ipairs(char:GetDescendants()) do 
            if v:IsA("BasePart") then 
                if noclip then 
                    v.CanCollide = false 
                    v.LocalTransparencyModifier = 0.5 
                else 
                    v.LocalTransparencyModifier = 0 
                end 
            end 
        end 
        char:WaitForChild("Humanoid").WalkSpeed = speed 
    end 
    
    RunService.RenderStepped:Connect(render) 
    -- ... (remaining original functions) ...
end
