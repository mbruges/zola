---
title: Mails down the pipe
description: "How to pipe emails from Docker Mail Server into scripts"
authors: ["Max Bruges"]
# date: 2025-01-01
draft: true
extra:
  icon: 📧
---

Want to automatically execute a script when an email is received on your Docker Mail Server? It can be done!

I lost an hour of my life trying to get this working, so I'm writing this down for posterity.

## Setting up the host
1. Write your script - start with something VERY simple to check that it executes; add complexity later. For now, let's call it `yourscript.sh`
1. Create a directory for your scripts, `path/to/mail-scripts`
1. It's worth also making a subdirectory - call it `outputs` - which can be writable from inside the container
1. Change permissions for the script: `chmod +x /path/to/mail-scripts/yourscript.sh`
1. Give docker permission to write to output: `chown -R 5000:5000 /path/to/mail-scripts/output`


## Changing Dovecot settings
Dovecot's Sieve functionality is what will be used to pipe emails to our script. This requires some editing of configs, which need to be written on the host machine and then mounted by the container (so that the changes aren't lost when rebooting the container).

1. Go to the `docker-data/dms/config` directory on your host.
1. Decide which email address you want to pipe emails from (creating a new account if necessary)
1. Make a new file in `config`, with a filename of the email address + `.dovecot.sieve`. E.g: `youruser@example.com.dovecot.sieve`
1. In the file, add these two lines and save:
```
require ["vnd.dovecot.pipe"];
pipe "yourscript.sh"
```
1. This tells the mail server to pipe ALL messages to the given script. If you want to limit which messages are sent, check out this guide.
1. Finally, edit your `compose.yml` and under `volumes`, add the following line:
`- path/to/mail-scripts/:/usr/lib/dovecot/sieve-pipe/`. This will mount the scripts (and output) directory.
1. Stop the container and restart it.
1. Send a test email to see if it works! 

If things *don't* work, use `docker logs <containername>` to see where things are going wrong. It's usually permissions of some sort.
