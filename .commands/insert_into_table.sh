#! /bin/bash

echo "Enter table name: "
read tableName
if [ -f $tableName ]
then
    #number of cols
    colsNum=`awk 'END{ print NR }' .$tableName`
    sep="|"
    rSep="\n"
    # looping through the metadata table starting from the 2nd line to retrieve the cols name/type/if PKey
    for (( i = 2; i <= $colsNum; i++ ))
    do
        colName=`awk -F "|" '{ if(NR=='$i') print $1}' .$tableName`
        colType=`awk -F "|" '{ if(NR=='$i') print $2}' .$tableName`
        colKey=`awk -F "|" '{ if(NR=='$i') print $3}' .$tableName`


        echo -e "$colName($colType)= \c"
        read data

    
        #validating PK
        #cant be null and must be unique
        while [[ $colKey == "PK" ]]
        do
            while  [[ $data == "" ]]
            do
                echo -e "Primary Key can't be NULL!"
                echo -e "$colName($colType) = \c"
                read data
	        done
            while [[ true ]]
            do
                if [[ $data =~ ^[`awk 'BEGIN{FS="|"}{if(NR != 1)print $(('$i'-1))}' $tableName`]$ ]]
                then
                    echo -e "Primary Key must be unique!"
                else
                    break;
                fi
                echo -e "$colName ($colType) = \c"
                read data
            done
            break
        done

        # validating the int 
        if [[ $colType == "int" ]]
        then
            while ! [[ $data =~ ^[0-9]+$  ]]
            do
                #allowing the user to not enter a value as long as it's not PK
                if [[ $data == "" ]]
                then
                    break;
                else
                    echo -e "Invalid datatype!"
                    echo -e "$colName($colType) = \c"
                    read data
                        while [[ $colKey == "PK" ]]
                        do
                            while  [[ $data == "" ]]
                            do
                                echo -e "Primary Key can't be NULL!"
                                echo -e "$colName($colType) = \c"
                                read data
	                        done
                            while [[ true ]]
                            do
                                if [[ $data =~ ^[`awk 'BEGIN{FS="|" ; ORS=" "}{if(NR != 1)print $(('$i'-1))}' $tableName`]$ ]]
                                then
                                    echo -e "Primary Key must be unique!"
                                else
                                    break;
                                fi
                                echo -e "$colName ($colType) = \c"
                                read data
                            done
                            break
                        done
                fi
	        done
        fi
        #create record
        if [[ $i == $colsNum ]]
        then
            record=$record$data$rSep
        else
            record=$record$data$sep
        fi
    done

    #inserting record
    echo -e $record"\c" >> $tableName
    echo "Data Inserted Successfully"
else
    #if table not found
    echo "doesn't exist"
fi




	