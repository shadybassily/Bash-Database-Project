#! /bin/bash

#changing directory to the database dir
cd ~/iti/bash/project
echo $'\n************** Welcome to database engine ************** \n '
export PS3=$'\nChoose an option: '
export menu=$'   1) create database\n   2) list databases\n   3) remove database\n   4) connect to a database\n   5) quit\n'
#storing primary options in an array
options=("create database" "list databases" "remove database" "connect to a database" "quit")

#looping thro the options
select opt in "${options[@]}";
do
    case $opt in
        #creating a database
        "create database")
            ~/iti/bash/project/.commands/create_database.sh
            ;;
        #listing databases
        "list databases")
            ~/iti/bash/project/.commands/list_databases.sh
            ;;
        "remove database")
            ~/iti/bash/project/.commands/remove_database.sh
            ;;
        "connect to a database")
            ~/iti/bash/project/.commands/access_database.sh
            ;;
        "quit")
            echo "quitting"
            break
            ;;
        *) echo $REPLY "is not an option"
            ;;
    esac
done