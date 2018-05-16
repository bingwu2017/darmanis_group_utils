
###########################################################
###########################################################
### script: tcell_grabber.sh
### author: Lincoln Harris
### date: 2.2.18
###
### Generalizable shell script for moving fastqs from one or 
### more source s3 buckets to a destination bucket, according
### to a list of desired cells. 
###
### TO RUN THIS SCRIPT you need a .txt file where each cell 
### that you want to keep is a new line. The following 
### directory structure is required: 
###			run_dir
###				cell1
###					R1.fastq.gz
###					R2.fastq.gz
###				cell2
###					R1.fastq.gz
###					R2.fastq.gz
###
### NOTE (5/15): This solution works, but its super janky 
### 	as it relies on a .txt file, which is much harder 
### 	to parse than a .csv. Im planning to rewrite this 
###		from a .csv input, which will be much simpler and
###		easier to follow. 
###########################################################
###########################################################
#!/bin/bash

# The idea is that you need one of these loops per run directory
# that you're searching through

# LOOP 1
# If subdirectory names ARE NOT the same as cell names, use this loop 
echo "170125_NS500126_0647_AHVHJ2BGXY"
for dir in $(aws s3 ls s3://amaynard-bucket/170125_NS500126_0647_AHVHJ2BGXY/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://amaynard-bucket/170125_NS500126_0647_AHVHJ2BGXY/${dir}); do
		if [[ $file = *".gz" ]]; then
			fileName=${file%__*}
			fileName1=$(echo "$fileName" | tr -d "/")
			fileName2=$(echo "$fileName1" | tr -d " ")
			echo $fileName2
		fi
	done
	for line in $(cat tCellList.csv); do

		line1=$(echo "$line" | tr -d "\n")
		line2=$(echo "$line1" | tr -d " ")
		line3=$(echo "$line2" | tr -d "\t")
		line4=$(echo "$line3" | tr -d "\r")

		if [ "$fileName" == "$line4" ]; then
			echo " "
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170125_NS500126_0647_AHVHJ2BGXY/$dir s3://lincoln.harris-work/scratch1/170125_NS500126_0647_AHVHJ2BGXY/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done


# LOOP 2 
# If subdirectory names ARE the same as cell names, use this loop 
echo "171120_A00111_0085_AH57YYDMXX"
for dir in $(aws s3 ls s3://lincoln.harris-work/171120_A00111_0085_AH57YYDMXX/ | awk '{print $2}'); do

	dirName=$(echo "$dir" | tr -d "/")
	dirName1=$(echo "$dirName" | tr -d " ")

	for line in $(cat tCellList2.txt); do

		line1=$(echo "$line" | tr -d "\n")
		line2=$(echo "$line1" | tr -d " ")
		line3=$(echo "$line2" | tr -d "\t")
		line4=$(echo "$line3" | tr -d "\r")

		if [ "$dirName1" == "$line4" ]; then
			echo " "
			echo 'match found'
			echo $line4
			aws s3 cp s3://lincoln.harris-work/171120_A00111_0085_AH57YYDMXX/$dir s3://lincoln.harris-work/scratch1/171120_A00111_0085_AH57YYDMXX/$dir --recursive
			echo " "
		fi
	done
done

###########################################################
###########################################################
