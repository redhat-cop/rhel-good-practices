# Troubleshooting long boot time 
Here is a tip for when you have a (RHEL 8 or later) system which takes a surprising amount of time to boot.
Boot time of a system can be a good general indicator that something may be wrong with the system, and may be something which you want to monitor in general of for specific services.

## Practice
Use systemd-analyze to get detailed timing information from the last boot.

For example:

* Get an overview of how long it took for a system to boot, also time split between kernel, initrd and userspace:
```
# systemd-analyze
```

Example output:
```
# systemd-analyze
Startup finished in 817ms (kernel) + 1.943s (initrd) + 2.978s (userspace) = 5.738s 
multi-user.target reached after 2.421s in userspace.
```

* Get a sorted list of what contributed most to a long boot process:
```
# systemd-analyze blame
```

Example output:
```
# systemd-analyze blame

67.100s badly-written.service
2.217s dev-ttyS2.device
2.217s sys-devices-platform-serial8250-serial8250:0-serial8250:0.2-tty-ttyS2.device
2.210s sys-devices-platform-serial8250-serial8250:0-serial8250:0.1-tty-ttyS1.device
2.210s dev-ttyS1.device
2.207s dev-ttyS3.device
2.207s sys-devices-platform-serial8250-serial8250:0-serial8250:0.3-tty-ttyS3.device
2.205s dev-ttyS0.device
[ ... removed ... ]
  14ms dracut-mount.service
  12ms modprobe@fuse.service
  12ms systemd-user-sessions.service
  12ms dracut-pre-mount.service
  12ms systemd-fsck-root.service
  11ms initrd-udevadm-cleanup-db.service
   8ms sys-fs-fuse-connections.mount
   4ms modprobe@configfs.service
```

For more systemd-analyze tricks, have a look at the SYSTEMD-ANALYZE(1) man page on your system.

