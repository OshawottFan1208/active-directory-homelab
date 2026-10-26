# 05 - File Shares and Permissions

## Goal
Create department folders where access is controlled by security groups.

## Steps I took
1. Created folders: `Sales`, `HR`, `IT` under a shared root on DC01.
2. Shared each folder and set **share** permissions.
3. Set **NTFS** permissions using the matching security group (e.g., `Sales-Team` gets Modify on `Sales`).
4. Removed broad access (such as Everyone/Users) so only the right group gets in.
5. Tested from CLIENT01 as users in different departments.

## Test results
| User | Group | Sales share | HR share | IT share |
|------|-------|-------------|----------|----------|
| _user1_ | Sales-Team | ✅ | ❌ | ❌ |
| _user2_ | HR-Team | ❌ | ✅ | ❌ |

## Share vs NTFS permissions (my notes)
_Explain in your own words. Both apply; the more restrictive one wins._

## Screenshots
- ![Folder permissions](../images/screenshots/05-ntfs-permissions.png)
