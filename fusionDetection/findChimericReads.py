#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////
# script: findChimericReads.py
# author: Lincoln Harris
# date: 6/18/18
#
# This script searches a directory full of BLAST output files and returns
# the names of cells that contain chimeric reads ie. cells such that for
# a given read pair, one read matches geneA, and the other matches geneB.
# Right now configured for Alk/Eml4 searches. 
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
	l1_set = set(l1)
	l2_set = set(l2)
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

PATH = '/home/ubuntu/expansionVol/03-fusionMessingAround/15704_clean'

for dir in os.listdir(PATH):
	dirPath = PATH + '/' + dir

	f1 = dirPath + '/' + dir + '_' + 'alk_R1_blastOut'
	f2 = dirPath + '/' + dir + '_' + 'alk_R2_blastOut'
	f3 = dirPath + '/' + dir + '_' + 'eml4_R1_blastOut'
	f4 = dirPath + '/' + dir + '_' + 'eml4_R2_blastOut'

	f1_hit = False
	f2_hit = False
	f3_hit = False
	f4_hit = False

	try:
		if 'Sequences producing significant alignments:' in open(f1).read():
			f1Hits = findHitSeqs(f1)
			f1_hit = True
		if 'Sequences producing significant alignments:' in open(f2).read():
			f2Hits = findHitSeqs(f2)
			f2_hit = True
		if 'Sequences producing significant alignments:' in open(f3).read(): 
			f3Hits = findHitSeqs(f3)
			f3_hit = True
		if 'Sequences producing significant alignments:' in open(f4).read(): 
			f4Hits = findHitSeqs(f4)
			f4_hit = True

	except NotADirectoryError:
		continue

	if f1_hit & f3_hit:
		chimReads1 = findReadPairs(f1Hits, f3Hits)
		if(chimReads1):
			print(" ")
			print("%d forward chimeric reads found in cell %s" % (len(chimReads1), dir))
			print(chimReads1)
	if f2_hit & f4_hit:
		chimReads2 = findReadPairs(f2Hits, f4Hits)
		if(chimReads2):
			print(" ")
			print("%d reverse chimeric reads found in cell %s" % (len(chimReads2), dir))
			print(chimReads2)

print(" ")

#/////////////////////////////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////