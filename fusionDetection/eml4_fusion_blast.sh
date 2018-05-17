
##################################################################
##################################################################
### script: eml4_fusion_blast.sh
### author: Lincoln Harris
### date: 12.15.17
### 
### Also want to BLAST every cell for this EML4-ALK fusion mRNA. 
### Need EML4-ALK as a blast database in the working directory. 
##################################################################
##################################################################
#!/bash/bin

for dir in */ ; do
	cd $dir
	cellID=$(echo "$dir" | tr -d /)
	sudo touch ${cellID}_unmapped_R1_eml4_fusion_blastOut.txt
	sudo touch ${cellID}_unmapped_R2_eml4_fusion_blastOut.txt

	sudo chmod 666 ${cellID}_unmapped_R1_eml4_fusion_blastOut.txt
	sudo chmod 666 ${cellID}_unmapped_R2_eml4_fusion_blastOut.txt

	sudo blastn -query ../eml4-alk_fusion_human.fa -db ${cellID}_unmapped.R1_1.fasta > ${cellID}_unmapped_R1_eml4_fusion_blastOut.txt
	sudo blastn -query ../eml4-alk_fusion_human.fa -db ${cellID}_unmapped.R2_1.fasta > ${cellID}_unmapped_R2_eml4_fusion_blastOut.txt
  
	sudo mv ${cellID}_unmapped_R1_eml4_fusion_blastOut.txt blastOut
	sudo mv ${cellID}_unmapped_R2_eml4_fusion_blastOut.txt blastOut
	
	cd ../

	echo "dir complete"
done

##################################################################
##################################################################

