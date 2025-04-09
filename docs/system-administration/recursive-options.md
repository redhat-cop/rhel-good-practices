# When using recursive options in a command
When you use recursive options for commands, there is always a small risk that you accidentally affect a larger scope than you meant. Such as accidentally changing the permissions or ownership of every single file on a system.

An example of a difficult-to-fix-mistake:
```
chown -R myuser:mygroup /
````

By adding the recursive option at the end of the command, you reduce the risk of ending up in this situation.

## Practice
When using an recursing option for a command, add the recursive options in the end, as such:

```
# chmod 0700 /the/path/ends/here -R
# chown myuser:mygroup /the/path/ends/here -R
```

If you accidentally press enter before the full correct path is typed, you will now not make an erronous change recursively, instead you would only affect one folder or file.

Make it a practice that you look through the path or command an extra time before you add the recursive option.
