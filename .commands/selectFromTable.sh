#! /bin/bash

echo -e "Enter Table Name: \c"
read tableName
if ! [[ -f $tableName ]]
then    
    echo "Table doesn't exist"
else
    echo -e "Enter primary key: \c"
    read recordNum
    if ! [[ $recordNum =~ [`cut -d"|" -f1 $tableName | grep -x $recordNum`] ]] 2>>/dev/null
    then
        echo "record not found"
    else
        sed -n '1p' $tableName
        sed -n /$recordNum/p $tableName
    fi
fi

