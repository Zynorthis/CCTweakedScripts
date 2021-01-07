-- Boot Loader Code

shell.delete("Updater")
shell.copy("disk/Updater", "Updater")
shell.run("Updater")