-- Bassic Miner v0.20

local arg1, arg2 = ...
local levelsToMine = tonumber(arg1)
local areaToMine = tonumber(arg2)

-- Start of the program
function MineHole()
    print("Starting Robot...")
    local fuelNeeded = CalculateFuel()
    if fuelNeeded ~= 0 then
        if turtle.select(GetItemIndex("minecraft:coal")) then
            if turtle.getItemCount() < fuelNeeded then
                error("Error: Not enough fuel provided for full execution.")
                return
            else
                print(string.format("Consuming Fuel Needed: %d", fuelNeeded))
                turtle.refuel(fuelNeeded)
            end
        else
            error("Error: No coal detected in turtle inventory.")
        end
    end

    local depth = 1 
    while depth <= levelsToMine do
        MineLevel()
        if depth < levelsToMine + 1 then
            turtle.digDown()
            turtle.down()
        end
        if ((areaToMine % 2) == 0) then
            turtle.turnLeft()
            turtle.turnLeft()
        else
            turtle.turnLeft()
        end
        depth = depth + 1
    end

    print("Returning To Surface...")
    local movementsUntilSurface = 1
    while movementsUntilSurface <= levelsToMine + 1 do
        ReturnToSurface()
        movementsUntilSurface = movementsUntilSurface + 1
    end
    DepositItems()
    print("Mining Complete.")
end

-- calulates how much coal needs to be consumed based on how many moves the turtle will need to do.
function CalculateFuel()
    local steps = (levelsToMine * (areaToMine + 1 ) * (areaToMine + 1)) + levelsToMine
    local currentFuelLevel = turtle.getFuelLevel()
    print(string.format("Total Steps Needed: %d", steps))
    print(string.format("Current Fuel Level: %d", currentFuelLevel))
    local coalNeeded = 0
    if turtle.getFuelLevel() > steps then
        print("No Additional Fuel Needed.")
    else
        coalNeeded = math.ceil((steps - currentFuelLevel) / 80)
    end
    return coalNeeded
end

-- This will mine an square equal to the area specified.
function MineLevel()
    local stepsForward = 1
    local rowsCompleted = 1
    local directionToTurn = true

    for rowsCompleted = 1, areaToMine + 1, 1 do
        for stepsForward = 1, areaToMine, 1 do
            DigAndMove()
            if CheckInventoryLevel() then
                DepositItems()
            end
        end
        if rowsCompleted ~= areaToMine + 1 then 
            if directionToTurn then
                turtle.turnLeft()
                DigAndMove()
                turtle.turnLeft()
                directionToTurn = false
            else
                turtle.turnRight()
                DigAndMove()
                turtle.turnRight()
                directionToTurn = true
            end
        end
    end
end

-- Digs everything in front of it then moves one square forward.
function DigAndMove()
    while turtle.detect() do
        turtle.dig()
    end
    turtle.forward()
end

function ReturnToSurface()
    while turtle.detectUp() do
        turtle.digUp()
    end
    turtle.up()
end


function DepositItems()
    -- Select and Place ender chest
    local chestLocation = GetItemIndex("enderstorage:ender_storage")
    if chestLocation ~= 0 then
        turtle.select(chestLocation)
        if turtle.detectUp() then
            turtle.digUp()
        end
        turtle.placeUp()

        -- We start at inventory spot 2 because 1 will always have fuel in it
        for i = 2, 16, 1 do
            turtle.select(i)
            turtle.dropUp()
        end
        turtle.digUp()
    else
        warn("WARNING: No ender chest detected. Items will soon start to spill onto the ground!")
    end
end

-- Checks inventory levels
function CheckInventoryLevel()
    -- We start at 3 because 1 has fuel and 2 will have the enderchest
    local isInventoryFull = true
    for i = 3, 16, 1 do
        if turtle.getItemCount(i) == 0 then
            isInventoryFull = false
        end
    end
    return isInventoryFull
end

-- Find the index of a specified item
function GetItemIndex(itemName)
    local index = 0
    for i = 1, 16, 1 do
        turtle.select(i)
        if turtle.getItemCount() > 0 then
            if turtle.getItemDetail(i).name == itemName then
                index = i
                break
            end
        end
    end
    return index
end

MineHole()
