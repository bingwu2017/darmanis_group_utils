
###########################################################
###########################################################
### mvr_script1.sh
### 2.2.18
###
### Trying to move cells from two diff s3 buckets to a 
### shared out bucket, according to a list of desired cells.
###########################################################
###########################################################
#!/bin/bash

# 171120_A00111_0085_AH57YYDMXX - LOOP 1
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
			echo 'match found SEQBOT 1'
			echo $line4
			aws s3 cp s3://lincoln.harris-work/171120_A00111_0085_AH57YYDMXX/$dir s3://lincoln.harris-work/tCellGrab/$dir --recursive
			echo " "
		fi
	done
done

# 171120_A00111_0086_BH55NVDMXX - LOOP 2
for dir in $(aws s3 ls s3://lincoln.harris-work/171120_A00111_0086_BH55NVDMXX/ | awk '{print $2}'); do
	
	dirName=$(echo "$dir" | tr -d "/")
	dirName1=$(echo "$dirName" | tr -d " ")
	
	for line in $(cat tCellList2.txt); do
		
		line1=$(echo "$line" | tr -d "\n")
		line2=$(echo "$line1" | tr -d " ")
		line3=$(echo "$line2" | tr -d "\t")
		line4=$(echo "$line3" | tr -d "\r")
		
		if [ "$dirName1" == "$line4" ]; then
			echo " "
			echo 'match found SEQBOT 2'
			echo $line4
			aws s3 cp s3://lincoln.harris-work/171120_A00111_0086_BH55NVDMXX/$dir s3://lincoln.harris-work/tCellGrab/$dir --recursive						
			echo " "
		fi
	done
done


# ASHLEY BUCKET - LOOP 1
echo "ASHLEY BUCKET 1"
for dir in $(aws s3 ls s3://amaynard-bucket/170125_NS500126_0647_AHVHJ2BGXY/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://amaynard-bucket/170125_NS500126_0647_AHVHJ2BGXY/${dir}); do
		if [[ $file = *".gz" ]]; then
			fileName=${file%__*}
			fileName1=$(echo "$fileName" | tr -d "/")
			fileName2=$(echo "$fileName1" | tr -d " ")
			#echo $fileName2
		fi
	done
	for line in $(cat tCellList.csv); do
		
		line1=$(echo "$line" | tr -d "\n")
		line2=$(echo "$line1" | tr -d " ")
		line3=$(echo "$line2" | tr -d "\t")
		line4=$(echo "$line3" | tr -d "\r")

		if [ "$fileName" == "$line4" ]; then
			echo " "
			echo 'match found ASHLEY 1'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170125_NS500126_0647_AHVHJ2BGXY/$dir s3://lincoln.harris-work/tCellGrab/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

echo "ASHLEY BUCKET 2"
# ASHLEY BUCKET - LOOP 2
for dir in $(aws s3 ls s3://amaynard-bucket/170129_NS500126_0650_AHVM75BGXY/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://amaynard-bucket/170129_NS500126_0650_AHVM75BGXY/${dir}); do
		if [[ $file = *".gz" ]]; then
			fileName=${file%__*}
			fileName1=$(echo "$fileName" | tr -d "/")
			fileName2=$(echo "$fileName1" | tr -d " ")
		fi
	done
	for line in $(cat tCellList.csv); do
		
		line1=$(echo "$line" | tr -d "\n")
		line2=$(echo "$line1" | tr -d " ")
		line3=$(echo "$line2" | tr -d "\t")
		line4=$(echo "$line3" | tr -d "\r")

		if [ "$fileName" == "$line4" ]; then
			echo " "
			echo 'match found ASHLEY 2'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170129_NS500126_0650_AHVM75BGXY/$dir s3://lincoln.harris-work/tCellGrab/$fileName2 --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

echo "ASHLEY BUCKET 3"
# ASHLEY BUCKET - LOOP 3
for dir in $(aws s3 ls s3://amaynard-bucket/170202_NS500126_0653_AHVL5NBGXY/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://amaynard-bucket/170202_NS500126_0653_AHVL5NBGXY/${dir}); do
		if [[ $file = *".gz" ]]; then
			fileName=${file%__*}
			fileName1=$(echo "$fileName" | tr -d "/")
			fileName2=$(echo "$fileName1" | tr -d " ")
		fi
	done
	for line in $(cat tCellList.csv); do
		
		line1=$(echo "$line" | tr -d "\n")
		line2=$(echo "$line1" | tr -d " ")
		line3=$(echo "$line2" | tr -d "\t")
		line4=$(echo "$line3" | tr -d "\r")

		if [ "$fileName" == "$line4" ]; then
			echo " "
			echo 'match found ASHLEY 3'
			echo $line4
			#aws s3 cp s3://amaynard-bucket/170202_NS500126_0653_AHVL5NBGXY/$dir s3://lincoln.harris-work/tCellGrab/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

echo "ASHLEY BUCKET 4"
# ASHLEY BUCKET - LOOP 4
for dir in $(aws s3 ls s3://amaynard-bucket/170215_NS500126_0658_AH7TLYBGX2/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://amaynard-bucket/170215_NS500126_0658_AH7TLYBGX2/${dir}); do
		if [[ $file = *".gz" ]]; then
			fileName=${file%__*}
			fileName1=$(echo "$fileName" | tr -d "/")
			fileName2=$(echo "$fileName1" | tr -d " ")
		fi
	done
	for line in $(cat tCellList.csv); do
		
		line1=$(echo "$line" | tr -d "\n")
		line2=$(echo "$line1" | tr -d " ")
		line3=$(echo "$line2" | tr -d "\t")
		line4=$(echo "$line3" | tr -d "\r")

		if [ "$fileName" == "$line4" ]; then
			echo " "
			echo 'match found ASHLEY 4'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170215_NS500126_0658_AH7TLYBGX2/$dir s3://lincoln.harris-work/tCellGrab/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

echo "ASHLEY BUCKET 5"
# ASHLEY BUCKET - LOOP 5
for dir in $(aws s3 ls s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/${dir}); do
		if [[ $file = *".gz" ]]; then
			fileName=${file%__*}
			fileName1=$(echo "$fileName" | tr -d "/")
			fileName2=$(echo "$fileName1" | tr -d " ")
		fi
	done
	for line in $(cat tCellList.csv); do
		
		line1=$(echo "$line" | tr -d "\n")
		line2=$(echo "$line1" | tr -d " ")
		line3=$(echo "$line2" | tr -d "\t")
		line4=$(echo "$line3" | tr -d "\r")

		if [ "$fileName" == "$line4" ]; then
			echo " "
			echo 'match found ASHLEY 5'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/$dir s3://lincoln.harris-work/tCellGrab/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done


###########################################################
###########################################################
