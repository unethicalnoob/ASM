#!/bin/bash
for i in $(cat $HOME/ASM/init/cloud/untested.txt);
do 
	if [ -d $HOME/ASM/inventory/$i ];
	then
		touch $HOME/ASM/inventory/$i/SNI_IPs.txt
		touch $HOME/ASM/inventory/$i/SNI_subdomains.txt
    	cat $HOME/ASM/SNI/*.txt | grep $i | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | tee -a $HOME/ASM/inventory/$i/SNI_IPs.txt;
    	cat $HOME/ASM/SNI/*.txt | grep $i | grep -oE '\[(.*?)\]' | sed 's/[][]//g' | sed 's/\s\+/\n/g' | grep -v '^*' | uniq | tee -a $HOME/ASM/inventory/$i/SNI_subdomains.txt
	else
    	mkdir $HOME/ASM/inventory/$i
    	touch $HOME/ASM/inventory/$i/SNI_IPs.txt
		touch $HOME/ASM/inventory/$i/SNI_subdomains.txt
    	cat $HOME/ASM/SNI/*.txt | grep $i | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | tee -a $HOME/ASM/inventory/$i/SNI_IPs.txt;
    	cat $HOME/ASM/SNI/*.txt | grep $i | grep -oE '\[(.*?)\]' | sed 's/[][]//g' | sed 's/\s\+/\n/g' | grep -v '^*' | uniq | tee -a $HOME/ASM/inventory/$i/SNI_subdomains.txt
	fi    
done