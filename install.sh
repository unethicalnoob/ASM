#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

GO_VERSION=$(curl --silent https://go.dev/VERSION?m=text | sed 's/go//' )

echo "${RED}######################################################### ${RESET}"
echo "${RED}#                  TOOLS FOR AUTOMATION                 # ${RESET}"
echo "${RED}######################################################### ${RESET}"

echo "${GREEN}[+] Updating and installing dependencies ${RESET}"
echo "${BLUE}Estimated time - 7 minutes (based on the network speed) ${RESET}"
{
sudo DEBIAN_FRONTEND=noninteractive apt install -yq curl net-tools python2
sudo DEBIAN_FRONTEND=noninteractive /bin/bash -c "$(curl -sL https://git.io/vokNn)"
sudo DEBIAN_FRONTEND=noninteractive echo debconf apt-fast/maxdownloads string 16 | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive echo debconf apt-fast/dlflag boolean true | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive echo debconf apt-fast/aptmanager string apt-get | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt install -y aptitude gnupg

sudo DEBIAN_FRONTEND=noninteractive apt-fast -y update
sudo DEBIAN_FRONTEND=noninteractive apt-fast -y upgrade

sudo wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py
sudo python3 /tmp/get-pip.py && sudo rm /tmp/get-pip.py

sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y apt-transport-https
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y libssl-dev
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y jq libappindicator1 fonts-liberation
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y ruby-full
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y build-essential libssl-dev libffi-dev python3-dev
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y python-setuptools
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y libldns-dev
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y python3
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y python3-pip
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y python3-dnspython
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y git gcc make libcap-dev
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y npm
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y nmap
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y gem
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y perl
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y parallel
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y tmux
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y dnsutils
sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y libpcap-dev
sudo pip3 install jsbeautifier
} > /dev/null 2>&1
echo "${BLUE}Done ${RESET}"
echo ""

echo "${GREEN}[+] Installing Golang ${RESET}"
if [ ! -f $HOME/.go/bin/go ];then
    {
    wget -q -O - https://git.io/vQhTU | bash -s -- --version $GO_VERSION
    grep -qxF 'export GOROOT=$HOME/.go' ~/.bashrc || echo 'export GOROOT=$HOME/.go' >> ~/.bashrc
    grep -qxF 'export GOPATH=$HOME/go' ~/.bashrc || echo 'export GOPATH=$HOME/go' >> ~/.bashrc
    grep -qxF '[[ ":$PATH:" != *":$GOPATH/bin:$GOROOT/bin:"* ]] && export PATH="$GOPATH/bin:$GOROOT/bin:${PATH}"' ~/.bashrc || echo '[[ ":$PATH:" != *":$GOPATH/bin:$GOROOT/bin:"* ]] && export PATH="$GOPATH/bin:$GOROOT/bin:${PATH}"' >> ~/.bashrc
    eval "$(cat ~/.bashrc | tail -n +10)"
    } > /dev/null 2>&1
    echo "${BLUE}Done ${RESET}"
else
    eval "$(cat ~/.bashrc | tail -n +10)" > /dev/null 2>&1
    echo "${BLUE}Golang is already installed${RESET}"
fi
echo ""


echo "${GREEN}[+] Installing Components ${RESET}"
echo "${BLUE}Estimated time - 10 minutes (also based on the network speed) ${RESET}"
{
mkdir $HOME/ASM/ $HOME/ASM/tools $HOME/ASM/inventory $HOME/ASM/wordlists $HOME/ASM/config $HOME/ASM/init/
mkdir $HOME/ASM/init/subdomain/ $HOME/ASM/init/techstack $HOME/ASM/init/cloud $HOME/ASM/init/git $HOME/ASM/init/gowitness $HOME/ASM/init/portscan

git clone https://github.com/unethicalnoob/ASM/ /tmp/ASM/ && mv /tmp/ASM/scripts/ $HOME/ASM/scripts/
rm -rf /tmp/ASM && rm $HOME/ASM/scripts/test.sh

sudo chmod u+x $HOME/ASM/scripts/*

touch $HOME/ASM/config/github_api.config $HOME/ASM/config/subfinder.config $HOME/ASM/config/amass.config

cd ~

# 1)Cloud Parsing Component
mkdir $HOME/ASM/SNI 
cd $HOME/ASM/SNI

wget http://kaeferjaeger.gay/sni-ip-ranges/amazon/ipv4_merged_sni.txt -O amazon_sni.txt
wget http://kaeferjaeger.gay/sni-ip-ranges/digitalocean/ipv4_merged_sni.txt -O digitalocean_sni.txt
wget http://kaeferjaeger.gay/sni-ip-ranges/google/ipv4_merged_sni.txt -O google_sni.txt
wget http://kaeferjaeger.gay/sni-ip-ranges/microsoft/ipv4_merged_sni.txt -O microsoft_sni.txt
wget http://kaeferjaeger.gay/sni-ip-ranges/oracle/ipv4_merged_sni.txt -O oracle_sni.txt
cd ~

# 2)GitHub Dorking
git clone https://github.com/unethicalnoob/GitDorkertweak.git $HOME/ASM/tools/gitdorker
cd $HOME/ASM/tools/gitdorker && pip3 install -r requirements.txt
cd ~

# 3)Technology Stack
#Just an API signup in wappalyzer

# 4)Mobile Apps
sudo DEBIAN_FRONTEND=noninteractive apt install -y apktool
go install github.com/tomnomnom/gf@latest 
wget https://raw.githubusercontent.com/tomnomnom/gf/master/gf-completion.bash -O $HOME/ASM/tools/gf-completion.bash
git clone https://github.com/1ndianl33t/Gf-Patterns $HOME/ASM/tools/gfpatterns
git clone https://github.com/arthur4ires/gfPatterns $HOME/ASM/tools/gfpatterns2
mkdir $HOME/.gf && cp -r $HOME/ASM/tools/gfpatterns/*.json $HOME/.gf && cp -r $HOME/ASM/tools/gfpatterns2/*.json $HOME/.gf
grep -qxF 'source $HOME/ASM/tools/gf-completion.bash' ~/.bashrc || echo 'source $HOME/ASM/tools/gf-completion.bash' >> ~/.bashrc
eval "$(cat ~/.bashrc | tail -n +10)"
cd ~

# 5)Internet Facing Domains
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/cgboal/sonarsearch/cmd/crobat@latest
go install github.com/OWASP/Amass/v3/...@master
go install github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/michenriksen/aquatone@latest
go install github.com/tomnomnom/assetfinder@latest
go install github.com/ffuf/ffuf@latest
go install github.com/OJ/gobuster/v3@latest
go install github.com/d3mondev/puredns/v2@latest

git clone https://github.com/blechschmidt/massdns.git $HOME/ASM/tools/massdns
cd $HOME/ASM/tools/massdns/
make && make install
sudo cp $HOME/ASM/tools/massdns/bin/massdns /usr/local/bin/massdns

cd ~

# 6)Network Services
go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install github.com/projectdiscovery/notify/cmd/notify@latest
go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
cd ~

#Wordlists
git clone https://github.com/danielmiessler/SecLists.git $HOME/ASM/wordlists/SecLists
wget https://wordlists-cdn.assetnote.io/data/manual/2m-subdomains.txt -O $HOME/ASM/wordlists/2m-subdomains.txt
wget https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt -O $HOME/ASM/wordlists/best-dns.txt
git clone https://github.com/orwagodfather/WordList.git $HOME/ASM/wordlists/orwa
wget https://raw.githubusercontent.com/six2dez/OneListForAll/main/onelistforallshort.txt -O $HOME/ASM/wordlists/onelistforallshort.txt
wget https://raw.githubusercontent.com/six2dez/OneListForAll/main/onelistforallmicro.txt -O $HOME/ASM/wordlists/onelistforallmicro.txt
wget https://raw.githubusercontent.com/ozzi-/tld_scanner/master/topTLDs.txt -O $HOME/ASM/wordlists/toptlds.txt
wget https://raw.githubusercontent.com/ozzi-/tld_scanner/master/sTLDs.txt -O $HOME/ASM/wordlists/ctlds.txt
wget https://raw.githubusercontent.com/ozzi-/tld_scanner/master/ccTLDs.txt -O $HOME/ASM/wordlists/cctlds.txt
wget https://raw.githubusercontent.com/trickest/resolvers/main/resolvers.txt -O $HOME/ASM/wordlists/resolvers.txt

} > /dev/null 2>&1
echo "${BLUE}Done ${RESET}"

echo ""
echo "${BLUE}Do not forget to add the API keys ${RESET}"
echo "${BLUE}Please source ~/.bashrc for tools to work"


