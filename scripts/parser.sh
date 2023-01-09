#!/bin/bash
for i in $(cat $HOME/ASM/init/subdomain/untested.txt);
do
	if [ -d $HOME/ASM/inventory/$i ];
	then
		touch $HOME/ASM/inventory/$i/subdomains.txt
		amass enum -passive -norecursive -noalts -d $i | tee -a $HOME/ASM/inventory/$i/subdomains.txt
		subfinder -d $i | tee -a $HOME/ASM/inventory/$i/subdomains.txt
	else
		mkdir $HOME/ASM/inventory/$i
		touch $HOME/ASM/inventory/$i/subdomains.txt
		amass enum -passive -norecursive -noalts -d $i | tee -a $HOME/ASM/inventory/$i/subdomains.txt
		subfinder -d $i | tee -a $HOME/ASM/inventory/$i/subdomains.txt
	fi
done