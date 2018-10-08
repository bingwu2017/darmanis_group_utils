
##################################################################
##################################################################
### script: eml4_blast.sh
### author: Lincoln Harris
### date: 12.15.17
### 
### BLAST every cell directory for EML4. Need to have EML4 blast 
### database in your working directory before running. 
##################################################################
##################################################################
#!/bash/bin

for dir in */ ; do
	cd $dir
	cellID=$(echo "$dir" | tr -d /)
	touch ${cellID}_unmapped_R1_eml4_blastOut.txt
	touch ${cellID}_unmapped_R2_eml4_blastOut.txt

	chmod 666 ${cellID}_unmapped_R1_eml4_blastOut.txt
	chmod 666 ${cellID}_unmapped_R2_eml4_blastOut.txt

	blastn -query ../eml4_human_mrna.fa -db ${cellID}_unmapped.R1_1.fasta > ${cellID}_unmapped_R1_eml4_blastOut.txt
	blastn -query ../eml4_human_mrna.fa -db ${cellID}_unmapped.R2_1.fasta > ${cellID}_unmapped_R2_eml4_blastOut.txt
  
	mv ${cellID}_unmapped_R1_eml4_blastOut.txt blastOut
	mv ${cellID}_unmapped_R2_eml4_blastOut.txt blastOut
	
	cd ../

	echo "dir complete"
done

##################################################################
##################################################################

