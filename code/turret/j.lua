
if false then
    Sol = require("code/turret/foobar")
    Machine, GetPort, URLEncode, JSONEncode, JSONDecode, Beep = Sol()
end
num1, num2 = pcall(function()
    port1 = GetPort(1)
    print(port1)
    local lifesensor = port1:GetPart("LifeSensor")
    local gyro = port1:GetPart("Gyro")
    local instrument = port1:GetPart("Instrument")
    local switch = port1:GetPart("Switch")
    local raycasters = port1:GetParts("Raycaster")
    local speaker = port1:GetPart("Speaker")
    local microphone = port1:GetPart("Microphone")
    local ssd = Machine:GetExpansions().SSD
    local whitelistString = ssd:Read("whitelist")
    local link = ssd:Read("link") or nil
    local playerwhitelist = if whitelistString then JSONDecode(whitelistString) else {}
    switch:Configure({SwitchState = false}) -- Make sure the turret is not firing
    print("i got playerwhitelist")
    local prefix = "!t "
    local aimingCoroutine = nil
    WEIGHTS = {
        health = 2.1, -- Multiplication
        distance = 2, -- Multiplication
        previous = 0.5, -- Addition
    }
    
    
    local function EvaluateRaycasterTarget(result)
        if result then
            if isintable(playerwhitelist, result.Name) or isintable(playerwhitelist, result.LockedBy) then
                return false -- Do not fire at whitelisted players
            else
                return true -- Target is valid for firing
            end
        end
        return "no result" -- No target found
    end
    local near = 5 -- studs
    local far = 200 -- studs
    local function FindClosestTarget(reading, currentpos, previous)
        local closest = {nil, math.huge, 0}
        for _, v in pairs(reading) do
            if not isintable(playerwhitelist, v.Name) and v.Health > 0 then
                local pos = v.Position
                local mag = (pos - currentpos).Magnitude
    
                -- Check if target is within the allowed distance range
                if mag >= near and mag <= far then
                    local weight = (v.Health / 100 * WEIGHTS.health) + (1 - mag / far * WEIGHTS.distance)
                    local randomFactor = math.random() * 0.1  -- Adjust the range of randomness as needed
                    weight = weight + randomFactor
                    if v.ID == previous then weight += WEIGHTS.previous end
                    print(v.ID, weight)
                    if weight > closest[3] then
                        closest = {v, mag, weight}
                    end
                end
            end
        end
        return closest[1]  -- Return the closest target object or nil
    end
    local function CalculateRotation(currentpos, targetpos, currentRoll)
        local direction = (targetpos - currentpos).unit * -1
        local yaw = math.deg(math.atan2(direction.x, direction.z))
        local pitch = math.deg(math.atan2(direction.y, math.sqrt(direction.x^2 + direction.z^2)))
        
        local adjustedRoll = currentRoll -- Placeholder for any roll adjustments
        
        return Vector3.new(pitch, yaw, adjustedRoll)
    end
    local function getVelocityMultiplier(distance)
        -- Ensure 'near' is less than 'far' to avoid negative multipliers
        if near >= far then
            error("Near distance must be less than far distance")
        end
    
        -- Linear scaling of multiplier from 0 at 'near' to 1 at 'far'
        return math.clamp(((distance - near) / (far - near)), 0, 1)
    end
    
    local function AimAndFireAtTarget(target)
        local currentpos = instrument:GetReading(3)
        local distance = (target.Position - currentpos).Magnitude
        if distance > far then
            return -- Do not aim at targets that are too far away
        end
        if distance < near then
            return -- Do not aim at targets that are too close
        end
    
    
    
        local distance = (target.Position - currentpos).Magnitude
        if distance > far then
            switch:Configure({SwitchState = false})
            return -- Do not aim at targets that are too far away
        end
        if distance < near then
            switch:Configure({SwitchState = false})
            return -- Do not aim at targets that are too close
        end
        local newpos = target.Position + (target.AssemblyLinearVelocity * getVelocityMultiplier(distance))
        gyro:LookAtVector(newpos)
        if target ~= nil and target.Health == 0 then
            switch:Configure({SwitchState = false})
            return -- Do not aim at dead targets
        end
        local amountNoResult = 0
        local shouldFire = false
        for _, raycaster in ipairs(raycasters) do
            local result = raycaster:GetReading()
            local result2 = EvaluateRaycasterTarget(result)
            if result2 == true then
                shouldFire = true
            elseif result2 == "no result" then
                amountNoResult += 1
                shouldFire = false
                break -- In case one is touching important parts
            end
        end
        if amountNoResult == #raycasters then
            shouldFire = false -- Why fire at nothing or terrain?
        end
        
        -- Fire if the target is valid and not a friend
        if shouldFire and target.Health > 0 then
            switch:Configure({SwitchState = true})
            -- Additional logic for firing duration or burst firing can be added here
        else
            print("sad2")
            switch:Configure({SwitchState = false})
        end
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
        if not t then return end
        for k,v in pairs(t) do
            if type(v) == "table" then
                recursiveprint(v)
            else
                print(k,v)
            end
        end
    end
    
    function StartAiming()
        print("Starting aiming coroutine...")
        aimingCoroutine = coroutine.create(function()
            local previous = nil
            while task.wait() do -- make sure we dont murder the server
                num3,num4 = pcall(function()
                    local currentpos = instrument:GetReading(3)
                    local reading = lifesensor:GetReading()
                    local target = FindClosestTarget(reading, currentpos, previous)
                    if target then
                        print("yippee!!")
                        AimAndFireAtTarget(target)
                        previous = target.ID
                        print("set!!!")
                    else
                        print("sad")
                        switch:Configure({SwitchState=false})
                    end
                end)
                print(num3, num4)
                end
            end)
            coroutine.resume(aimingCoroutine)
        end
        
        local function parseArgs(argstr:string)
        return argstr:split(" ")
    end
    
    local function findIndex(t, data)
        for index, value in t do
            if value == data then
                return index
            end
        end
        return nil  -- Return nil if data is not found
    end
    function StopAiming()
        if aimingCoroutine then
            coroutine.close(aimingCoroutine)
            aimingCoroutine = nil
        end
        switch:Configure({SwitchState = false}) -- Make sure the turret is not firing    
    end

    local methods = {}
    function getMethods()
        return methods
    end
    methods = {
        addWhitelist = {
            reqWhitelist = true,
            func = function(plr, args)
                -- Does it already exist?
                if isintable(playerwhitelist, args[1]) then
                    speaker:Chat("Player is already whitelisted!")
                else
                    table.insert(playerwhitelist, args[1])
                    speaker:Chat("Player has been added to the whitelist!")
                    print("i got here")
                    print(args[1])
                    recursiveprint(playerwhitelist)
                    ssd:Write("whitelist", JSONEncode(playerwhitelist))
                end
            end
        },
        remWhitelist = {
            reqWhitelist = true,
            func = function(plr, args)
                if plr == args[1] then
                    speaker:Chat("You cannot remove yourself!")
                else
                    table.remove(playerwhitelist, findIndex(playerwhitelist, args[1]))
                    speaker:Chat("Player has been removed from the whitelist!")
                    ssd:Write("whitelist", JSONEncode(playerwhitelist))
                end
            end
        },
        start = {
            reqWhitelist = true,
            func = function(plr, args)
                speaker:Chat("Starting turret...")
                StartAiming()
            end
        },
        stop = {
            reqWhitelist = true,
            func = function(plr, args)
                speaker:Chat("Stopping turret...")
                StopAiming()
            end
        },
        list = {
            reqWhitelist = true,
            func = function(plr, args)
                speaker:Chat("Whitelisted players:")
                for _, v in pairs(playerwhitelist) do
                    speaker:Chat("@"..v)
                    task.wait(0.5)
                end
            end
        },
        reset = {
            reqWhitelist = true,
            func = function(plr, args)
                speaker:Chat("Resetting turret...")
                StopAiming()
                ssd:Write("whitelist", JSONEncode({}))
                speaker:Chat("Turret has been reset!")
            end
        },
        init = {
            reqWhitelist = false,
            func = function(plr, args)
                if #playerwhitelist == 0 then
                    table.insert(playerwhitelist, plr)
                    print("i got here")
                    print(plr)
                    recursiveprint(playerwhitelist)
                    ssd:Write("whitelist", JSONEncode(playerwhitelist))
                    speaker:Chat("You have been added to the whitelist!")
                else
                    speaker:Chat("The whitelist has already been initialized!")
                end
            end
        },
        listCommands = {
            reqWhitelist = false,
            func = function(plr, args)
                speaker:Chat("Commands:")
                for k, v in getMethods() do
                    speaker:Chat(prefix .. k)
                    task.wait(0.5)
                end
            end
        },

    }
    
    
    function OnChat(msg, plr)
        print("Message Received: ", msg)
        print("Expected Prefix: ", prefix)
        print("Actual Prefix: ", msg:sub(1, prefix:len()))
        if msg:sub(1, prefix:len()) == prefix then
            print("yipee")
            local args = parseArgs(msg:sub(prefix:len() + 1))
            local method = methods[args[1]]
            -- Remove the command from the args
            table.remove(args, 1)
            if method then
                if method.reqWhitelist and not isintable(playerwhitelist, plr) then
                    speaker:Chat("You are not whitelisted to use this command!")
                else
                    method.func(plr, args)
                end
            else
                speaker:Chat("Invalid command!")
            end
        else
            print("nope")
        end
    end
    -- Does the whitelist contain anything?
    if #playerwhitelist == 0 then
        speaker:Chat("No players are whitelisted! Use !t init to add yourself to the whitelist.")
    end
    
    microphone.Chatted:Connect(OnChat)
    print("works?")
    speaker:Chat("hi!!")
    while task.wait(1) do
    end
    
end)
print(num1, num2)