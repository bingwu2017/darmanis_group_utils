#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
# script: findChimericReads_test.py
# author: Lincoln Harris
# date: 6/18/18
#
# This script searches a directory full of BLAST output files and returns
# the names of cells that contain chimeric reads ie. cells such that for
# a given read pair, one read matches geneA, and the other matches geneB.
# Right now configured for Alk/Eml4 searches. 
#
# Want to run this on a directory I've seen chimeric reads for in the
# past. 
#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
import os
import io
import sys

#/////////////////////////////////////////////////////////////////////
# findReadPairs(): Searches for common elements between two lists
#	args ->
#		l1, l2 - two lists
#	returns ->
#		shared -  the common elements between these two lists
#
#/////////////////////////////////////////////////////////////////////
def findReadPairs(l1, l2):

	l1_new = []
	for line1 in l1:
		newLine1 = line1.split(" ")[0]
		l1_new.append(newLine1)

	l2_new = []
	for line2 in l2:
		newLine2 = line2.split(" ")[0]
		l2_new.append(newLine2)

	l1_set = set(l1_new)
	l2_set = set(l2_new)

	shared = l1_set.intersection(l2_set)

	return shared

#/////////////////////////////////////////////////////////////////////
# findHitSeqs(): Searches through a BLAST out file and returns a list 
#				of all of the sequences IDs that yielded a hit
#	args -> 
#		fileName - a BLAST output file (positive hit) to grab the 
#					sequence IDs corresponding to the hits for
#	returns ->
#		readsList - a list of the reads that yielded a BLAST hit
#
#/////////////////////////////////////////////////////////////////////
def findHitSeqs(fileName):
	readsList = []
	f = open(fileName, 'r')
	flines = f.readlines()
	for line in flines:
		# find corresponding read IDs
		if '>' in line:
			addLine = line.replace('\n', '')
			readsList.append(addLine)

	return readsList

#/////////////////////////////////////////////////////////////////////
# main():
#	Launches a loop over each subdir in the working directory, then
#	defines path to BLAST out files, calls findHitSeqs to get lists of
#	the sequences corresponding to BLAST hits for Alk or Eml4, then 
#	calls findReadPairs to search for chimeric reads. Prints to terminal
#	if chimeric read is found. 
#
#/////////////////////////////////////////////////////////////////////

PATH = '/home/ubuntu/expansionVol/03-fusionMessingAround/180307_A00111_0109_BH3KCJDSXX_copy'
#PATH = '/home/ubuntu/expansionVol/03-fusionMessingAround/17504_clean'

for dir in os.listdir(PATH):
	dirPath = PATH + '/' + dir

	f1 = dirPath + '/' + dir + '_' + 'alk_R1_blastOut'
	f2 = dirPath + '/' + dir + '_' + 'alk_R2_blastOut'
	f3 = dirPath + '/' + dir + '_' + 'eml4_R1_blastOut'
	f4 = dirPath + '/' + dir + '_' + 'eml4_R2_blastOut'

	f1Hits = []
	f2Hits = []
	f3Hits = []
	f4Hits = []

	try:
		if 'Sequences producing significant alignments:' in open(f1).read():
			f1Hits = findHitSeqs(f1)
		if 'Sequences producing significant alignments:' in open(f2).read():
			f2Hits = findHitSeqs(f2)
		if 'Sequences producing significant alignments:' in open(f3).read(): 
			f3Hits = findHitSeqs(f3)
		if 'Sequences producing significant alignments:' in open(f4).read(): 
			f4Hits = findHitSeqs(f4)

	except NotADirectoryError:
		continue

	alk_hits = f1Hits + f2Hits
	eml4_hits = f3Hits + f4Hits

	chimReads = findReadPairs(alk_hits, eml4_hits)
	if(chimReads):
		print(" ")
		print("Found %d chimeric reads found in cell %s" % (len(chimReads), dir))
		print(chimReads)

print(" ")

#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////