#! /bin/bash
export li=$'   1) list tables\n   2) create table\n   3) insert into table\n   4) update table\n   5) select from table\n   6) delete record\n   7) remove table\n   8) exit database\n '

select opt in "view table" "view table metadata" "back"
do
    case $opt in
        "view table") 
            echo "Enter table name: "
            read tableName
            if [ -f $tableName ]
            then
                #display table
                echo $'\n'
                echo "****$tableName****"
                awk '{print $0}' $tableName
                echo $'\n'
                echo "$li"
                break
            else
                echo "doesn't exist"
            fi
            ;;
        "view table metadata") 
            echo "Enter table name: "
            read tableName
            if [ -f .$tableName ]
            then
                #display datatype
                echo "============================"
                sed -n '1,$p' .$tableName
                echo "============================"
                echo "$li"
                break
            else
                echo "doesn't exist"
            fi
            ;;    
        "back") 
                echo "$li"
                break;
            ;;
        *) echo "Wrong Choice"                    
            ;;
    esac
done