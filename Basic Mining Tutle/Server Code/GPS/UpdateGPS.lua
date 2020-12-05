-- removes old version of GPS Startup script and downloads newest version

print("Removing old script.")
shell.run("rm", "startup")
print("Downloading Newest Edition.")
shell.run("pastebin", "get C5pvDxwS startup")
print("Update Complete.")