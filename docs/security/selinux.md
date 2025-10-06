# SELinux Documentation for RHEL

**SELinux (Security-Enhanced Linux)** is a mandatory access control (MAC) system integrated into RHEL. It provides fine-grained security policies for processes, users, and files, beyond standard Linux permissions.

---

## 1. SELinux Modes

SELinux can operate in three modes:

| Mode           | Description                        
| -------------- | ----------------------------------------------------------------------------- |
| **Enforcing**  | SELinux enforces policies. Access denials are logged and blocked.             |
| **Permissive** | SELinux logs policy violations but does not block access. Useful for testing. |
| **Disabled**   | SELinux is completely turned off.  

**Check current mode:**

```bash
getenforce
```

**Check detailed SELinux status:**

```bash
sestatus
```

**Change mode temporarily (no reboot needed):**

```bash
sudo setenforce 0   # Permissive
sudo setenforce 1   # Enforcing
```

**Change mode permanently:**
Edit `/etc/selinux/config`:

```bash
SELINUX=enforcing   # Options: enforcing, permissive, disabled
```

---

## 2. SELinux Contexts

Every file, directory, and process has an SELinux context, defined as:

```
user:role:type:level
```

* **user:** SELinux user identity
* **role:** Role associated with user
* **type (domain):** Primary control element; most access decisions use type
* **level:** MLS/MCS security level (mostly used in multi-level security systems)

**View file context:**

```bash
ls -Z /path/to/file
```

**View process context:**

```bash
ps -eZ | grep <process>
```

---

## 3. Common SELinux File Types

SELinux relies heavily on **types** to control access. Some common types:

| Type                     | Description                 |
| ------------------------ | --------------------------- |
| `httpd_sys_content_t`    | Web server static content   |
| `httpd_sys_rw_content_t` | Web server writable content |
| `var_log_t`              | Log files                   |
| `tmp_t`                  | Temporary files             |
| `user_home_t`            | User home directories       |

**Change a file’s context:**

```bash
sudo chcon -t <type> /path/to/file
```

**Restore default context:**

```bash
sudo restorecon -Rv /path/to/file_or_dir
```
**Set context permanently using `semanage fcontext`:**

```bash
sudo semanage fcontext -a -t <type> '/path/to/file_or_dir(/.*)?'
sudo restorecon -Rv /path/to/file_or_dir
```

* `-a`: Add a new file context mapping
* `-t <type>`: Specify the SELinux type
* `'/path/to/file_or_dir(/.*)?'`: Regular expression for the path and its contents

**View all custom file contexts:**

```bash
semanage fcontext -l
```
---

## 4. Booleans

SELinux has **booleans** to allow specific actions without changing policies.

**List all SELinux booleans:**

```bash
getsebool -a
```

**Enable or disable a boolean temporarily:**

```bash
sudo setsebool httpd_can_network_connect on
```

**Make boolean change permanent:**

```bash
sudo setsebool -P httpd_can_network_connect on
```

---

## 5. Troubleshooting

### a) Audit Logs

SELinux denials are logged in `/var/log/audit/audit.log`. Use `ausearch` or `audit2allow` to analyze:

```bash
sudo ausearch -m avc -ts today
sudo ausearch -m avc -ts today | audit2allow -m mymodule
```

### b) Troubleshoot Denials

1. Temporarily set permissive mode to test:

```bash
sudo setenforce 0
```

2. Review the denial logs.
3. Create a policy module if needed:

```bash
sudo audit2allow -M mymodule < /var/log/audit/audit.log
sudo semodule -i mymodule.pp
```

---

## 6. Best Practices

* Keep SELinux in **Enforcing** mode on production servers.
* Use `restorecon` rather than `chcon` for persistent changes.
* Use `semanage fcontext` for permanent file context changes.
* Use booleans instead of modifying policies whenever possible.
* Regularly monitor `/var/log/audit/audit.log` for unexpected denials.
* Test new applications in **Permissive** mode before moving to Enforcing.

---

## 7. Useful SELinux Commands

| Command                                 | Description                                       |
| --------------------------------------- | ------------------------------------------------- |
| `getenforce`                            | Show current mode (Enforcing/Permissive/Disabled) |
| `sestatus`                              | Detailed SELinux status                           |
| `setenforce 0`                          | Temporarily set permissive/enforcing mode         |
| `ls -Z`                                 | Show file contexts                                |
| `ps -eZ`                                | Show process contexts                             |
| `restorecon -Rv <path>`                 | Restore default context                           |
| `chcon -t <type> <file>`                | Change file context temporarily                   |
| `semanage fcontext -a -t <type> <file>` | Add a permanent file context mapping              |
| `semanage fcontext -l`                  | List all custom file contexts                     |
| `getsebool -a`                          | List all SELinux booleans                         |
| `setsebool -P <boolean> on `            | Permanently enable/disable a boolean              |
| `audit2allow`                           | Generate SELinux policy from audit logs           |

---
