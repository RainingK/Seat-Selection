#!/bin/bash

#main program
#Ammar, Saarah ,Ruqaiya

myfunc(){  #function for formatting and to make it easy for user to navigate.
	echo
	echo "************************************************"
	echo "1) Go To Menu"
	echo "2) Exit"
	read num
	if test "$num" -eq 1
	then
		echo "************************************************"
	elif test "$num" -eq 2
	then
		exit
	fi
}


num=0
#go through all options according to what user types
while test $num -ne 5
do
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
echo -e "\\E[4;31;43m$(tput cuf 12)ROCKY Theatre's Self-Service Ticketing\\E[0m" 
echo -e "${BLUE}1) List of all Movies and Show times"
echo -e "${BLUE}2) Fast booking (where system will automatically select best seat)"
echo -e "${BLUE}3) To select theatre’s seat manually"
echo -e "${BLUE}4) Search by Movie title"
echo -e "${BLUE}5) Quit\\E[0m"

read num 
re='^[0-9]+$'
if ! [[ $num =~ $re ]] ; then
   echo "error: Not a number" >&2; ./Main.sh #validation check for special characters, strings.


elif test $num -eq 1 #if user selectes choice 1
then
echo -e "\\E[4;31;43m$(tput cuf 12)ROCKY Theatre's Screening Movies\\E[0m" 
awk -F "," ' { t = $1; $1 = $2; $2 = t; print $1 " \t" $2 " \t" $3; } ' choice.txt > column.txt
sed -e 's/No/SOLD OUT/g; s/Yes/Ticket Available/g ' column.txt
myfunc 

elif test $num -eq 3 #if user selectes choice 3
then
./Choice3.sh
myfunc

elif test $num -eq 2 #if user selectes choice 2
then
./Choice2.sh
myfunc

elif test $num -eq 4 #if user selectes choice 4
then 
./Choice4.sh
myfunc


elif test $num -eq 5 #if user selectes choice 5
then

exit 1

else 
	echo "Invalid Choice, enter again"
	

fi
done

