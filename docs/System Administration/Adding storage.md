# When you have added new persistent storage to a system
When you have added new persistent storage definitions to /etc/fstab on your system. A good practice is to see if those definitions works, before you reboot your system.
Doing that prevents getting stuck in a situation where your system does not boot up, due to faulty /etc/fstab definitions.

## Practice
After having added a new definition to /etc/fstab test it by running:

```
# mount -a
```

If your definitions are without issues, the command with exit without any output, as such:

```
# mount -a
#
```

If there are issues which the system will encounter doing boot, you will find those issues before rebooting it, allowing you to fix the issues before the system is rebooted.
