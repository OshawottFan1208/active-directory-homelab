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

### Template for new entries
### N. Short title of the problem
- **Symptom:**
- **Cause:**
- **Fix:**
- **Takeaway:**
