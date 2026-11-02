# 02 - Domain Controller

## Goal
Install Windows Server, give it a static IP, and promote it to a domain controller for `lab.locals`.

## Steps I took
1. Installed Windows Server (Desktop Experience), set an Administrator password.
2. Renamed the server to `DC01`.
3. Set a static IP on the `labnet` adapter: IP `192.168.10.10`, mask `255.255.255.0`, DNS `127.0.0.1`.
4. Installed the **Active Directory Domain Services** role (plus DNS).
5. Promoted the server: **Add a new forest**, root domain `lab.locals`, set the DSRM password.
6. Server restarted; logged in as `LAB\Administrator`.

## Why it matters
- A domain controller keeps the list of users, computers, and policies for the whole network.
- DNS must work or clients cannot find the domain. Many AD problems are really DNS problems.

## Plain-English notes (in my own words)
- Domain: _..._
- Forest: _..._
- DNS: _..._

## Verification
- ![AD Users and Computers showing lab.locals](../images/screenshots/02-aduc-lab-local.png)

Client PC and domain join
Goal
Add a Windows 11 client (CLIENT01) to the domain so I can test policies and practice end-user support.

Steps I took
Created the VM CLIENT01 in VirtualBox with a NAT adapter and a second adapter on the internal network labnet.
Installed Windows 11 Enterprise (evaluation).
Set a static IP on the lab adapter: 192.168.10.20, mask 255.255.255.0, DNS 192.168.10.10 (DC01).
Tested name resolution with nslookup lab.locals.
Renamed the PC to CLIENT01 and joined lab.locals using the domain Administrator account.
Logged in as a domain user and confirmed with whoami.

Why DNS comes first
A client finds the domain through DNS. Pointing the client at DC01 as its DNS server is what makes the join work.

Screenshots
![Client joined to domain](../images/screenshots/02-client-joined-domain.png)
![whoami output](../images/screenshots/02-client-whoami.png)
![CLIENT01 in the Computers container](../images/screenshots/02-dc-computers-container.png)
