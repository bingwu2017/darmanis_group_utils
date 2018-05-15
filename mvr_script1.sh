
###########################################################
###########################################################
### mvr_script1.sh
### 2.2.18
###
### Trying to move cells from different s3 buckets to a
### shared out bucket, according to a list of desired cells.
###########################################################
###########################################################
!/bin/bash

#170125_NS500126_0647_AHVHJ2BGXY - LOOP 1
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
			aws s3 cp s3://amaynard-bucket/170125_NS500126_0647_AHVHJ2BGXY/$dir s3://lincoln.harris-work/tCellGrab/170125_NS500126_0647_AHVHJ2BGXY/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#170129_NS500126_0650_AHVM75BGXY - LOOP 2
echo "170129_NS500126_0650_AHVM75BGXY"
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
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170129_NS500126_0650_AHVM75BGXY/$dir s3://lincoln.harris-work/tCellGrab/170129_NS500126_0650_AHVM75BGXY/$fileName2 --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#170202_NS500126_0653_AHVL5NBGXY - LOOP 3
echo "170202_NS500126_0653_AHVL5NBGXY"
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
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170202_NS500126_0653_AHVL5NBGXY/$dir s3://lincoln.harris-work/tCellGrab/170202_NS500126_0653_AHVL5NBGXY/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#170215_NS500126_0658_AH7TLYBGX2 - LOOP 4
echo "170215_NS500126_0658_AH7TLYBGX2"
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
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170215_NS500126_0658_AH7TLYBGX2/$dir s3://lincoln.harris-work/tCellGrab/170215_NS500126_0658_AH7TLYBGX2/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#170504_NS500126_0691_AHC22JBGX2 - LOOP 5
echo "170504_NS500126_0691_AHC22JBGX2"
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
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/$dir s3://lincoln.harris-work/tCellGrab/170504_NS500126_0691_AHC22JBGX2/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#170508_NS500126_0693_AHC2MFBGX2 - LOOP 6
echo "170508_NS500126_0693_AHC2MFBGX2"
for dir in $(aws s3 ls s3://amaynard-bucket/170508_NS500126_0693_AHC2MFBGX2/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://amaynard-bucket/170508_NS500126_0693_AHC2MFBGX2/${dir}); do
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

		if [ "$fileName" == "$line" ]; then
			echo " "
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/$dir s3://lincoln.harris-work/tCellGrab/170508_NS500126_0693_AHC2MFBGX2/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#170510_NB501938_0003_AHM7KMBGX2 - LOOP 7
echo "170510_NB501938_0003_AHM7KMBGX2"
for dir in $(aws s3 ls s3://amaynard-bucket/170510_NB501938_0003_AHM7KMBGX2/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://amaynard-bucket/170510_NB501938_0003_AHM7KMBGX2/${dir}); do
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

		if [ "$fileName" == "$line" ]; then
			echo " "
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/$dir s3://lincoln.harris-work/tCellGrab/170510_NB501938_0003_AHM7KMBGX2/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#171120_A00111_0085_AH57YYDMXX - LOOP 8
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
			aws s3 cp s3://lincoln.harris-work/171120_A00111_0085_AH57YYDMXX/$dir s3://lincoln.harris-work/tCellGrab/171120_A00111_0085_AH57YYDMXX/$dir --recursive
			echo " "
		fi
	done
done

#171120_A00111_0086_BH55NVDMXX - LOOP 9
echo "171120_A00111_0086_BH55NVDMXX"
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
			echo 'match found'
			echo $line4
			aws s3 cp s3://lincoln.harris-work/171120_A00111_0086_BH55NVDMXX/$dir s3://lincoln.harris-work/tCellGrab/171120_A00111_0086_BH55NVDMXX/$dir --recursive
			echo " "
		fi
	done
done

#180226_A00111_0105_AH3KCHDSXX - LOOP 10
echo "180226_A00111_0105_AH3KCHDSXX"
for dir in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180226_A00111_0105_AH3KCHDSXX/rawdata | awk '{print $2}'); do
	for file in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180226_A00111_0105_AH3KCHDSXX/rawdata${dir}); do
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

		if [ "$fileName" == "$line" ]; then
			echo " "
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/$dir s3://lincoln.harris-work/tCellGrab/180226_A00111_0105_AH3KCHDSXX/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#180307_A00111_0109_BH3KCJDSXX - LOOP 11
echo "180307_A00111_0109_BH3KCJDSXX"
for dir in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180307_A00111_0109_BH3KCJDSXX/rawdata/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180307_A00111_0109_BH3KCJDSXX/rawdata/${dir}); do
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

		if [ "$fileName" == "$line" ]; then
			echo " "
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/$dir s3://lincoln.harris-work/tCellGrab/180307_A00111_0109_BH3KCJDSXX/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#180319_A00111_0119_AH3JYJDSXX - LOOP 12
echo "180319_A00111_0119_AH3JYJDSXX"
for dir in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180319_A00111_0119_AH3JYJDSXX/rawdata/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180319_A00111_0119_AH3JYJDSXX/rawdata/${dir}); do
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

		if [ "$fileName" == "$line" ]; then
			echo " "
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/$dir s3://lincoln.harris-work/tCellGrab/180319_A00111_0119_AH3JYJDSXX/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#180320_NB501961_0086_AHLGLGBGX5 - LOOP 13
echo "180320_NB501961_0086_AHLGLGBGX5"
for dir in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180320_NB501961_0086_AHLGLGBGX5/rawdata/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180320_NB501961_0086_AHLGLGBGX5/rawdata/${dir}); do
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

		if [ "$fileName" == "$line" ]; then
			echo " "
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/$dir s3://lincoln.harris-work/tCellGrab/180320_NB501961_0086_AHLGLGBGX5/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#180405_A00111_0129_BH3VFYDSXX - LOOP 14
echo "180405_A00111_0129_BH3VFYDSXX"
for dir in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180405_A00111_0129_BH3VFYDSXX/rawdata/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180405_A00111_0129_BH3VFYDSXX/rawdata/${dir}); do
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

		if [ "$fileName" == "$line" ]; then
			echo " "
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/$dir s3://lincoln.harris-work/tCellGrab/180405_A00111_0129_BH3VFYDSXX/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done

#180423_A00111_0141_AH3VFNDSXX - LOOP 15
echo "180423_A00111_0141_AH3VFNDSXX"
for dir in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180423_A00111_0141_AH3VFNDSXX/rawdata/ | awk '{print $2}'); do
	for file in $(aws s3 ls s3://czbiohub-seqbot/fastqs/180423_A00111_0141_AH3VFNDSXX/rawdata/${dir}); do
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

		if [ "$fileName" == "$line" ]; then
			echo " "
			echo 'match found'
			echo $line4
			aws s3 cp s3://amaynard-bucket/170504_NS500126_0691_AHC22JBGX2/$dir s3://lincoln.harris-work/tCellGrab/180423_A00111_0141_AH3VFNDSXX/$dir --recursive --exclude '*' --include '*.gz'
			echo " "
		fi
	done
done
###########################################################
###########################################################
