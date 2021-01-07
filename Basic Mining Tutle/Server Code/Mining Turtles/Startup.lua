-- Startup Script for Mining Turtle Server Code

local arg1, arg2, arg3 = ...
local TotalAreaToMine_X = tonumber(arg1)
local TotalAreaToMine_Y = tonumber(arg2)
local TurtleSegmentation = tonumber(arg3)

print("Starting Server...")

local numberOfTurtles = 0
for i = 1, 16, 1 do
    if turtle.getItemCount() > 0 then
        if turtle.getItemDetail(i).name == "" then
            numberOfTurtles = numberOfTurtles + 1
        end
    end
end
print(string.format("Number of turtles found: %d", numberOfTurtles))

local isFuelChestInInventory = false
for i = 1, 16, 1 do
    if turtle.getItemCount() > 0 then
        if turtle.getItemDetail(i).name == "enderstorage:ender_storage" then
            isFuelChestInInventory = true
        end
    end
end
print(string.format("Ender Chest For Fuel: %d", isFuelChestInInventory))

print("Mining Turtle Server Started.")

function DeployTurtles()

end

-- Takes the total area to mine and finds total area for turtles
-- to mine.
-- Returns: Number, Number (X, Y)
function CalculateTurtleSegmentation()

    return 1, 1
end

-- Now that the server has started successfully,
-- open modem to the rednet
if rednet.isOpen ~= true then
    peripheral.find("modem", rednet.open)
end

while true do
    number, message, protocol = rednet.receive()
    if message == "" then
        CalculateTurtleSegmentation()
        
    end
end