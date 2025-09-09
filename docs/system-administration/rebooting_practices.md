# Rebooting a system

To prevent unplanned downtime, it's crucial to take specific precautions before initiating a reboot.
The method followed to reboot a system can significantly impact whether the process is successful.


---

## Practice

Considerations before rebooting a system.

**1. Active Users**
- Use the `who` or `w` commands to see a list of logged-in users.
- Send a message to all logged in users, warning them of the impending reboot.
     ```bash
     wall "This system will be rebooted by the Ops team at 13:00 today"
     ```

**2. Open Files**
- Confirm that all important files have been saved and that no processes are writing data to the disk.
- Force all data in the buffer to be written to the disk.
     ```bash
     sync
     ```

**3. Mounted filesystems**
- List all currently mounted filesystems.
     ```bash
     mount
     ```
- Verify that all currently mounted filesystems.
     ```bash
     mount -a
     ```

  **4. Scheduled jobs**
- List currently scheduled jobs. Rebooting in the middle of a backup or maintenance job can result in an incomplete state.
     ```bash
     crontab -l
     ```
