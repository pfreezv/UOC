#!/usr/bin/env bash
# 
 
 
INPUT=./phpOJxGL9.csv
 
# Save the current internal field separator to restore it at the end
OLDIFS=$IFS
 
 
IFS=','
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
 
FIRST=0 # flag, to skip the header when is 0
 
unset men
unset women
# In this way, for each line, each field is stored in a variable with a
# name easy to identify
while read age gender total direct alkphos sgpt sgot proteins albumin ratio class
do
    if [ $FIRST -eq 0 ];then  # If it is the first line, ignore it and change the flag
        FIRST=1
    else        
        
       
        
        # Check if the two variables are set
        if [ -z "$gender" ] || [ -z "$albumin" ]; then
            echo "gender or proteins missing"
            echo
            echo
        else
            if [ "$albumin" = "3" ]; then
                VAL="$age,$gender,$albumin, $proteins"          
                if [ "$gender" = "Male" ]; then
                    men[${#men[@]}]=$VAL   # pg 55 ProBashPrograming
                else
                    women[${#women[@]}]=$VAL
                fi
            fi
        fi 
        
        
    fi
    
            
done < $INPUT
echo
echo "Albumin = 3"
echo "Age Sex Albumin Proteins"
echo "***********"
echo
echo "Women"
echo "--------------" 
printf '%s\n' "${women[@]}"
 
echo
echo "Men"
echo "--------------" 
printf "%s\n" "${men[@]}"
echo
 
 
IFS=$OLDIFS
