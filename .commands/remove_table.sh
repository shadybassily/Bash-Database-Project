#! /bin/bash
echo "Table to be removed: "
read tableName
if [ -f $tableName ]
then
    #remove both the table and the metadata
    rm -v -i $tableName 
    rm .$tableName 2>>/dev/null
else
    echo "Table doesn't exist"
fi