-- Turns your turtle into a replica of a roomba

local needsToCharge = false

-- location of the charging station
local chargingStation_x = 0
local chargingStation_y = 0
local chargingStation_z = 0

print(string.format("Charging Station Set At: %d, %d, %d", chargingStation_x, chargingStation_y, chargingStation_z))

local currentLocation_x, currentLocation_y, currentLocation_z = 0, 0, 0

-- Moves around room and picks up items
-- Returns: Void
function SweepFloor()
    -- get inital charge from charging station
    
    -- sweep floor

end

-- Moves roobma to charging station and recharges
-- Returns: Void
function Recharge()
    -- get current location
    GetCurrentLocation()

    -- move to charging station

    -- recharge turtle
    if (turtle.detectDown()) then
        local emptyInventorySlots = CountEmptyInventorySlots()
        if ((emptyInventorySlots <= 0) or (emptyInventorySlots == nil)) then
            error("Error: Can not recharge due to fill inventory.")
        end
        
        -- get lava buckets out of chest
        for i = 1, emptyInventorySlots, 1 do
            turtle.suckDown()
        end
        

        for i = 1, 16, 1 do
            turtle.select(i)
            if turtle.getItemCount() > 0 then
                if turtle.getItemDetail(i).name == "minecraft:lava_bucket" then
                    turtle.refuel()
                    turtle.placeDown()
                end
            end
        end
    end
end

-- Checks every inventory slot to see if it is empty
-- Returns: Number of empty inventory slots
function CountEmptyInventorySlots()
    local emptyInventorySlots = 0
    for i = 1, 16, 1 do
        turtle.select(i)
        if turtle.getItemCount() == 0 then
            emptyInventorySlots = emptyInventorySlots + 1
        end
    end
    return emptyInventorySlots
end

-- Gets and sets the current position of the turtle
-- Returns: True if the position was correctly found
function GetCurrentLocation()
    currentLocation_x, currentLocation_y, currentLocation_z = gps.locate()
    if ((currentLocation_x ~= nil) and 
        (currentLocation_y ~= nil) and 
        (currentLocation_z ~= nil)) then
        return true
    else
        return false
    end
end