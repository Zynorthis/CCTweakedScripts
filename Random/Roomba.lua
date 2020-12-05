-- Turns your turtle into a replica of a roomba

local needsToCharge = false

-- location of the charging station
local chargingStation_x = 0
local chargingStation_y = 0
local chargingStation_z = 0

print(string.format("Charging Station Set At: %d, %d, %d", chargingStation_x, chargingStation_y, chargingStation_z))

local currentLocation = gps.locate 