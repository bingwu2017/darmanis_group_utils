
###################################################################
###################################################################
### script: blastAnalysis_script.sh
### author: Lincoln Harris
### date: 12.15.17
###
### This script will analyze each of these blast output files and 
### scan for read pairs that hit both alk and eml4. Lets see if 
### we can get it to tell us if the readIDs corresponding to those 
### BLAST hits are the same...
###
### 5.15 -- DOES THIS THING ACTUALLY WORK??  
###################################################################
###################################################################
#!/bin/bash

for dir in */ ; do	
	cd $dir
	cd blastOut
	cellID=$(echo "$dir" | tr -d /)
	line="Sequences producing significant alignments:"
	
	if grep -q $line *_unmapped.R1_blastOut.txt  #if alk match
	then
		if grep -q $line *_eml4_blastOut.txt  #if eml match
		then

			# For Read1

			touch myChunk.txt
			chmod 666 myChunk.txt
			touch tList.txt
			chmod 666 tList.txt
			sed -n -e '/Sequences producing significant alignments:/,/>/ p' *_unmapped.R1_blastOut.txt > myChunk.txt
			sed -i '/Sequences producing significant alignments:/d' myChunk.txt
			sed -i '/>/d' myChunk.txt

			for t_ID in $(cat myChunk.txt | tr -s ' ' | cut -d ' ' -f1); do
				t_ID1=$t_ID
				t_ID2=$(echo "$t_ID1" | tr -d " ")
				echo $t_ID2 >> tList.txt
				echo "grabbed transcript ID!!"
			done

			echo "finished a blast_out file!!"
			mv tList.txt ${cellID}_unmapped.R1_tlist.txt
			rm myChunk.txt
			mv ${cellID}_unmapped.R1_tlist.txt ../../blastGrab
			
			# For Read2

			touch myChunk.txt
			chmod 666 myChunk.txt
			touch tList.txt
			chmod 666 tList.txt
			sed -n -e '/Sequences producing significant alignments:/,/>/ p' *_unmapped.R2_blastOut.txt > myChunk.txt
			sed -i '/Sequences producing significant alignments:/d' myChunk.txt
			sed -i '/>/d' myChunk.txt

			for t_ID in $(cat myChunk.txt | tr -s ' ' | cut -d ' ' -f1); do
				t_ID1=$t_ID
				t_ID2=$(echo "$t_ID1" | tr -d " ")
				echo $t_ID2 >> tList.txt
				echo "grabbed transcript ID!!"
			done

			echo "finished a blast_out file!!"
			mv tList.txt ${cellID}_unmapped.R2_tlist.txt
			rm myChunk.txt
			mv ${cellID}_unmapped.R2_tlist.txt ../../blastGrab
		fi
	fi
        cd ../../
done

###################################################################
###################################################################

