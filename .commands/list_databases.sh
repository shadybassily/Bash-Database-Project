#! /bin/bash

            #listing only tables (files)
            ls -d */ 2>>/dev/null
if [[ $? == 0 ]]
then 
    echo "Existing databases"
else
    echo "no databases yet"
fi

