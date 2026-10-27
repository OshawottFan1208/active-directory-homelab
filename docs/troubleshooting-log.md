# Troubleshooting Log

Each entry is written like a help desk ticket: symptom, cause, fix, takeaway.

---

### 1. Windows Setup: "There is an error selecting this partition for install"
- **Symptom:** Windows Server setup would not let me install to the virtual disk.
- **Cause:** A leftover partition from an earlier interrupted install attempt.
- **Fix:** Deleted the existing partition so the disk showed as one block of unallocated space, then clicked Next.
- **Takeaway:** After a cancelled install, clear old partitions before retrying.

---

### 2. VM: "The virtual machine failed to boot"
- **Symptom:** After shutting down mid-install, the VM reported no bootable OS.
- **Cause:** The disk was still empty, and the ISO was not set to boot first or the "press any key" prompt was missed.
- **Fix:** Checked Settings > Storage (ISO attached), Settings > System > Boot Order (Optical first), then pressed a key at the boot prompt.
- **Takeaway:** Check the boot order and attached media first when a VM will not boot.

---

### 3. VM: "Request failed to Load Users"

- **Symptom:** The script reported sucesss, but "server is unwilling to process the request" errors appeared and no users existed
- **Cause:** The domain was named lab.locals(a typo at promotion), but the script assumed lab.locals
- **Fix:** Confirmed the real domain with Get-ADDomain, and rewrote the script to read the domain from AD and report real errors
- **Takeaway:** Verify test results rather than trusting a success message, and avoid hard coding enviornment values

---

### Template for new entries
### N. Short title of the problem
- **Symptom:**
- **Cause:**
- **Fix:**
- **Takeaway:**
