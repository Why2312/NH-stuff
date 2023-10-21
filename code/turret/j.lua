port1 = GetPort(1)
print(port1)
lifesensor = port1:GetPart("LifeSensor")
gyro = port1:GetPart("Gyro")
instrument = port1:GetPart("Instrument")
switch = port1:GetPart("Switch")
raycaster = port1:GetPart("Raycaster")
print(lifesensor)
playerwhitelist = {"GenericRblxStudioDev", "ihaterover2001", "ognistylisel", "Subaru112", "Nadgob1", "mantux_he6yearsold", "GazaAudio", "xBarkDog500"}


WEIGHTS = {
    health = 2.1, -- Multiplication
    distance = 1.3, -- Multiplication
    previous = 2.0, -- Addition
}

local near = 5 -- studs
local far = 200 -- studs
function CalculateRotation(currentpos, targetpos)
    -- Calculate the direction vector from currentpos to targetpos
    local direction = (targetpos - currentpos).unit * -1

    -- Calculate yaw (rotation around the y-axis)
    local yaw = math.deg(math.atan2(direction.x, direction.z))

    -- Calculate pitch (rotation around the x-axis) using atan2
    local pitch = math.deg(math.atan2(direction.y, math.sqrt(direction.x^2 + direction.z^2)))

    -- Create a Vector3 to represent the rotation angles with roll set to 0
    local rotationAngles = Vector3.new(pitch, yaw, 0)

    return rotationAngles
end

function GetTarget(list, name)
    for k,v in pairs(list) do
        if v.ID == name then
            return v
        end
    end
    return nil
end
function isintable(t, v)
    for k, v2 in pairs(t) do
        if v2 == v then
            return true
        end
    end
    return false
end

function recursiveprint(t)
    for k,v in pairs(t) do
        if type(v) == "table" then
            recursiveprint(v)
        else
            print(k,v)
        end
    end
end

-- Initialize closest to a non-nil value
local previous = nil
while task.wait() do
    local currentpos = instrument:GetReading(3)
    local reading = lifesensor:GetReading()
    local closest = {nil, math.huge, 0}
    for k, v in pairs(reading) do
        if isintable(playerwhitelist, v.Name) then
            continue 
        end
        if v.Health == 0 then continue end
        -- Set position of closest using magnitude of vector
        local pos = v.Position
        local mag = (pos - currentpos).Magnitude
        -- Adjusted weight calculation
        local weight = (v.Health / 100 * WEIGHTS.health) + (1 - mag / far * WEIGHTS.distance)
        if v.ID == previous then weight += WEIGHTS.previous end -- If its the same target, increase weight, since we want to kill it
        if weight > closest[3] then
            closest = {v, mag, weight}
        end
    end
    -- Check if closest is still non-nil before using it
    if closest[1] ~= nil then
        previous = closest[1].ID
        local newpos = closest[1].Position + (closest[1].AssemblyLinearVelocity * 0.75)
        -- Aim 2 studs lower now to account for the head and aim slightly right due to model itself (2 studs)
        newpos = newpos + Vector3.new(0, -0.5, 0) + Vector3.new(-0.5, 0, 0)
        -- Calculate rotation
        local rot = CalculateRotation(currentpos, newpos)
        gyro:LookAtVector(newpos)
        local count = 0
        while task.wait() do
            -- Check even if target is still alive
            local reading = lifesensor:GetReading()
            local target = GetTarget(reading, closest[1].ID)
            -- All passed? point to its new position and shoot
            local newpos = target.Position + (target.AssemblyLinearVelocity * 0.55)
            -- Aim 2 studs lower now to account for the head and aim slightly right due to model itself (2 studs)
            newpos = newpos + Vector3.new(0, -0.5, 0) + Vector3.new(-0.5, 0, 0)
            gyro:LookAtVector(newpos) -- no need to check if we are hitting a part, most likely sure it barely moves
            if target ~= nil and target.Health == 0 then
                break
            end
            if not target then break end
            if count > 60 then break end -- Break after 45 frames
            local currentrot = instrument:GetReading(4)
            -- Check magnitude of rotation, if its close enough, break (10 degrees)
            if (rot - currentrot).Magnitude < 5 then
                break
            end
            count += 1
        end
        local fire = false
        local result = raycaster:GetReading()
        if result then
            pcall(function()
                -- We dont want to shoot our parts do we?
                if result.Type == "Humanoid" then fire = true return end
                -- Check if its the player we want to shoot
                if result.Type == "Humanoid" and isintable(playerwhitelist, result.Name) then
                    fire = false
                    return 
                end
                if isintable(playerwhitelist, result.LockedBy) then
                    fire = false
                    return
                elseif result.LockedBy == nil then
                    fire = true
                    return
                elseif result.LockedBy ~= nil then -- Would of catched the first if statement if it were friendly, so it must be an enemy
                    fire = true
                    return
                end
            end)
        end
        if not result then fire = true end
        -- Check if closest character is still alive before shooting it
        if fire and closest[1].Health > 0 then
            switch:Configure({SwitchState = true})
            local count = 0
            local fire = false
            while task.wait() do
                -- Check raycaster, are we hitting a friendly part?
                local result = raycaster:GetReading()
                if result ~= nil then
                    pcall(function()
                        -- We dont want to shoot our parts do we?
                        if result.Type == "Humanoid" and isintable(playerwhitelist, result.Name) then
                            fire = false
                            return
                        end
                        if result.Type == "Humanoid" and not isintable(playerwhitelist, result.Name) then fire = true return end
                        -- Check if its the player we want to shoot
                        if isintable(playerwhitelist, result.LockedBy) then
                            fire = false
                            return
                        elseif result.LockedBy == nil then
                            fire = true
                            return
                        elseif result.LockedBy ~= nil then -- Would of catched the first if statement if it were friendly, so it must be an enemy
                            fire = true
                            return
                        end
                    end)
                end
                if result == nil then fire = true end
                if fire then switch:Configure({SwitchState = true}) else switch:Configure({SwitchState = false}) end
                -- Fail if 20 frames have passed
                if count > 20 then break end
                -- Read life sensor, check if target is dead yet
                local reading = lifesensor:GetReading()
                local target = GetTarget(reading, closest[1].ID)
                -- Check Health or if nil
                if not target then break end
                if target ~= nil and target.Health == 0 then
                    break
                end
                -- All passed? point to its new position and shoot
                local newpos = target.Position + (target.AssemblyLinearVelocity * 0.60)
                -- Aim 2 studs lower now to account for the head and aim slightly right due to model itself (2 studs)
                newpos = newpos + Vector3.new(0, -0.5, 0) + Vector3.new(-0.5, 0, 0)
                gyro:LookAtVector(newpos) -- no need to check if we are hitting a part, most likely sure it barely moves
                count += 1
            end
            switch:Configure({SwitchState = false})
        else
            switch:Configure({SwitchState = false})
        end
    end
end