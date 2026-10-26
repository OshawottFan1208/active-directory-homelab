# Active Directory Homelab

A hands-on Active Directory environment built in VirtualBox (Pop!_OS host) to practice the daily tasks of a help desk / IT support role: user accounts, groups, permissions, Group Policy, and troubleshooting.

## What I built
- [ ] Windows Server domain controller (`lab.local`) with DNS
- [ ] Organizational Units, users, and security groups
- [ ] User attributes (title, department, phone, email)
- [ ] Group Policy (password/lockout policy, drive mapping, restrictions)
- [ ] Department file shares with group-based permissions
- [ ] PowerShell script to bulk-create users from a CSV
- [ ] Windows 11 client joined to the domain

(Check items off as you finish them.)

## Architecture
![Network diagram](images/diagrams/network-diagram.png)

| Machine  | Role                    | IP            | Network   |
|----------|-------------------------|---------------|-----------|
| DC01     | Domain controller / DNS | 192.168.10.10 | labnet    |
| CLIENT01 | Windows 11 client       | 192.168.10.x  | labnet    |

Host: laptop running Pop!_OS with VirtualBox. Each VM has a NAT adapter (internet) and an internal network adapter (`labnet`, private lab network).

## Tools
VirtualBox, Windows Server (evaluation), Windows 11 Enterprise (evaluation), Active Directory Users and Computers, Group Policy Management, PowerShell

## Walkthrough
1. [Environment setup](docs/01-environment-setup.md)
2. [Domain controller](docs/02-domain-controller.md)
3. [Users, groups, and OUs](docs/03-users-groups-ous.md)
4. [Group Policy](docs/04-group-policy.md)
5. [File shares and permissions](docs/05-file-shares.md)

## Scripts
- [`New-BulkUsers.ps1`](scripts/New-BulkUsers.ps1): creates users (and their OUs) from [`users.csv`](data/users.csv)

## Troubleshooting log
Real problems I hit while building this and how I fixed them: [troubleshooting-log.md](docs/troubleshooting-log.md)

## What I learned
To be continued

> All usernames, passwords, and data in this repo are fake and for lab use only.
