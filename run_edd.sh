#!/bin/bash
# Usage:
# ./run_EDD.sh <input_data_file.csv>

# assign variable for input data file
input_data=$1
echo
echo The input data set is: $input_data

# determine the number of columns in the input data file
num_columns=$( head -1 $input_data | tr ',' '\n' | wc -l)
echo
echo Input data set contains this number of columns: $num_columns


# loop through columns, create temp file, process with python
for column in $(seq 1 $num_columns); do
	echo
	echo Working on column number: $column

    echo Creating outputfile
	outfile="column_${column}_tempfile.txt"

	# pull out current column from input data file (tried awk, difficult w/ var cols)
	cut -d, -f $column $input_data >> $outfile

	# run python script
	python EDD.py data_types.csv $outfile

	echo
done

# directory maintenance
rm *tempfile*

