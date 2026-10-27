# 03 - Users, Groups, and OUs

## Goal
Model a small company: departments as OUs, employees as users, and access through security groups.

## Structure
```
lab.locals
├── Sales
├── HR
└── IT
```

## Steps I took
1. Created OUs: Sales, HR, IT.
2. Created users (manually first, then with the script in `scripts/`).
3. Filled in attributes: title, department, phone, email, manager.
4. Created security groups: `Sales-Team`, `HR-Team`, `IT-Admins`.
5. Added users to groups.

## Everyday tasks I practiced
- [x] Reset a user's password
- [ ] Unlock a locked-out account
- [ ] Disable an account (employee leaves)
- [ ] Move a user to a different OU
- [ ] Add/remove a user from a group

## Why groups, not individual permissions
Permissions are assigned to a group instead of to each person, so when someone changes roles I only change their group membership instead of editing access on every folder. It’s also much faster and less error-prone to update one group than 20 different folders.
It also makes access easy to audit, since I can look at a group’s member list to see exactly who has access.

## Help desk tickets

### Ticket: Password reset
- **Request:** User cannot log in; forgot password.
- **Steps:** ADUC > Sales OU > right-click user > Reset Password > temp password, "must change at next logon" ticked.
- **Result:** Account accessible with temp password; user prompted to set a new one.
- **Notes:** Verify identity before resetting. Never send passwords by email.

### Ticket: Disable and re-enable an account
- **Request:** Employee left the company (or account suspected compromised).
- **Steps:** ADUC > right-click user > Disable Account; confirmed the disabled icon. Later, right-click > Enable Account.
- **Result:** User cannot log in while disabled; access restored after re-enabling.
- **Notes:** Disable instead of deleting so files and settings can be recovered.

### Ticket: Move a user to another OU
- **Request:** Employee transferred from Sales to HR.
- **Steps:** ADUC > right-click user > Move... > HR. Checked the Member Of tab before and after.
- **Result:** User now appears under HR; Sales-Team membership did not change.
- **Notes:** Moving a user changes which OU policies apply, but not group access. A real transfer also needs group membership updated.

## Screenshots
- ![OU structure](../images/screenshots/03-ou-structure.png)
- ![User attributes](../images/screenshots/03-user-attributes.png)
