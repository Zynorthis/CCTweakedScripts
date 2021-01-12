-- Mining Turtle Bootloader --

local pastebin_link = ""

shell.run("clear")
print("Updating Client Launcher")
shell.run("rm", "updater")
shell.run("pastebin", string.format("get %d miner", pastebin_link))
print("Launcher Updated.")
print("Checking For Updates...")
shell.run("updater")