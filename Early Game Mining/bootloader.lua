-- Mining Turtle Bootloader --

local pastebin_link = "bCUHjxDt"

shell.run("clear")
print("Updating Client Launcher")
shell.run("rm", "updater")
shell.run("pastebin", "get " .. pastebin_link .. " updater")
print("Launcher Updated.")
print("Checking For Updates...")
shell.run("updater")