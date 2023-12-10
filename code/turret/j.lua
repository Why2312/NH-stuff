port1 = GetPort(1)
print(port1)
lifesensor = port1:GetPart("LifeSensor")
gyro = port1:GetPart("Gyro")
instrument = port1:GetPart("Instrument")
switch = port1:GetPart("Switch")
raycasters = port1:GetParts("Raycaster")
speaker = port1:GetPart("Speaker")
microphone = port1:GetPart("Microphone")
ssd = Machine:GetExpansions().SSD
print(lifesensor)
playerwhitelist = JSONDecode(ssd:Read("whitelist")) or {}
local prefix = "!t "
local aimingCoroutine = nil
WEIGHTS = {
    health = 2.1, -- Multiplication
    distance = 1.3, -- Multiplication
    previous = 2.0, -- Addition
}


local function EvaluateRaycasterTarget(result)
    if result and result.Type == "Humanoid" then
        if isintable(playerwhitelist, result.Name) or isintable(playerwhitelist, result.LockedBy) then
            return false -- Do not fire at whitelisted players
        else
            return true -- Target is valid for firing
        end
    end
    return false -- Default to not firing
end
local function FindClosestTarget(reading, currentpos, previous)
    local closest = {nil, math.huge, 0}
    for _, v in pairs(reading) do
        if not isintable(playerwhitelist, v.Name) and v.Health > 0 then
            local pos = v.Position
            local mag = (pos - currentpos).Magnitude
            local weight = (v.Health / 100 * WEIGHTS.health) + (1 - mag / far * WEIGHTS.distance)
            if v.ID == previous then weight += WEIGHTS.previous end
            if weight > closest[3] then
                closest = {v, mag, weight}
            end
        end
    end
    return closest[1]  -- Return the closest target object or nil
end
local near = 5 -- studs
local far = 200 -- studs
local function CalculateRotation(currentpos, targetpos, currentRoll)
    local direction = (targetpos - currentpos).unit * -1
    local yaw = math.deg(math.atan2(direction.x, direction.z))
    local pitch = math.deg(math.atan2(direction.y, math.sqrt(direction.x^2 + direction.z^2)))

    local adjustedRoll = currentRoll -- Placeholder for any roll adjustments

    return Vector3.new(pitch, yaw, adjustedRoll)
end
local function AimAndFireAtTarget(target)
    local currentpos = instrument:GetReading(3)
    local newpos = target.Position + (target.AssemblyLinearVelocity * 0.75)
    -- Aim adjustments for better accuracy
    newpos = newpos + Vector3.new(0, -0.5, 0) + Vector3.new(-0.5, 0, 0)
    local rot = CalculateRotation(currentpos, newpos)
    gyro:LookAtVector(newpos)

    -- Check each raycaster to decide if it's safe to fire
    local shouldFire = false
    for _, raycaster in ipairs(raycasters) do
        local result = raycaster:GetReading()
        if EvaluateRaycasterTarget(result) then
            shouldFire = true
            break
        end
    end

    -- Fire if the target is valid and not a friend
    if shouldFire and target.Health > 0 then
        switch:Configure({SwitchState = true})
        -- Additional logic for firing duration or burst firing can be added here
    else
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
    for k,v in pairs(t) do
        if type(v) == "table" then
            recursiveprint(v)
        else
            print(k,v)
        end
    end
end

function StartAiming()
    aimingCoroutine = coroutine.create(function()
        local previous = nil
        while task.wait() do -- make sure we dont murder the server
            local currentpos = instrument:GetReading(3)
            local reading = lifesensor:GetReading()
            local target = FindClosestTarget(reading, currentpos, previous)
            if target then
                AimAndFireAtTarget(target)
                previous = target.ID
            end
            coroutine.yield()  -- Yield to allow stopping
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

local methods = {
    addWhitelist = {
        reqWhitelist = true,
        func = function(plr, args)
            table.insert(playerwhitelist, args[1])
            ssd:Write("whitelist", JSONEncode(playerwhitelist))
        end
    },
    remWhitelist = {
        reqWhitelist = true,
        func = function(plr, args)
            if plr == args[1] then
                speaker:Chat("You cannot remove yourself!")
            else
                table.remove(playerwhitelist, findIndex(playerwhitelist, args[1]))
                ssd:Write("whitelist", JSONEncode(playerwhitelist))
            end
        end
    },
    start = {
        reqWhitelist = true,
        func = function(plr, args)
            StartAiming()
        end
    },
    stop = {
        reqWhitelist = true,
        func = function(plr, args)
            StopAiming()
        end
    },
    list = {
        reqWhitelist = true,
        func = function(plr, args)
            speaker:Chat("Whitelisted players:")
            for _, v in pairs(playerwhitelist) do
                speaker:Chat(v)
                task.wait(1)
            end
        end
    },
    init = {
        reqWhitelist = false,
        func = function(plr, args)
            if #playerwhitelist == 0 then
                table.insert(playerwhitelist, plr.Name)
                ssd:Write("whitelist", JSONEncode(playerwhitelist))
                speaker:Chat("You have been added to the whitelist!")
            else
                speaker:Chat("The whitelist has already been initialized!")
            end
        end
    },
}

function StopAiming()
    if aimingCoroutine then
        coroutine.close(aimingCoroutine)
        aimingCoroutine = nil
    end
    switch:Configure({SwitchState = false}) -- Make sure the turret is not firing    
end

function OnChat(plr, msg)
    if msg:sub(1, prefix:len()) == prefix then
        local args = parseArgs(msg:sub(prefix:len() + 1))
        local method = methods[args[1]]
        -- Remove the command from the args
        table.remove(args, 1)
        if method then
            if method.reqWhitelist and not isintable(playerwhitelist, plr.Name) then
                speaker:Chat("You are not whitelisted to use this command!")
            else
                method.func(plr, args)
            end
        else
            speaker:Chat("Invalid command!")
        end
    end
end
-- Does the whitelist contain anything?
if #playerwhitelist == 0 then
    speaker:Chat("No players are whitelisted! Use !t init to add yourself to the whitelist.")
end

microphone.Chatted:Connect(OnChat)

