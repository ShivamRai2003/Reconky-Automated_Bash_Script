#!/usr/bin/bash
#Author:Shivam Rai/
#Date:18/06/2021
#Description:Automated Recon tool
echo "
---------	 _______  _______  _______  _______  _        _                
(  ____ )(  ____ \(  ____ \(  ___  )( (    /|| \    /\|\     /|
| (    )|| (    \/| (    \/| (   ) ||  \  ( ||  \  / /( \   / )
| (____)|| (__    | |      | |   | ||   \ | ||  (_/ /  \ (_) / 
|     __)|  __)   | |      | |   | || (\ \) ||   _ (    \   /  
| (\ (   | (      | |      | |   | || | \   ||  ( \ \    ) (   
| ) \ \__| (____/\| (____/\| (___) || )  \  ||  /  \ \   | |   
|/   \__/(_______/(_______/(_______)|/    )_)|_/    \/   \_/   
                                                               "	
if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Install.sh requires root privileges"
    exit 0
fi
target=$1
if [ ! -d "$target" ];then
	mkdir $target
fi
if [ ! -d "$target/reconky" ];then
	mkdir $target/reconky
fi
if [ ! -d '$target/reconky/sublist3r' ];then
	mkdir $target/reconky/sublist3r
	touch $target/reconky/sublist3r/subdomains.txt
fi
if [ ! -d '$tagget/reconky/httprobe' ]; then
	mkdir $target/reconky/httprobe
fi
if [ ! -d '$target/reconky/assetfinder' ];then
	mkdir $target/reconky/assetfinder
	touch $target/reconky/assetfinder/subdomains1.txt
fi
if [ ! -d '$target/reconky/Subdomain_Takeover' ]; then
	mkdir $target/reconky/Subdomain_Takeover
fi
if [ ! -d '$target/reconky/scans' ]; then
	mkdir $target/reconky/scans
fi
if [ ! -d '$target/reconky/wayback_urls' ]; then
	mkdir $target/reconky/wayback_urls
	mkdir $target/reconky/wayback_urls/params
	touch $target/reconky/wayback_urls/params/params.txt
	mkdir $target/reconky/wayback_urls/extensions
fi
if [ ! -d '$target/reconky/amass' ]; then
	mkdir $target/reconky/amass
	touch $target/reconky/assetfinder/subdomains2.txt
fi
if [ ! -d '$target/reconky/witness' ]; then
	mkdir $target/reconky/eyewitness
fi
if [ ! -d '$target/reconky/knockpy' ]; then
	mkdir $target/reconky/knockpy
	touch $target/reconky/knockpy/subdomains3.txt
fi
if [ ! -f "$target/reconky/httprobe/alivee.txt" ];then
	touch $target/reconky/httprobe/alivee.txt
fi
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
echo
echo ${yellow}"Welcome to the Reconky Script-An Excellent Automation Script For Bug Bounty/Pentesting"${yellow}
echo
echo ${red}"[+++] Gatherings subdomains with assetfinder and Sublist3r...[+++]"${red}
echo
echo ${red}"[+++] Duplex checking for subdomains with amass...[+++]"${red}
echo
echo ${red}"[+++] Enumerating subdomains on a target domain through dictionary attack...[+++]"${red}
echo
echo ${red}"[+++] Searching for alive domains using Httprobe...[+++]"${red}
echo
echo ${red}"[+++] Investigating for feasible subdomain takeover...[+++]"${red}
echo
echo ${green}"[+++] Scanning for open ports using nmap...[+++]"${green}
echo
echo ${green}"[+++] Pulling and Assembling all possible params found in wayback_url data...[+++]"${green}
echo
echo ${green}"[+++] Pulling and compiling json/js/php/aspx/ files from wayback output...[+++]"${green}
echo
echo ${green}"[+++] Running gowtiness(eyewitness) against all the compiled(alive) domains...[+++]"${green}
echo
echo ${yellow}"[+++]Recon is in Progress Take A Cofee or Tea ;)[+++]"${yellow}
echo
assetfinder $target >> $target/reconky/assetfinder/subdomains1.txt
cat $target/reconky/assetfinder/subdomains1.txt | grep $1 >> $target/reconky/Subdomain_final.txt
echo
sublist3r -d $target -v -t 100 -o $target/reconky/sublist3r/subdomains.txt
cat $target/reconky/sublist3r/subdomains.txt | grep $1 >> $target/reconky/Subdomain_final.txt
echo
amass enum -d $target -o $target/reconky/amass/subdomains2.txt
cat $target/reconky/amass/subdomains2.txt | grep $1 >> $target/reconky/Subdomain_final.txt
echo
knockpy $target >> $target/reconky/knockpy/subdomains3.txt 
awk '/$target/ {print}' $target/reconky/knockpy/subdomains3.txt | cut -d " " -f 9 >> $target/reconky/Subdomain_final.txt
echo
cat $target/reconky/Subdomain_final.txt | sort -u | httprobe | sed -E 's/^\s*.*:\/\///g' >> $target/reconky/httprobe/alivee.txt
echo
if [ ! -f "$target/reconky/Subdomain_Takeover/Subdomain_Takeover.txt" ];then
	touch $target/reconky/Subdomain_Takeover/Subdomain_Takeover.txt
fi
subjack -w $target/reconky/Subdomain_final.txt -t 70 -timeout 25 -ssl -c /root/go/src/github.com/haccer/subjack/fingerprints.json -v 3 -o $target/reconky/Subdomain_Takeover/Subdomain_Takeover.txt
echo
nmap -iL $target/reconky/httprobe/alivee.txt -T4 -oA $target/reconky/scans/scanned.txt
echo
if [ ! -f "$target/reconky/wayback_urls/wayback_output.txt" ];then
	touch $target/reconky/wayback_urls/wayback_output.txt
fi
cat $target/reconky/Subdomain_final.txt | waybackurls >> $target/reconky/wayback_urls/wayback_output.txt
sort -u $target/reconky/wayback_urls/wayback_output.txt
cat $target/reconky/wayback_urls/wayback_output.txt | grep '?*=' | cut -d '=' -f 1 | sort -u >> $target/reconky/wayback_urls/params/params.txt
for i in $(cat $target/reconky/wayback_urls/params/params.txt);do echo $i'=';done
echo
for i in $(cat $target/reconky/wayback_urls/wayback_output);do
	ext="${i##*.}"
	if [[ "ext"=="php" ]];then
		echo $i >> $target/reconky/wayback_urls/extensions/php1.txt
		sort -u $target/reconky/wayback_urls/extensions/php1.txt >> $target/reconky/wayback_urls/extensions/php.txt
		rm $target/reconky/wayback_urls/extensions/php1.txt
	fi
	if [[ "ext"=="js" ]];then
		echo $i >> $target/reconky/wayback_urls/extensions/js1.txt
		sort -u $target/reconky/wayback_urls/extensions/js1.txt >> $target/reconky/wayback_urls/extensions/js.txt
		rm $target/reconky/wayback_urls/extensions/js1.txt
	fi
	if [[ "ext"=="html" ]];then
		echo $i >> $target/reconky/wayback_urls/extensions/html1.txt
		sort -u $target/reconky/wayback_urls/extensions/html1.txt >> $target/reconky/wayback_urls/extensions/html.txt
		rm $target/reconky/wayback_urls/extensions/html1.txt
	fi
	if [[ "ext"=="json" ]];then
		echo $i >> $target/reconky/wayback_urls/extensions/json1.txt
		sort -u $target/reconky/wayback_urls/extensions/json1.txt >> $target/reconky/wayback_urls/extensions/json.txt
		rm $target/reconky/wayback_urls/extensions/json1.txt
	fi
	if [[ "ext"=="aspx" ]];then
		echo $i >> $target/reconky/wayback_urls/extensions/aspx1.txt
		sort -u $target/reconky/wayback_urls/extensions/aspx1.txt >> $target/reconky/wayback_urls/extensions/aspx.txt
		rm $target/reconky/wayback_urls/extensions/aspx1.txt
	fi
done
eyewitness -f $target/reconky/httprobe/alivee.txt --web -d $target/reconky/eyewitness --resolve
