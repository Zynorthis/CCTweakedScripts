-- Snad Farm --

-- continually pulses redstone signals out of the front of the given computer
while true do
    rs.setOutput("front")
    os.sleep(0.1)
    rs.getOutput("front")
    os.sleep(0.1)
end