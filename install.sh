#!/usr/bin/env bash
#Author:Shivam-Rai
#Date:18/06/2021
#Install-Script
echo -e '.___                 __         .__  .__          __  .__               
|   | ____   _______/  |______  |  | |  | _____ _/  |_|__| ____   ____  
|   |/    \ /  ___/\   __\__  \ |  | |  | \__  \\   __\  |/  _ \ /    \ 
|   |   |  \\___ \  |  |  / __ \|  |_|  |__/ __ \|  | |  (  <_> )   |  \
|___|___|  /____  > |__| (____  /____/____(____  /__| |__|\____/|___|  /
         \/     \/            \/               \/                    \/ '
echo
if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Install.sh requires root privileges"
    exit 0
fi
echo
apt-get update
if [ ! -e /usr/lib/go/bin/./go ];then
	apt-get install golang -y
	ln -sfv /usr/lib/go/bin/./go /usr/bin/go
else
	echo "Go is already installed"
fi
apt-get install zip -y
apt-get install python3-pip
echo
cd /opt
git clone https://github.com/FortyNorthSecurity/EyeWitness.git
cd ./EyeWitness/Python/setup
./setup.sh
cd ../
a=$(pwd)
ln -sfv $a/EyeWitness.py /usr/bin/eyewitness
echo
if [ ! -e /usr/bin/httprobe ];then
	go get -u github.com/tomnomnom/httprobe
	ln -sfv /root/go/bin/./httprobe /usr/bin/httprobe
else
	echo "Httprobe is already installed"
fi

if [ ! -e /root/go/bin/.waybackurls ];then
	go get github.com/tomnomnom/waybackurls
	ln -sfv /root/go/bin/./waybackurls /usr/bin/waybackurls
else
	echo "Waybackurl is already installed"
fi

if [ ! -e /root/go/bin/./subjack ];then
	go get github.com/haccer/subjack
	ln -sfv /root/go/bin/./subjack /usr/bin/subjack
else
	echo "Subjack is already installed"
fi
if [ ! -e /root/go/bin/assetfinder ];then
	go get -u github.com/tomnomnom/assetfinder
	ln -sfv /root/go/bin/./assetfinder /usr/bin/assetfinder
else
	echo "Assetfinder is already Installed"
fi

if [ ! -e /usr/bin/amass ];then
	go get -v github.com/OWASP/Amass/v3/...
else
	echo "Amass is already installed"
fi
if [ ! -e /usr/bin/sublist3r ];then
	cd /opt
	mkdir tools
	cd tools
	git clone https://github.com/aboul3la/Sublist3r.git
	cd Sublist3r
	pip3 install -r requirements.txt
	cd ../
	update-alternatives --install /usr/bin/python python /usr/bin/python3 1
	ln -sfv /opt/tools/Sublist3r/sublist3r.py /usr/bin/sublist3r
else
	echo "Sublist3r is already Installed"
fi

if [ ! -e /usr/bin/knockpy ];then
	cd /opt/tools
	git clone https://github.com/guelfoweb/knock.git
	cd knock
        pip3 install -r requirements.txt
	python3 setup.py install
else
	echo "Knockpy is already Installed"
fi

