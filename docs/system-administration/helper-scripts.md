# Introducing helper scripts to make your life easier

Working in the terminal often means typing long commands with many options and parameters. While powerful, this can become repetitive and error-prone, that’s where **helper scripts** come in.

A helper script can be even a very short Bash script that wraps long commands or sets of commands, with relevant tags an parameters, and make it available in a more meaningful and short name.

A perfect example is an `rsync` backup command, that can be easily trimmed down into a simple, reusable script.

---

## 1. The problem

A typical `rsync` command for backups might look like this:

```bash
rsync -avh --progress --delete --exclude='.cache' --exclude='*.tmp' /home/user/ /mnt/backup/home_user/
```

While this is something we could already be used to, have it in the history, it could still be handy to have something simpler and immediate in our pocket.

We can then start drafting our first helper script.

---

## 2. Creating a helper script

We will start with a very basic version of the script, very useful when we have a fixed or non-frequent changed set of parameters.

Start by opening a new file:

```bash
vi ~/backup
```

Add the following script in it:

```bash
#!/bin/bash
# backup.sh - helper script for rsync backups

# Parameter for the source folder
SOURCE="/home/user/"
# Parameter for the destination folder
DEST="/mnt/backup/home_user/"

# Run rsync with the following options:
# -a : archive mode (preserves permissions, symlinks, etc.)
# -v : verbose
# -h : human-readable numbers
# --progress : show progress during transfer
# --delete : remove files on the destination that no longer exist in the source
# --exclude : skip certain files/folders

rsync -avh --progress --delete \
  --exclude='.cache' \
  --exclude='*.tmp' \
  "$SOURCE" "$DEST"
```

You can recognize it is the same command we showed before, but we are starting to make it a bit more dynamic, the only changing part are the folders, but they are now hardcoded in the script itself. This could be the use case when a recurring backup is performed.

You can now make it executable:

```bash
chmod +x backup-home
```

And test it by just invoking it:

```bash
./backup-home
```

---

## 3. Adding Parameters for Flexibility

Now that we have our first version of the helper script, you might want to back up different directories or specify a destination.

Let's update the script to introduce dynamic arguments to populate parameters:

```bash
#!/bin/bash
# backup.sh - flexible rsync backup helper

# A simple help to show the order of arguments when no arguments are provided.

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <source_dir> <destination_dir>"
  exit 1
fi

# Parameter for the source folder
SOURCE="$1"
# Parameter for the destination folder
DEST="$2"

rsync -avh --progress --delete \
  --exclude='.cache' \
  --exclude='*.tmp' \
  "$SOURCE" "$DEST"
```

And now you are ready to test it with any folder:

```bash
backup.sh /home/user/ /mnt/backup/home_user/
backup.sh /var/www/ /mnt/backup/websites/
```

---

## 4. Make it available system-wide

Now that we have the script in place, we can also make it available system-wide, so we can use it like any other general purpose CLI tools available to all users.

To do so, it is enough to move it to the `/usr/local/bin` folder.

```bash
sudo mv backup /usr/local/bin
```

You will now be able to use it in cron schedules, directly from the CLI or embed it in other automations that you have running in your system.
