# Rebooting a system

To prevent unplanned downtime, it's crucial to take specific precautions before initiating a reboot.
The method followed to reboot a system can significantly impact whether the process is successful.

---

## Practice

Considerations before rebooting a system.

**1. Active Users**

Minimise disruption for logged in users by notifying them about the reboot.
- Use the `who` or `w` commands to see a list of logged-in users.
- Send a message to all logged in users, warning them of the impending reboot.
     ```bash
     wall "This system will be rebooted by the Ops team at 13:00 today"
     ```


**2. Open Files**

Confirm that all important files have been saved and that no processes are writing data to the disk.
- Force all data in the buffer to be written to the disk.
     ```bash
     sync
     ```


**3. Mounted filesystems**

Mount failures at boot time can prevent the system from fully booting up.
Check that all mounts can be mounted successfully before rebooting the system.

- List all currently mounted filesystems.
     ```bash
     mount
     ```
- Verify that all mounts in `/etc/fstab` can be mounted successfully.
     ```bash
     mount -a
     ```


**4. Scheduled jobs**

Rebooting in the middle of a backup or maintenance job can result in an incomplete state.
Check the scheduling of jobs and schedule the reboot accordingly.

- List currently scheduled jobs. 
     ```bash
     crontab -l
     ```

**5. Checking Filesystems**

Rebooting with a full /var filesystem has historically caused problems with servers coming back up.
Check your filesystem space and act accordingly.

- List currently scheduled jobs. 
     ```bash
     df -h
     ```