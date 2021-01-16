-- Client Updater v1.1 --

local pastebin_link = "nvEURPTq"

shell.run("rm", "miner")
print("Client code Removed. \nDownloading Newest Edition.")
shell.run("pastebin", "get " .. pastebin_link .. " miner")
print("Update Complete.")
print("-------------------------")
shell.run("motd")