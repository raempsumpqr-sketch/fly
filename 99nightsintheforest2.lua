local function toggleFly(player, isFlying)
    local char = player.Character
    if not char then return end

    if isFlying then
        -- Create a massless, non-collidable part to sit on
        local seat = Instance.new("Part")
        seat.Transparency = 1
        seat.CanCollide = false
        seat.Anchored = false
        seat.Massless = true
        seat.Parent = char
        seat.CFrame = char.HumanoidRootPart.CFrame
        
        -- Use a VehicleSeat to control player movement like flying
        local vehicleSeat = Instance.new("VehicleSeat", seat)
        vehicleSeat.Disabled = true 
        vehicleSeat:Sit(char.Humanoid)
        
        player:SetAttribute("IsFlying", true)
        player:SetAttribute("FlySeat", vehicleSeat)
    else
        -- Stop flying: remove the seat and reset state
        local vehicleSeat = player:GetAttribute("FlySeat")
        if vehicleSeat and vehicleSeat.Parent then
            vehicleSeat.Parent:Destroy()
        end
        player:SetAttribute("IsFlying", false)
        player:SetAttribute("FlySeat", nil)
        -- Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) 
    end
end
