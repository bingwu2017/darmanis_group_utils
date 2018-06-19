
#####################################################################
#####################################################################
### script: blast_script.sh
### author: Lincoln Harris
### date: 6/18/18
###
### Want to BLAST every cell against Alk, and then Eml4
###		make sure to blast both reads (forward and reverse), for 
###     	each 
#####################################################################
#####################################################################
#!/bin/bash

driver () {
	file1=/home/ubuntu/expansionVol/03-fusionMessingAround/180307_A00111_0109_BH3KCJDSXX/${dir}/${dir}_R1.fasta
	file2=/home/ubuntu/expansionVol/03-fusionMessingAround/180307_A00111_0109_BH3KCJDSXX/${dir}/${dir}_R2.fasta
	
	#fastq_to_fasta -i $file1 -o ./$dir/${dir}_R1.fasta
	#fastq_to_fasta -i $file2 -o ./$dir/${dir}_R2.fasta

	makeblastdb -in $file1 -dbtype nucl -parse_seqids
	makeblastdb -in $file2 -dbtype nucl -parse_seqids

	#blastn -db ${dir}/${dir}_R1.fasta -query ../querySeqs/alk_ucsc.fa -out ${currPath}/${dir}/${dir}_alk_R1_blastOut
	#blastn -db ${dir}/${dir}_R2.fasta -query ../querySeqs/alk_ucsc.fa -out ${currPath}/${dir}/${dir}_alk_R2_blastOut
	#blastn -db ${dir}/${dir}_R1.fasta -query ../querySeqs/eml4_ucsc.fa -out ${currPath}/${dir}/${dir}_eml4_R1_blastOut
	#blastn -db ${dir}/${dir}_R2.fasta -query ../querySeqs/eml4_ucsc.fa -out ${currPath}/${dir}/${dir}_eml4_R2_blastOut
}

currPath=/home/ubuntu/expansionVol/03-fusionMessingAround/180307_A00111_0109_BH3KCJDSXX
 
i=0

for dir in *; 
do 
	driver "$dir" &
	# Limit to 20 concurrent subshells. THIS WORKS?? 
	if (( $i % 20 == 0 )); 
	then 
		wait; 
	fi
	i=$((i+1))
done
wait

#####################################################################
#####################################################################
