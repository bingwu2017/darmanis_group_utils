
##################################################################
##################################################################
### script: pullDown_script.sh
###	author: Lincoln Harris
### date: 12.13.17
###
### Pulls down all of the Unmapped_out files from STAR output
### bins in an S3 bucket. Makes a separate directory for each cell
##################################################################
##################################################################
#!/bin/bash

for dir in $(aws s3 ls s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/ | awk '{print $2}');
do	
	cellID=$(echo "$dir" | tr -d /)
	mkdir $cellID
	cd $cellID

	cp ../alk_human_mrna.fa ./
	
	aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/${dir}STAR_out/Unmapped.out.mate1 ./
	aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/${dir}STAR_out/Unmapped.out.mate2 ./
	mv Unmapped.out.mate1 ${cellID}_unmapped.R1.fastq
	mv Unmapped.out.mate2 ${cellID}_unmapped.R2.fastq

	touch ${cellID}_unmapped.R1.fasta
	touch ${cellID}_unmapped.R2.fasta 
	
	chmod 666 ${cellID}_unmapped.R1.fasta
	chmod 666 ${cellID}_unmapped.R2.fasta

	fastq_to_fasta -i ${cellID}_unmapped.R1.fastq -o ${cellID}_unmapped.R1.fasta
	fastq_to_fasta -i ${cellID}_unmapped.R2.fastq -o ${cellID}_unmapped.R2.fasta

	touch ${cellID}_unmapped.R1_1.fasta
	touch ${cellID}_unmapped.R2_1.fasta

	chmod 666 ${cellID}_unmapped.R1_1.fasta
	chmod 666 ${cellID}_unmapped.R2_1.fasta
	
	while read l; do
		nl=$(echo "$l" | tr -d "	")
		echo $nl >> ${cellID}_unmapped.R1_1.fasta
	done < ${cellID}_unmapped.R1.fasta

	while read l; do
		nl=$(echo "$l" | tr -d "	")
		echo $nl >> ${cellID}_unmapped.R2_1.fasta
	done < ${cellID}_unmapped.R2.fasta

	makeblastdb -in ${cellID}_unmapped.R1_1.fasta -parse_seqids -dbtype nucl
	makeblastdb -in ${cellID}_unmapped.R2_1.fasta -parse_seqids -dbtype nucl

	touch ${cellID}_unmapped.R1_blastOut.txt
	touch ${cellID}_unmapped.R2_blastOut.txt

	chmod 666 ${cellID}_unmapped.R1_blastOut.txt
	chmod 666 ${cellID}_unmapped.R2_blastOut.txt
	
	blastn -query alk_human_mrna.fa -db ${cellID}_unmapped.R1_1.fasta > ${cellID}_unmapped.R1_blastOut.txt
	blastn -query alk_human_mrna.fa -db ${cellID}_unmapped.R2_1.fasta > ${cellID}_unmapped.R2_blastOut.txt

	mkdir blastOut
	mv ${cellID}_unmapped.R1_blastOut.txt blastOut
	mv ${cellID}_unmapped.R2_blastOut.txt blastOut
	cd ..

	echo " " 
	echo " "
	echo "################################### "
	echo "         DIR FINISHED  "
	echo "################################### "
	echo " "
	echo " "
done
##################################################################
##################################################################

