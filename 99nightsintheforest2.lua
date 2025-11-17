-- The original Rayfield loader and initialization:
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
    local speed = 16 -- This now controls fly speed
    local infjump = false
    local fakerun = false
    local infjumpv2 = false
    local antifling = false
    
    -- Services and Player Variables
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Fly Control Variables
    local isFlying = false
    local FlySpeed = 60  -- Set your fly speed here
    
    -- --- START OF FIXED FLY LOGIC ---

    local BodyVelocity = Instance.new("BodyVelocity")
    local BodyGyro = Instance.new("BodyGyro")
    
    -- MaxForce is set to infinity (math.huge) to ensure movement, overcoming all friction/gravity.
    local MaxForce = Vector3.new(math.huge, math.huge, math.huge)

    local function toggleFly(Value)
        isFlying = Value
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not char or not hrp then return end
        
        if isFlying then
            -- 1. Apply BodyMovers
            BodyVelocity.MaxForce = MaxForce
            BodyVelocity.Velocity = Vector3.new(0,0,0)
            BodyVelocity.Parent = hrp
            
            BodyGyro.MaxTorque = MaxForce
            BodyGyro.CFrame = hrp.CFrame
            BodyGyro.Parent = hrp
            
            -- 2. Disable normal movement physics
            humanoid.PlatformStand = true
            humanoid.WalkSpeed = 0 
        else
            -- 3. Cleanup and restore
            BodyVelocity:Destroy()
            BodyGyro:Destroy()
            humanoid.PlatformStand = false
            humanoid.WalkSpeed = speed -- Restore walk speed (default is 16, but uses 'speed' variable)
        end
    end

    -- Loop to constantly update movement while flying
    RunService.RenderStepped:Connect(function()
        if not isFlying then return end
        
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local camera = workspace.CurrentCamera
        if not hrp or not camera then return end
        
        -- Set the BodyGyro to face the camera direction
        BodyGyro.CFrame = camera.CFrame
        
        -- Calculate the desired movement velocity based on player input
        local moveDirection = humanoid.MoveDirection -- Reads WASD/Thumbstick input
        local currentVelocity = Vector3.new(0, 0, 0)
        
        if moveDirection.Magnitude > 0 then
            -- Convert the Humanoid's movement direction to the Camera's CFrame space
            currentVelocity = camera.CFrame.LookVector * moveDirection.Z * FlySpeed
            currentVelocity = currentVelocity + camera.CFrame.RightVector * moveDirection.X * FlySpeed
        end

        -- Check for dedicated up/down input (Space/Shift is common)
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            currentVelocity = currentVelocity + Vector3.new(0, FlySpeed, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            currentVelocity = currentVelocity - Vector3.new(0, FlySpeed, 0)
        end
        
        BodyVelocity.Velocity = currentVelocity
    end)
    
    -- --- END OF FIXED FLY LOGIC ---

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

    local Tab = Window:CreateTab("Universial", 4483362458)
    local Tab2 = Window:CreateTab("MM2", 4483362458)
    local Tab3 = Window:CreateTab("Fred's House", 4483362458)

    -- --- ADDING THE FIXED FLY TOGGLE HERE ---
    Tab:CreateToggle({
        Name = "Reliable Fly (Fixed)",
        CurrentValue = false,
        Flag = "ReliableFly",
        Callback = toggleFly, -- Call the fixed toggleFly function
    })
    -- --- END OF FLY TOGGLE ADDITION ---

    -- ... [Rest of the original Gist script continues here, including all other buttons and toggles] ...
end
