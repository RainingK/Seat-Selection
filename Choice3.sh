#!/bin/bash
#chocie 3 file
#declare arrays
declare -A matrix
declare -A ArrRow
declare -A ArrCol
rows=4
col=5

echo "************************************************"
opt=""
while [[ ! $opt =~ ^[1-3]+$ ]]; do
   echo "Choose movie: "
echo "1. UnderCovers"
echo "2. RoboCop"
echo "3. Predators"
    read opt
if [[ ! $opt =~ ^[1-3]+$ ]]
then
echo "invalid choice!, enter again"
fi
done

echo
echo

movie="movie"

takenSeats=0
#reads the movie chosen file to display the updated cinema
while read line; do 
i="$(echo $line | cut -b1)"
j="$(echo $line | cut -b2)"
takenSeats=$(($takenSeats+1))
echo "i is: $i j is: $j"
matrix[$i,$j]='X'
	j=$(($j+1))
	if test $j -eq 6
	then
		i=$(($i+1))
		j=1
	fi

done < $movie$opt.txt

echo "Taken Seats Are : $takenSeats"

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
red=$(echo -e "\e[0;31mX\e[0m")
blue=$(echo -e "\e[0;34mX\e[0m")

f2=" %8s"
f3="%11s"
f4="%10s"
#displays cinema
echo -e "\\E[7;49;90m$(tput cuf 12)               SCREEN                 \\E[0m" 
printf ' '
printf "$f3" 'A'
printf "$f3" 'B'
printf "$f3" 'C'
printf "$f3" 'D'
printf "$f3" 'E'
echo

for i in 1 2 3 4
do
	
	for j in 1 2 3 4 5
	do
		if test "${matrix[$i,$j]}" != "X"
		then
			matrix[$i,$j]=' '
			
		fi
	done
	
done

a=0


for i in 1 2 3 4
do
	printf $i
	for j in 1 2 3 4 5
	do
		printf "${RED}$f4${matrix[$i,$j]}\\E[0m"
		
	done
	echo
done

seatsAvailable=$((20 - $takenSeats))
#seats avaiable validation and display
echo "Seats Available Are $seatsAvailable"

echo "Enter Number Of Seats" 
read no_seats

while test "$no_seats" -gt "$seatsAvailable"
do
	echo "Not Enough Sets Available"
	echo "Enter Number Of Seats" 
	read no_seats
done

i=0
#depending on the number of seats itll ask the user to input rows and coloumns.
while test $i -lt $no_seats
do
seat_col=""
while [[ ! $seat_col =~ ^[A-Ea-e]+$ ]]; do
echo "Choose Your Seat Column[A-E]"
read seat_col
if [[ ! $seat_col =~ ^[A-Ea-e]+$ ]]
then
echo "invalid choice!, enter again"
fi
done
echo "Choose Your Seat Row[1-4]"
read seat_row

while test "$seat_row" -gt 4
do
	echo "Invalid Seat."
	echo "Enter Seat Again."
	read seat_row
done
#for upper and lower validation
if  test "$seat_col" == "A" -o "$seat_col" == "a"
then
	seat_col=1
elif test "$seat_col" == "B" -o "$seat_col" == "b"
then
	seat_col=2
elif test "$seat_col" == "C" -o "$seat_col" == "c"
then
	seat_col=3
elif test "$seat_col" == "D" -o "$seat_col" == "d"
then
	seat_col=4
elif test "$seat_col" == "E" -o "$seat_col" == "e"
then
	seat_col=5
else 
	echo "Invalid Seat"
exit 
fi

#seat validation
if test "${matrix[$seat_row,$seat_col]}" == "$blue"
then
	echo "Seat Taken."
	echo "Enter Another Seat."
	
	while test "${matrix[$seat_row,$seat_col]}" == "$blue"
	do
		echo "Choose Your Seat Column[A-E]"
		read seat_col
		if [[ ! $seat_col =~ ^[A-Ea-e]+$ ]]
		then
			echo "invalid choice!, enter again"
		fi
	done
	echo "Choose Your Seat Row[1-4]"
	read seat_row

	echo "Seat Row Is : $seat_row"

	while test "$seat_row" -gt 4
	do
		echo "Invalid Seat."
		echo "Enter Seat Again."
		read seat_row
	done
else
	echo "Seat Found."
	matrix[$seat_row,$seat_col]="$blue"
fi
i=`expr $i + 1`

done
#displays updated cinema
echo -e "\\E[7;49;90m$(tput cuf 12)               SCREEN                 \\E[0m" 
printf ' '
printf "$f3" 'A'
printf "$f3" 'B'
printf "$f3" 'C'
printf "$f3" 'D'
printf "$f3" 'E'
echo

for i in 1 2 3 4
do
	printf $i
	for j in 1 2 3 4 5
	do
		printf "${RED}$f2 ${matrix[$i,$j]}\\E[0m"
	done
	echo
done

#dsplays bill amount

echo "Your total bill is: "
echo "$(( 10 * $no_seats))"

>$movie$opt.txt
#writes the updated cinema to file.
for i in 1 2 3 4
do
	for j in 1 2 3 4 5
	do
		if test "${matrix[$i,$j]}" == 'X' -o "${matrix[$i,$j]}" == "$blue"
		then
			echo "$i$j" >> $movie$opt.txt
		fi	
	done
	echo
done



