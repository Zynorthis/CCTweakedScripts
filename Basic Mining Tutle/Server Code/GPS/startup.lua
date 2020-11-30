-- GPS Server Startup script

print("Starting GPS Server...")
local x = 0
local y = 0
local z = 0
shell.run("gps", "host", x, y, z)
print("Server Started.")