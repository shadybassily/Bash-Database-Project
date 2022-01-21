#! /bin/bash
            
            #database to be selected
            echo -e "choose database to connect: \c" 
            read databasename
            #checking if the database exists
            if [ -d $databasename ]
            then
                #accessing the database
                cd ~/iti/bash/project/$databasename
                #options to apply on the database
                echo "you are connected to" $databasename 
                options=("list tables" "create table" "insert into table" "update table" "select from table" "delete record" "remove table" "exit database")
                select opt in "${options[@]}";
                do
                    case $opt in
                    "list tables")
                        #check if there are tables
                        typeset -i num;
                        num=`ls -l|grep '^-'|wc -l`
                        if [ $num -ne 0 ]
                        then
                            ls
                            ~/iti/bash/project/.commands/view_table.sh
                        else
                            echo "no tables found"
                        fi
                            ;;
                    "create table")
                        ~/iti/bash/project/.commands/create_table.sh
                        ;;
                    "insert into table")
                        ~/iti/bash/project/.commands/insert_into_table.sh
                        ;;
                    "update table")
                        ~/iti/bash/project/.commands/updatetable.sh
                        ;;
                    "select from table")
                        ~/iti/bash/project/.commands/selectFromTable.sh
                        ;;
                    "delete record")
                        ~/iti/bash/project/.commands/deleteRecord.sh
                        ;;
                    "remove table")
                        ~/iti/bash/project/.commands/remove_table.sh
                        ;;
                    "exit database") #exit database
                        echo "exiting" $databasename
                        echo "you are not connected to a database"
                        #going to the main folder
                        cd ~/iti/bash/project
                        echo "$menu"
                        break
                        ;;
                    *) echo $REPLY "is not an option"
                    esac
                done
            else   
                echo $databasename "doesn't exist"
            fi
