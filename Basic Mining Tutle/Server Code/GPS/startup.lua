-- GPS Server Startup script

shell.run("clear")
print("Starting GPS Server...")
local x = 0
local y = 0
local z = 0
print("Server Started.")
shell.run("gps", "host", x, y, z)