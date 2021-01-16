-- Bassic Miner (Early Game Edition) v0.7 --

local levels, area = ...
local levelsToMine = tonumber(levels)
local areaToMine = tonumber(area)

function Mine()
    print("Starting Turtle...")
    local fuelNeeded = CalculateFuel()
    if fuelNeeded ~= nil and fuelNeeded ~= 0 then
        ConsumeFuel(fuelNeeded)
    end

    local depth = 0 
    while depth < levelsToMine do
        MineLevel()
        if ((areaToMine % 2) == 0) then
            turtle.turnLeft()
        else
            turtle.turnLeft()
            turtle.turnLeft()
        end
        depth = depth + 1
        if depth < levelsToMine then
            turtle.digDown()
            turtle.down()
        end
    end

    print("Returning To Surface...")
    local movementsUntilSurface = 0
    while movementsUntilSurface < levelsToMine do
        ReturnToSurface()
        movementsUntilSurface = movementsUntilSurface + 1
    end
    turtle.back()
    DepositItems()
    print("Mining Complete.")
end

function CalculateFuel()
    local steps = (levelsToMine * areaToMine  * areaToMine) + levelsToMine
    local currentFuelLevel = turtle.getFuelLevel()
    print(string.format("Total Steps Needed: %d", steps))
    print(string.format("Current Fuel Level: %d", currentFuelLevel))
    local fuelNeeded = 0
    if turtle.getFuelLevel() > steps then
        print("No Additional Fuel Needed.")
    else
        fuelNeeded = math.ceil((steps - currentFuelLevel) / 80)
    end
    if fuelNeeded > (80 * 64) then
        error("Error: To Many Steps Needed, Not Enough Fuel To Consume.")
    end
    return fuelNeeded
end

function ConsumeFuel(fuelNeeded) 
    if GetItemIndex("minecraft:coal") ~= 0 and turtle.select(GetItemIndex("minecraft:coal")) then
        turtle.select(GetItemIndex("minecraft:coal"))
        turtle.refuel(fuelNeeded)
    else
        error("Error: No coal detected in invenetory.")
    end
end

function MineLevel()
    local directionToTurn = true

    for rowsCompleted = 1, areaToMine, 1 do
        for stepsForward = 1, areaToMine - 1, 1 do
            DigAndMove()
            if CheckInventoryLevel() then
                DepositItems()
            end
        end
        if rowsCompleted ~= areaToMine then 
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

        for i = 1, 16, 1 do
            turtle.select(i)
            turtle.dropUp()
        end
        turtle.select(1)
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

Mine()