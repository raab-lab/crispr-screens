#!/bin/bash

DIR=$1

if [[ ! -d "$DIR" ]]
then
	echo "Fastq inventory not found."
	exit 1
else

	HEADER="R1,SampleID,Cell Line,Treatment,Replicate"
	echo $HEADER > samplesheet.csv

	for R1 in ${DIR}/*R1_001.fastq.gz; do
		lib_id=$(basename $R1 | sed 's/_.*//')

		pR1=$(realpath $R1)

		## build samplesheet
		echo $pR1,$lib_id,,, >> samplesheet.csv

	done

fi
