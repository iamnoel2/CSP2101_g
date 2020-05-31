#!/bin/bash

#Instruct the user on different functions the script can perform
echo "Enter ALL to download everything."
echo "Enter a random number between 1 and 75 to download that number of random images."
echo "Enter between 99 to download images within a range."
echo "Enter 0 to exit"
echo "Enter a number between 1533 and 2042 to download a specific image."

#Prompt the user for input
read -p "Enter a number or ALL: " downloadnum

#make a directory for images if it doesn't already exist
if [ -d "images" ] 
then
    echo "Images directory already exists." 
else
    mkdir images
fi

#an if... function to check if input is as specified, otherwise the script won't run
if ! ((downloadnum >= 1 && downloadnum <= 75)) && [[ ${downloadnum} != "ALL" ]] && ! (( downloadnum == 99 )) && ! ((downloadnum >= 1533 && downloadnum <= 2042)) && ! (( downloadnum == 0 ));
    then
        echo "Sorry, input is invalid."
        bash a3-1.sh
else

#download ALL images
    if [[ ${downloadnum} == "ALL" ]] #if user input is "ALL"
    then
        # get web page
        curl 'https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152' -o '#1.html'

        # get all images URLs
        grep -oh 'https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/.*jpg' *.html >urls.txt

        # download all images
        sort -u urls.txt | wget -i- -P images -N

        bash a3-1.sh

#download random number of images
    elif ((downloadnum >=1 && downloadnum <= 75)) #if user is between 1 and 75
    then
            curl 'https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152' -o '#1.html'

            grep -oh 'https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/.*jpg' *.html >urls.txt #get images URL into a file

            array=($(<urls.txt)) #save the URLs into an array

            # Seed random generator
            RANDOM=$$$(date +%s)

        for ((i = 1; i <= downloadnum; i++)) #a for.. loop that repeats based on the user's input
        do
            simg=${array[$RANDOM % ${#array[@]} ]} #Pick a random URL from the array and save to variable 'simg'
            wget -r -A jpg,jpeg -P images -nd -N $simg #download the image from the simg URL
        done

        bash a3-1.sh

#download a range of images
    elif (( downloadnum == 99 ))
    then
        #Taking lower range input
        echo "Enter lower range (1533 to 2041): "
        read lowDSC

        #taking upper range input
        echo "Enter upper range (1534 to 2042): "
        read highDSC

        #running a while loop till lower range not equal to upper range
        while [ $lowDSC -ne $highDSC ]
        do
        #download images starting from lower range
        wget -r -A jpg,jpeg -P images -N -nd https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$lowDSC.jpg
        
        #incrementing lower range to specified high range by increments of 1
        lowDSC=`expr $lowDSC + 1`
        done

        bash a3-1.sh
    
#download one specific image.
    elif ((downloadnum >= 1533 && downloadnum <= 2042)) #if user input is between 1533 and 2042
    then
        wget -r -A jpg,jpeg -P images -N -nd https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$downloadnum.jpg #use the user input variable to download image

        filename=/images/DSC0$downloadnum.jpg
        filesize=$(du -k "$filename")
        echo "Downloading DSC0$downloadnum with the file name DSC0$downloadnum.jpg, with a file size of $filesize"

        bash a3-1.sh
        
    elif (( downloadnum == 0 )) #check if user input is 0
    then
        exit 0 
    fi
fi

#wget -r for recursive download
#wget -A jpg,jpeg for accept list, only accept jpg and jpeg files
#wget -P images saves the downloaded images in to the images directory
#wget -N used for timestamping to avoid duplicated files
#wget -nd used for downloading the files without their directoies

#        filename=images/DSC0$downloadnum.jpg
#        filesize=$(stat -c%s "$FILENAME") filesize=$(du -k "$filename")
#        echo "Size of $FILENAME = $FILESIZE bytes."
#
#        echo " "
#        echo "Downloading DSC0$downloadnum with the file name DSC0$downloadnum.jpg, with a file size of $filesize"
#        echo " "
# Tried using stat and du approach alongside -q on wget to echo file name and file size.