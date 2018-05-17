
###########################################################
###########################################################
### script: which_fusion_hits.sh
### author: Lincoln Harris
### date: 12.19.17
###  
### Outputs which of these cells actually have hits to this
### eml4/alk fusion thing
###########################################################
###########################################################
#!/bin/bash

for dir in */; do
	cd $dir
	cd blastOut
	cellID=$(echo "$dir" | tr -d /)	
	
	if grep -q "Sequences producing significant alignments:" ${cellID}_unmapped_R1_eml4_fusion_blastOut.txt;
	then
		echo $cellID
	fi
	
	if grep -q "Sequences producing significant alignments:" ${cellID}_unmapped_R2_eml4_fusion_blastOut.txt;
	then
		echo $cellID
	fi
	
	cd ../../
done

###########################################################
###########################################################

