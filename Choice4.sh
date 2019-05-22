#!/bin/bash

#choice 4 file
echo "************************************************"
option=""
while [[ ! $option =~ ^[1-2]+$ ]]; do
echo "Search by:"
echo "1) Movie Title"
echo "2) Show Timings"
echo "3) Quit"
read option

echo

#depending on users input, file is searched.
if [[ ! $option =~ ^[1-3]+$ ]]
then
echo "invalid choice!, enter again"
elif test $option -eq 1
then
	echo "Enter Title"
	read title
	echo "[Movie Title] 	[Showtimes] 	[Vacancy]"
	grep -i $title column.txt
elif test $option -eq 2
then
	echo "Enter Timings"
	read timing
	echo "[Movie Title] 	[Showtimes] 	[Vacancy]"
	egrep -i $timing column.txt
else
	
	./Main.sh
fi
done
