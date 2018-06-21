#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
# script: fusionPipeline.sh
# author: Lincoln Harris
# date: 6/20/18
#
# This is a pipeline for generating all of the BLAST output files 
# needed by findChimericReads.py. Launches 20 threads to massively
# speed things up. Be careful, though, needs a machine with a lot of
# cores & swap space
#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
#!/bin/bash

#/////////////////////////////////////////////////////////////////////
# blastn_func ()
# 
#/////////////////////////////////////////////////////////////////////
blastn_func () {
	blastn -db ${dir}/${dir}_R1.fasta -query ../querySeqs/alk_ucsc.fa -out ${currPath}/${dir}/${dir}_alk_R1_blastOut
	blastn -db ${dir}/${dir}_R2.fasta -query ../querySeqs/alk_ucsc.fa -out ${currPath}/${dir}/${dir}_alk_R2_blastOut
	blastn -db ${dir}/${dir}_R1.fasta -query ../querySeqs/eml4_ucsc.fa -out ${currPath}/${dir}/${dir}_eml4_R1_blastOut
	blastn -db ${dir}/${dir}_R2.fasta -query ../querySeqs/eml4_ucsc.fa -out ${currPath}/${dir}/${dir}_eml4_R2_blastOut
}

#/////////////////////////////////////////////////////////////////////
# make_blast_db_func ()
# 
#/////////////////////////////////////////////////////////////////////
make_blast_db_func () {
	file1=/home/ubuntu/expansionVol/03-fusionMessingAround/17504_test/${dir}/${dir}_R1.fasta
	file2=/home/ubuntu/expansionVol/03-fusionMessingAround/17504_test/${dir}/${dir}_R2.fasta
	
	makeblastdb -in $file1 -dbtype nucl -parse_seqids
	makeblastdb -in $file2 -dbtype nucl -parse_seqids
}

#/////////////////////////////////////////////////////////////////////
# fastq_to_fasta_func ()
# 
#/////////////////////////////////////////////////////////////////////
fastq_to_fasta_func () {
	file1=/home/ubuntu/expansionVol/03-fusionMessingAround/17504_test/${dir}/*R1_001.fastq
	file2=/home/ubuntu/expansionVol/03-fusionMessingAround/17504_test/${dir}/*R2_001.fastq
	
	fastq_to_fasta -i $file1 -o ./${dir}/${dir}_R1.fasta
	fastq_to_fasta -i $file2 -o ./${dir}/${dir}_R2.fasta
}

#/////////////////////////////////////////////////////////////////////
# gunzip_func ()
# 
#/////////////////////////////////////////////////////////////////////
gunzip_func () {
	gunzip ./${dir}/*.gz
}

#/////////////////////////////////////////////////////////////////////
# driver ()
#	Main logic here. Each thread needs to execute these 4 functions,
# 	in order. 
#/////////////////////////////////////////////////////////////////////
driver () {
	gunzip_func "$dir" 
	fastq_to_fasta_func "$dir"
	make_blast_db_func "$dir" 
	blastn_func "$dir"
}

#/////////////////////////////////////////////////////////////////////
# main()
# 	Initiate loop for every cell in directory, initate threads 
#	(limited to 20), then call driver function. 
#/////////////////////////////////////////////////////////////////////

currPath=/home/ubuntu/expansionVol/03-fusionMessingAround/17504_test
 
i=0

# initiate main loop
for dir in *; 
do 
	driver "$dir" & 
	# Limit to 20 concurrent subshells.
	if (( $i % 20 == 0 )); 
	then 
		wait; 
	fi

	i=$((i+1))
done

wait

# can we run this from in here? -- I think so...
#python3 findChimericReads.py

#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////