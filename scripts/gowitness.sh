#!/bin/bash
for i in $(cat $HOME/ASM/init/gowitness/untested.txt);
do
	if [ -d $HOME/ASM/inventory/$i ];
	then
		cd $HOME/ASM/inventory/$i
		touch $HOME/ASM/inventory/$i/live.txt
		cat *.txt | httpx -silent | tee -a $HOME/ASM/inventory/$i/live.txt
		gowitness file -f $HOME/ASM/inventory/$i/live.txt 
	else
		mkdir $HOME/ASM/inventory/$i
		cd $HOME/ASM/inventory/$i
		touch $HOME/ASM/inventory/$i/live.txt
		cat *.txt | httpx -silent | tee -a $HOME/ASM/inventory/$i/live.txt
		gowitness file -f $HOME/ASM/inventory/$i/live.txt
	fi
done
