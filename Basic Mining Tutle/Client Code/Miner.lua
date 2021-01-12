-- Bassic Miner v1.2.0

local isMiningVariablesLoaded = require("Mining_Variables")
local isConfigLoaded = require("config")

local levels, area = ...
local levelsToMine = tonumber(levels)
local areaToMine = tonumber(area)

if isConfigLoaded then
    fuelSource = selected_fuel
end

-- Start of the program
function MineHole()
    print("Starting Robot...")
    local fuelNeeded = CalculateFuel()
    if fuelNeeded ~= 0 then
        ConsumeFuel(fuelNeeded)
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
    local fuelNeeded = 0
    if turtle.getFuelLevel() > steps then
        print("No Additional Fuel Needed.")
    else
        if selected_fuel == FuelSources.Coal then
            fuelNeeded = math.ceil((steps - currentFuelLevel) / 80)
        elseif selected_fuel == FuelSources.Charcoal then
            fuelNeeded = math.ceil((steps - currentFuelLevel) / 80)
        elseif selected_fuel == FuelSources.CoalBlocks then
            fuelNeeded = math.ceil((steps - currentFuelLevel) / 720)
        elseif selected_fuel == FuelSources.Lava then
            fuelNeeded = math.ceil((steps - currentFuelLevel) / 1000)
        end
    end
    return fuelNeeded
end

-- Looks into the given turtle's inventory to find and consume the selected fuel source. 
function ConsumeFuel(fuelNeeded) 
    if fuelSource == FuelSources.Lava then
        for i = 0, fuelNeeded, 1 do
            os.sleep(2)
            if turtle.detectUp() then
                turtle.suckUp()
            else
                error("Error: No Enderchest Detected For Fueling.")
            end
            if GetItemIndex("minecraft:lava_bucket") ~= 0 and turtle.select(GetItemIndex("minecraft:lava_bucket")) then
                turtle.refuel()
                turtle.dropUp()
            else
                error("Error: There was a problem finding fuel for turtle.")
                if GetItemIndex("minecraft:bucket") ~= 0 and turtle.select(GetItemIndex("minecraft:bucket")) then
                    turtle.dropUp()
                end
            end
        end
    elseif fuelSource == FuelSources.Coal then
        if GetItemIndex("minecraft:coal") ~= 0 and turtle.select(GetItemIndex("minecraft:coal")) then
            turtle.select(GetItemIndex("minecraft:coal"))
            turtle.refuel(fuelNeeded)
        else
            error("Error: No coal detected in invenetory.")
        end
    elseif fuelSource == FuelSources.Charcoal then
        if GetItemIndex("minecraft:charcoal") ~= 0 and turtle.select(GetItemIndex("minecraft:charcoal")) then
            turtle.select(GetItemIndex("minecraft:charcoal"))
            turtle.refuel(fuelNeeded)
        else
            error("Error: No charcoal detected in invenetory.")
        end
    elseif fuelSource == FuelSources.CoalBlocks then
        if GetItemIndex("minecraft:coal_block") ~= 0 and turtle.select(GetItemIndex("minecraft:coal_block")) then
            turtle.select(GetItemIndex("minecraft:coal_block"))
            turtle.refuel(fuelNeeded)
        else
            error("Error: No coal blocks detected in invenetory.")
        end
    end
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
