# Asking the RPM database what's changed

RPM maintains a database that lists not only the packages that are installed on a system, but also which files were installed from those packages, including checksums and timestamps for those files. This can be used to analyse the system.

You might find yourself in situations were you inherit a system with little or even no documentation at all, maybe even without a handover. This command can be a starting point for an analysis of the system to figure out what was configured.

```
rpm -Va
```

It might take a moment and on mature systems you'll get a lot of output. A good place to start is to look at changes under ` /etc`:

```
rpm -Va | grep ' /etc'
```

RPM will report all kinds of changes. It will give you an indication of what was changed to help you get started.

The output can be broken down into three sections. On the right you'll find the file in question. On the left you get an indication of what kind of change RPM found. In the middle you get an indication of what RPM considers this file to be.

Consider this output:

```
.M.......  c /etc/crypttab
```

Here, the `M` indicates that the *mode* of the file differs from the state in which RPM initially created the file. This can mean that the file type or permissions changed.

An `S` would indicate a changed file size. Something was added or removed from the file. A `5` would indicate a changed checksum (5 because the hash algorithm used for checksumming used to be md5). A `T` would indicate that the file now has a different modification time than it should have. You'll often find these three together like this:

```
S.5....T.  c /etc/dnf/dnf.conf
```

Missing files are reported like this:

```
missing     /etc/crontab
```



The `c` in the second column indicates that RPM considers this file to be a config file. This is the most common file class you'll find under `/etc`.



## further reading

Take a look at `man 8 rpm` and the `VERIFY OPTIONS` section for more details.



## special use case: diagnosing a possibly compromised system

Another possible use case for this could be when you suspect that a system might have been compromised.

…


