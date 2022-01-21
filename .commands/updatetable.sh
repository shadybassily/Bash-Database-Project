#! /bin/bash

echo -e "Enter Table Name: \c"
read tableName
if ! [[ -f $tableName ]]
then
    echo "Table doesn't exist"
else
    echo -e "search by: \c"
    read field

    fieldID=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tableName)
    if [[ $fieldID == "" ]]
    then
        echo "Not Found"
    else
        echo -e "Enter a value: \c"
        read val
        res=$(awk 'BEGIN{FS="|"}{if ($'$fieldID'=="'$val'") print $'$fieldID'}' $tableName)
        if [[ $res == "" ]]
        then
            echo "Value Not Found"
      
        else
            echo -e "which field to update: \c"
            read setField
            setfieldID=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$setField'") print i}}}' $tableName)
            if [[ $setfieldID == "" ]]
            then
                echo "Not Found"
       
            else
                echo -e "Enter new value to set: \c"
                read newValue
                NR=$(awk 'BEGIN{FS="|"}{if ($'$fieldID' == "'$val'") print NR}' $tableName 2>>./.error.log)
                oldValue=$(awk 'BEGIN{FS="|"}{if(NR=='$NR'){for(i=1;i<=NF;i++){if(i=='$setfieldID') print $i}}}' $tableName)
                sed -i ''$NR's/'$oldValue'/'$newValue'/g' $tableName 
                echo "Row Updated Successfully"
            fi
        fi
    fi
fi
