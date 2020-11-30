-- Startup Script for Mining Turtle Server Code
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