-- Boot Loader Code

shell.delete("client")
shell.copy("disk/client", "client")
shell.run("client")