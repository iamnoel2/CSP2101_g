#!/bin/bash 
#Kuan Hay CHUA 10488932

#Generate a random number ranging from 1 to 70
randomage=$(( ( RANDOM % 70 )  + 1 ))

#Delete line below for submission
echo "$randomage"

#Prompt the user for input
read -p "Guess Barry's age: " answer

#Nested If.. Else statement is used to check for the error handling and answer range whether it is correct or not.
if ! [[ "$answer" =~ ^[0-999]+$ ]]  #check if input is integer. Able to check for decimals, string and empty input. Input must be within a range of 0 to 999.
    then
        echo "Sorry, integers only!" #Tells the user imput is not an integer
else
    if [[ $answer -gt $randomage ]]  #-gt is used to identify that one variable us GREATER THAN the other. In this this case, variable answer is GREATER THAN variable random age.
    then
        echo "Guess is too high!" #Tells the user the input number was too high
    elif [[ $answer -lt $randomage ]]  #-lt is used to identify that variable anser is LESS THAN variable random age.
    then
        echo "Guess is too low!"  #Tells the user the input number was too low.
    elif [[ $answer == $randomage ]]  #== is used to identify that variable answer is exactly EQUAL TOvariable random age.
    then
        echo "Correct!" #Tells the user their guess is correct.
    fi  #End the nested if statement from Line 18.
fi #End the if statement from Line 14.
exit 0