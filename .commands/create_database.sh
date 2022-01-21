#! /bin/bash
            #a menu to create database or to abort 
            select opt in "create" "back to main menu";
            do
                case $opt in
                "create")
                        #user input database name
                        echo "Enter database name to be created" 
                        read databasename
                        #checking if the database already exists
                        if [ -d $databasename ]
                        then
                            echo $databasename "already exists"
                        else   
                            #create the database
                            mkdir $databasename
                            #confirmation message
                            echo $databasename "created"
                        fi
                        ;;
                "back to main menu")
                        #display menu options
                        echo "$menu"
                        break
                        ;;
                        #ERROR
                *) echo $REPLY "is not an option"
                esac
            done
        