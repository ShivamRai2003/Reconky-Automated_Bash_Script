## Reconky-Automated Bash Script

```---------	 _______  _______  _______  _______  _        _                
(  ____ )(  ____ \(  ____ \(  ___  )( (    /|| \    /\|\     /|
| (    )|| (    \/| (    \/| (   ) ||  \  ( ||  \  / /( \   / )
| (____)|| (__    | |      | |   | ||   \ | ||  (_/ /  \ (_) / 
|     __)|  __)   | |      | |   | || (\ \) ||   _ (    \   /  
| (\ (   | (      | |      | |   | || | \   ||  ( \ \    ) (   
| ) \ \__| (____/\| (____/\| (___) || )  \  ||  /  \ \   | |   
|/   \__/(_______/(_______/(_______)|/    )_)|_/    \/   \_/   
``` 

# Usage
`./reconky.sh <domain.com>`

# About 

Reconky is a script written in bash to automate the task of recon and information gathering.This Bash Script allows you to collect some information that will help you identify what to do next and where to look for the required target.

# Main-Features

- It will Gathers Subdomains with assetfinder and Sublist3r
- Duplex check for subdomains using amass
- Enumerates subdomains on a target domain through dictionary attack using knockpy
- searchs for alive domains using Httprobe
- Investigates for feasible subdomain takeover
- Scans for open ports using nmap
- Pulls and Assembls all possible parameters found in wayback_url data
- Pulls and compilis json/js/php/aspx/ files from wayback output
- Runs eyewitness against all the compiled(alive) domains

# Installation & Requirements
- Download the install script from https://github.com/ShivamRai2003/Reconky-Automated_Bash_Script/blob/main/reconky.sh

# Authors and Thanks
`This script makes use of tools developped by the following people`
- Cyber Mentor 
- Tom Hudson - Tomonomnom
- OWASP
- Ahmed Aboul-Ela - Aboul3la
- Gianni Amato
- FortyNorth Security
- Gordon Lyon

`Note : Run with Caution `
