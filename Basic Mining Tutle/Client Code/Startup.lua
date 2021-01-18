-- Startup Script For Mining Turtles

local pastebin_link_updater = "4rMM5Jfg"

shell.run("clear")
print("Updating Client Launcher")
shell.run("rm", "updater")
shell.run("pastebin", "get " .. pastebin_link_updater .. " updater")
print("Launcher Updated. \nChecking For Updates...")
shell.run("updater")

