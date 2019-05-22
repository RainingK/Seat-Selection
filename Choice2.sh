#!/bin/bash

#choice 2 file
#declaring arrays
declare -A storeclose
declare -A storeseats
declare -A matrix


i=1
j=1
countX=0
#display function
func()
{ 	
if test $y -eq 1
then
	echo "You got seat A$x"
elif test $y -eq 2
then
	echo "You got seat B$x"
elif test $y -eq 3
then
	echo "You got seat C$x"
elif test $y -eq 4
then
	echo "You got seat D$x"
elif test $y -eq 5
then
	echo "You got seat E$x"
fi
}

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
#reads from redo file to display optimum pattern
while read line; do
	matrix[$i,$j]="$line"
	j=$(($j+1))
	if test $j -eq 6
	then
		i=$(($i+1))
		j=1
	fi
done < redo.txt

countX=0

#read the movie chosen file to replace the seats taken with an X
while read line; do 
i="$(echo $line | cut -b1)"
j="$(echo $line | cut -b2)"
echo "i is: $i j is: $j"
matrix[$i,$j]='X'
	j=$(($j+1))
	if test $j -eq 6
	then
		i=$(($i+1))
		j=1
	fi
countX=$(($countX + 1))

done < $movie$opt.txt

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
red=$(echo -e "\e[0;31mX\e[0m")
blue=$(echo -e "\e[0;34mX\e[0m")

f2=" %8s"
f3="%11s"
#displays the cinema
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




f2=" %9s"

declare -A matrix

f2=" %8s"
f3="%11s"
#check available seats
available=$((20-$countX))
echo "Total Seats Available Are : $available"

val=0
echo "Enter Number Of Seats"
read seats
#validation for seats
if test "$seats" -gt "$available"
then
	echo "Seats Not Available"
	exit
fi

a=0
#assign the empty optimum seat to X
for z in 1 2 3 4 5 6
do
for x in 1 2 3 4
do
	for y in 1 2 3 4 5
	do
		if test "${matrix[$x,$y]}" == $val
		then
			a=$(($a+1))
			if test $a -gt $seats
			then
				break
			fi
			matrix[$x,$y]='X'
			func $x $y 
		fi
	done
done
val=$(($val+1))
done

echo

echo "Your total bill is: "
echo "$(( 15 * $seats))"

>$movie$opt.txt
#write it to the file to update it
for i in 1 2 3 4
do
	for j in 1 2 3 4 5
	do
		if test "${matrix[$i,$j]}" == 'X'
		then
			echo "$i$j" >> $movie$opt.txt
		fi	
	done
	echo
done

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
red=$(echo -e "\e[0;31mX\e[0m")
blue=$(echo -e "\e[0;34mX\e[0m")

f2=" %8s"
f3="%11s"


