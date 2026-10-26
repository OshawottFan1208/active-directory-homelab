# 04 - Group Policy

## Goal
Use Group Policy Objects (GPOs) to apply settings to users and computers automatically.

## Policies I created
| GPO name | Linked to | What it does |
|----------|-----------|--------------|
| Password-Lockout-Policy | Domain | Minimum length, complexity, lockout after N bad attempts |
| Map-Shared-Drive | Sales OU | Maps a department drive on login |
| Desktop-Wallpaper | Domain | Sets a company wallpaper |
| Block-Control-Panel | Non-IT OUs | Prevents access to Control Panel |

## How I tested
1. Logged into CLIENT01 as a test user.
2. Ran `gpupdate /force`.
3. Checked results with `gpresult /r`.

## Troubleshooting a GPO that does not apply
- Is it linked to the right OU?
- Is the user/computer in that OU?
- Did I run `gpupdate /force`?
- Does `gpresult /r` show the GPO applied or denied?

## Screenshots
- ![Group Policy Management](../images/screenshots/04-gpmc.png)
- ![gpresult output](../images/screenshots/04-gpresult.png)
