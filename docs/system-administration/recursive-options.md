# When using recursive options in a command
Have you ever typed a command and hit enter before you meant to? That happens to us all, and if the command runs recursively in some way, that can have far reaching effects for your system.

Classical examples of a difficult-to-fix mistake:
```
chown -R myuser:mygroup /
rm -rf /home
````

## Practice
When using an recursing option for a command, add the recursive options in the end, as such:

```
# chmod 0700 /the/path/ends/here -R
# chown myuser:mygroup /the/path/ends/here -R
# rm /home/myself/garbage -rf
```

When entering the recursive option last, that allows you to double check if any paths are correct, before you add the recursive option - and fire off your command.
If you accidentally press enter before the full correct path is typed, the effect of the command is not recursive - meaning your mistake causes less damage.

