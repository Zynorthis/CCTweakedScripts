-- removes old version of GPS Startup script and downloads newest version

print("Removing old script.")
shell.run("rm", "startup")
print("Downloading Newest Edition.")
shell.run("pastebin", "get jj6HhgXf startup")
shell.run("move", "startup rom/startup")
print("Update Complete.")