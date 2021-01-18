-- removes old version of Miner and downloads newest version

local pastebin_link_miner = "jj6HhgXf"
local pastebin_link_config = "1NrvE6WR"
local pastebin_link_variables = "1V3t6Sua"

print("Removing old scripts...")
shell.run("rm", "miner")
shell.run("rm", "config")
shell.run("rm", "variables")

print("Scripts Removed. \nInstalling Updated Scripts...")
shell.run("pastebin", "get " .. pastebin_link_miner .. " miner")
shell.run("pastebin", "get " .. pastebin_link_config .. " config")
shell.run("pastebin", "get " .. pastebin_link_variables .. " variables")
print("Updates Complete.")
print("----------------------")