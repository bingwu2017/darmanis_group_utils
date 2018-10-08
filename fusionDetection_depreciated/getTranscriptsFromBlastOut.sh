
########################################################################
########################################################################
### getTranscriptsFromBlastOut.sh
### 10.27.17
###
### Ok, so needs the following dir structure: 
### 	01-transcriptomes
### 	02-blastOut
### 	03-blastGrab
### 	04-transcripts
### Where 01 contains transcriptome assemblies for all of your cells, 
### 02 contains the blast_out files for ex4, ex5, ex6 BLASTs against all
### of those transcriptomes, 03 is empty, and 04 is empty. After completion
### you'll have 04 full of all the transcripts corresponding to BLAST
### hits for each of your cells. 
###  
########################################################################
########################################################################
#!/bin/bash

echo " "
echo " ---------------------------------------------"
echo "                 STARTING "
echo " ---------------------------------------------"
echo " " 

for file in ./02-blastOut/*; do
	touch myChunk.tab
	chmod 666 myChunk.tab
	touch tList.tab
	chmod 666 tList.tab
	sed -n -e '/Sequences producing significant alignments:/,/>/ p' $file > myChunk.tab
	sed -i '/Sequences producing significant alignments:/d' myChunk.tab
	sed -i '/>/d' myChunk.tab

	for t_ID in $(cat myChunk.tab | tr -s ' ' | cut -d ' ' -f1); do
		t_ID1=$t_ID
		t_ID2=$(echo "$t_ID1" | tr -d " ")
		echo $t_ID2 >> tList.tab
		echo "grabbed transcript ID!!"
	done
	
	echo "finished a blast_out file!!"
	mv tList.tab ${file}_tlist.tab    
	rm myChunk.tab
done

mv ./02-blastOut/*.tab 03-blastGrab/

echo " " 
echo " ---------------------------------------------"
echo "          Finished BLAST Grab                 "
echo " ---------------------------------------------"
echo " " 

#need to grep these t_IDs from corresponding transcriptomes
for file in ./03-blastGrab/*; do             
	#get cellID...need to take first 19 char
	fileName=$(echo "$file" | sed "s/.*\///")
	cellID="${fileName:0:19}"

	#get corresponding transcriptome
	transcriptome=$cellID
	transcriptome1=${transcriptome}_trinity.fa
	echo $transcriptome1

	#find transcript ID in transcriptome
	for line in $(cat $file); do
		touch bigFile.txt
		chmod 666 bigFile.txt
		touch tFile.txt
		chmod 666 tFile.txt
		grep -P -A 1 $line ./01-transcriptomes/$transcriptome1 > bigFile.txt
		grep -P -A 1 ">${line} len=" bigFile.txt > tFile.txt 
		mv tFile.txt ${cellID}_${line}.fasta
		rm bigFile.txt
		mv ${cellID}_${line}.fasta ./04-transcripts
		echo "found a transcript!!"
	done                                                       
done

echo " "
echo " ---------------------------------------------"
echo "                 All Done                 "
echo " ---------------------------------------------"
echo " "

########################################################################
########################################################################

