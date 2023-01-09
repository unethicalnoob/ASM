#!/bin/bash

for i in $(cat $HOME/ASM/init/git/untested.txt);
do
	if [ -d $HOME/ASM/inventory/$i ];
	then
		python3 $HOME/ASM/tools/gitdorker/GitDorker.py -tf $HOME/ASM/config/github_api.config -q $i -d $HOME/ASM/tools/gitdorker/Dorks/medium_dorks.txt -o $HOME/ASM/inventory/$i/result
	else
		mkdir $HOME/ASM/inventory/$i
		python3 $HOME/ASM/tools/gitdorker/GitDorker.py -tf $HOME/ASM/config/github_api.config -q $i -d $HOME/ASM/tools/gitdorker/Dorks/medium_dorks.txt -o $HOME/ASM/inventory/$i/result
	fi
done

