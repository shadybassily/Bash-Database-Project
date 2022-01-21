#! /bin/bash
#sub menu
            select opt in "remove" "back to main menu";
            do
                case $opt in
                "remove")
                        echo "Enter database name to be removed" 
                        read databasename
                        #checking if the database exists
                        if [ -d $databasename ]
                        then
                            #notifying before removing the database 
                            rm -v -ir $databasename 

                            #if database doesnt exist
                        else   
                            echo $databasename "doesn't exist"
                        fi
                        ;;
                "back to main menu")       
                        echo "$menu"
                        break
                        ;;
                    #ERROR
                *) echo $REPLY "is not an option"
                esac
            done        