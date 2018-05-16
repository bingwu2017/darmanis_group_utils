
#####################################################################
#####################################################################
### script: tracer_run_script.sh
### author: Lincoln Harris
### date: 5.7.18
###
### Run this from a dir (runDir) that is set up as follows: 
###		runDir
###			cell1
###				R1.fastq
###				R2.fastq
###			cell2
###				R1.fastq
###				R2.fastq
###
###	make sure to run this on m4.10x...or else specify fewer cores
#####################################################################
#####################################################################
#!/bin/bash

echo " "
for dir in *; do
	cd /home/ubuntu/wrkDir/07-tracer1/tCells1/$dir
	touch myLog
	#echo $dir
	echo "running..."
	docker run -it --rm -v $PWD:/scratch -w /scratch teichlab/tracer \
	assemble --ncores 30 --species Hsap *_R1_001.fastq *_R2_001.fastq \
	$dir ${dir}_outDir >& myLog
	echo "finished"
	echo " "
	cd ..
done

#####################################################################
#####################################################################
