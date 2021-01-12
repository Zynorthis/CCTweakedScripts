-- Client Updater

local pastebin_link = ""

shell.run("rm", "miner")
print("Client code Removed. \nDownloading Newest Edition.")
shell.run("pastebin", string.format("get %d miner", pastebin_link))
print("Update Complete.")
print("-------------------------")
shell.run("motd")