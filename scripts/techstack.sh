#!/bin/bash
for i in $(cat $HOME/ASM/init/techstack/untested.txt);
do
	if [ -d $HOME/ASM/inventory/$i/techstack ];
	then
        for subs in $(cat $HOME/ASM/inventory/$i/SNI_subdomains.txt); do touch $HOME/ASM/inventory/techstack/$subs.tech | curl -H "x-api-key: ysDFKGv08n2EtumOHHJnt95tfVTb4y6nI2DhkHZ9" https://api.wappalyzer.com/v2/lookup/?urls=https://$subs | tee $HOME/ASM/inventory/techstack/$subs.tech; done
        for ips in $(cat $HOME/ASM/inventory/$i/SNI_IPs.txt); do touch $HOME/ASM/inventory/techstack/$ips.tech | curl -H "x-api-key: ysDFKGv08n2EtumOHHJnt95tfVTb4y6nI2DhkHZ9" https://api.wappalyzer.com/v2/lookup/?urls=http://$ips&live=true&recursive=false | tee $HOME/ASM/inventory/techstack/$ips.tech; done
    else
    	mkdir $HOME/ASM/inventory/$i/techstack
    	for subs in $(cat $HOME/ASM/inventory/$i/SNI_subdomains.txt); do touch $HOME/ASM/inventory/techstack/$subs.tech | curl -H "x-api-key: ysDFKGv08n2EtumOHHJnt95tfVTb4y6nI2DhkHZ9" https://api.wappalyzer.com/v2/lookup/?urls=https://$subs | tee $HOME/ASM/inventory/techstack/$subs.tech; done
        for ips in $(cat $HOME/ASM/inventory/$i/SNI_IPs.txt); do  touch $HOME/ASM/inventory/techstack/$ips.tech | curl -H "x-api-key: ysDFKGv08n2EtumOHHJnt95tfVTb4y6nI2DhkHZ9" https://api.wappalyzer.com/v2/lookup/?urls=http://$ips&live=true&recursive=false | tee $HOME/ASM/inventory/techstack/$ips.tech; done
    fi
done