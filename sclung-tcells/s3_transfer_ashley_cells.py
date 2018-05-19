#////////////////////////////////////////////////////////////////////
#////////////////////////////////////////////////////////////////////
# script: s3_transfer_ashley_cells.py
# author: Lincoln Harris & James Webber
# date: 5.19
#
# Script for transfering cells from one s3 bucket to another (or a 
# group of query s3 buckets), according to a list of cells of interest. 
#
# s3_util library was written by James (THANK YOU)
#////////////////////////////////////////////////////////////////////
#////////////////////////////////////////////////////////////////////
import s3_util
import os
import csv

#////////////////////////////////////////////////////////////////////
# getTCellFile()
#	args: myPath -> raw os path to tCell local file of interest (.csv)
#	returns: fPath -> python path to file of interest
#
# 	Just letting python know where our tCellFile is found
#////////////////////////////////////////////////////////////////////
def getTCellFile(myPath):
    # the actual file name
	fName = os.path.basename(myPath) 
    # the short path to that file
	sPath = os.path.dirname(myPath)
    # get full path to file
	fPath = os.path.join(sPath,fName)
    
	return fPath

#////////////////////////////////////////////////////////////////////
# getTCellSet()
#	args: myFile -> complete path to a local file (.csv) containing all
#					of the tCells we're interested in grabbing. 
#	returns: tSet -> a set (like a list, but hashed) of all the items
#				     in the input file
#	
#	Defining a set of all our tCells. 
#////////////////////////////////////////////////////////////////////
def getTCellSet(myFile):
	with open(myFile) as f:
		rdr = csv.reader(f)
		tSet = set(next(rdr))
        
	return tSet

#////////////////////////////////////////////////////////////////////
# engine()
#	args: myPrefix -> query bucket prefix (s3) to get all subdirs within
#		  myTCellSet -> set of tCells to search for
#		  myBucket -> name of the s3 parent bucket to search through 
#	returns: 
#		  f_to_move -> list of files in query bucket prefix to be moved
#		  res_files -> list of names of destination files...where we 
#					   want our new files to be stored
# 
#	Searches through s3 buckets for files contained w/in a list
#////////////////////////////////////////////////////////////////////
def engine(myPrefix, myTCellSet, myBucket):
	f_to_move = []
	res_files = []
	for query_dir in s3_util.get_files(bucket=myBucket, prefix=myPrefix):
		dir_split = query_dir.split("/")
		query_cell = dir_split[3]
		if query_cell in myTCellSet:
			f_to_move.append(query_dir)
			myStr = 'singlecell_lungadeno/tCells/' + query_cell + '/' + dir_split[4]
			res_files.append(myStr)
    
	return f_to_move, res_files

#////////////////////////////////////////////////////////////////////
# moveFiles()
#	args: mv -> list of file names to move (source)
#		  rs -> list of files to move to (destination)
#		  source_prefix -> s3 bucket to move files from
#	returns: NONE
#
#	Peforms the actual move, from one s3 bucket to another
#////////////////////////////////////////////////////////////////////
def moveFiles(mv, rs, source_prefix):
	s3_util.copy_files(mv, rs, source_prefix, 'darmanis-group', n_proc=16)

#////////////////////////////////////////////////////////////////////
# driverLoop()
#	args: pList -> list of prefixes w/in a parent s3 bucket
#		  tcSet -> set of tCells to search for
#		  cBucket -> parent s3 bucket
#	returns: NONE	
# 
#	Main logic here. Calls engine() to find files to move within query
#	bucket, then calls moveFiles() to do the move. 
#////////////////////////////////////////////////////////////////////
def driverLoop(pList, tcSet, cBucket):
	for i in range(len(pList)):
		currPre = pList[i]
		driver_out = engine(currPre, tcSet, cBucket)
		files_to_move = driver_out[0]
		results_files = driver_out[1]
		print(currPre)
		print("moving...")
		moveFiles(files_to_move, results_files, cBucket)
	return

#////////////////////////////////////////////////////////////////////
# main()
# 
#	scaffold for initiating lists & loops. Calls getTCellFile() and 
# 	getTCellSet() to define list of tCells to search for, then defines 
# 	lists of s3 prefixes to search our three parent s3 buckets for. 
# 	Then calls driverLoop to do all of the actual work. 
#
#////////////////////////////////////////////////////////////////////
  
tCellFile = getTCellFile("/Users/lincoln.harris/Desktop/ashleyTCells.csv")
tCellSet = getTCellSet(tCellFile)

# CZBIOHUB-SEQBOT
prefixList1 = ['fastqs/180226_A00111_0105_AH3KCHDSXX/rawdata','fastqs/180307_A00111_0109_BH3KCJDSXX/rawdata',
			'fastqs/180319_A00111_0119_AH3JYJDSXX/rawdata','fastqs/180320_NB501961_0086_AHLGLGBGX5/rawdata',
			'fastqs/180405_A00111_0129_BH3VFYDSXX/rawdata', 'fastqs/180423_A00111_0141_AH3VFNDSXX/rawdata']

# AMAYNARD-BUCKET
prefixList2 = ['170125_NS500126_0647_AHVHJ2BGXY', '170129_NS500126_0650_AHVM75BGXY', 
			'170202_NS500126_0653_AHVL5NBGXY', '170215_NS500126_0658_AH7TLYBGX2',
			'170504_NS500126_0691_AHC22JBGX2', '170508_NS500126_0693_AHC2MFBGX2',
			'170510_NB501938_0003_AHM7KMBGX2'] 

# LINCOLN.HARRIS-WORK
prefixList3 = ['171120_A00111_0085_AH57YYDMXX', '171120_A00111_0086_BH55NVDMXX']

print(" ")
print("LOOP 1")
driverLoop(prefixList1, tCellSet, 'czbiohub-seqbot')
print("done!")

print(" ")
print("LOOP 2")
driverLoop(prefixList2, tCellSet, 'amaynard-bucket')
print("done!")

print(" ")
print("LOOP 2")
driverLoop(prefixList3, tCellSet, 'lincoln.harris-work')
print("done!")

#////////////////////////////////////////////////////////////////////
#////////////////////////////////////////////////////////////////////



