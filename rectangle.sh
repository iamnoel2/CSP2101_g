#!/bin/bash
#Kuan Hay CHUA 10488932

if ! [ -f rectangle_f.txt ] ; then
    rm rectangle_f.txt 
fi

    sed -r -e '1h;1d;G;s/^/,/;:a;s/,\s*(.*\n)([^,]+),/\2: \1/;ta;P;d' rectangle.txt | column -t | tee rectangle_f.txt 
        
exit 0

#-r for back referencing

#-e for multiple arguments

#1h;1d;G; used for copying the header to temporary hold space

#:a Append the header to each detail line.

#s/,\s*(.*\n)([^,]+),/\2: \1/ Prepend a comma to the start of the line.

#ta create a substitution loop that replaces the first comma by the first heading in the appended header.

#When all the commas have been replaced, print the first line and delete the rest.

#To display in table, column command with the -t option.