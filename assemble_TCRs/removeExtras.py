#////////////////////////////////////////////////////////////////////
#////////////////////////////////////////////////////////////////////
# script: removeExtras.py 
# author: Lincoln Harris
# date: 7.18.18
#
# Checks to make sure there are no duplicated or extraneous fastq
# files in our cell directories, as these seem to confuse my Tracer
# workflow. 
# HELL YEAH I THINK THIS WORKS!!!
#////////////////////////////////////////////////////////////////////
#////////////////////////////////////////////////////////////////////
import os
import hashlib
import glob

#////////////////////////////////////////////////////////////////////
# remove_extraneous()
# 	I think this will work!!
#	If i find multiple files matching either glob, it picks one of 
# 	them and removes the other
# 	
#////////////////////////////////////////////////////////////////////
def remove_extraneous(dir):
	f1 = glob.glob(dirPath + '/' + '*R1_001.fastq')
	f2 = glob.glob(dirPath + '/' + '*R2_001.fastq')

	try:
		print(f1)
		print(f2)
		#os.remove(f1[1])
		#os.remove(f2[1])
		print("duplicate found!")
	except IndexError:
		print("no dups")

#////////////////////////////////////////////////////////////////////
# remove_duplicates()
# 	Found on stack overflow!!
# 	Uses hashlib to remove duplicate file names...some how
#////////////////////////////////////////////////////////////////////
def remove_duplicates(dir):
    unique = []
    for filename in os.listdir(dir):
        if os.path.isfile(filename):
            filehash = hashlib.md5(file(filename).read()).hexdigest()
        if filehash not in unique: 
            unique.append(filehash)
        else: 
            os.remove(filename)

#////////////////////////////////////////////////////////////////////
# main()
#	just looping over every subdir in the parent directory
#
#////////////////////////////////////////////////////////////////////
PATH = '/home/ubuntu/sandbox_expansion/08-newTCells7.19'

for dir in os.listdir(PATH):
	dirPath = PATH + '/' + dir

	try:
		num = len(os.listdir(dirPath))
		if(num != 2):
			#remove_duplicates(dirPath)
			remove_extraneous(dirPath)
			continue
		else:
			continue
	
	except NotADirectoryError:
		continue

#////////////////////////////////////////////////////////////////////
#////////////////////////////////////////////////////////////////////
