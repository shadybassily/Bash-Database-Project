#! /bin/bash
        shopt -s extglob
        export LC_COLLATE=C
        export li=$'   1) list tables\n   2) create table\n   3) insert into table\n   4) update table\n   5) select from table\n   6) delete record\n   7) remove table\n   8) exit database\n '
        echo -e "Enter table name: \c"
        read tableName
        #if space was included in the table's name
        if [[ $tableName == *" "* ]] 
        then
            echo "enter a valid name"
            echo "$li"
            
        else
            if [ -f $tableName ]
            then
                echo $'Table already exists.\n'
                echo "$li"

            else
                echo -e "Enter number of columns: \c"
                read colsNum
            if [[ $colsNum -le 0 ]]
            then
                echo "please enter a valid number"
                echo "$li"
            else
                counter=1
                #field separator, record separator, primary key and metadata
                sep="|"
                rSep="\n"
                pKey=""
                metaData="Field"$sep"Type"$sep"key"$sep"table name"$sep"No. of cols"
                while [ $counter -le $colsNum ]
                do
                    #column name
                    echo -e "Name of Column No.$counter: \c"
                    read colName
                    #making the first column is the PK and type int
                    if [[ $counter == 1 ]]
                    then
                        echo $colName "Will be your Primary Key and it will accept only integers"
                        colType="int"
                        pKey="PK"
                        metaData+=$rSep$colName$sep$colType$sep$pKey$sep$tableName$sep$colsNum
                    else
                        #column data type
                        echo -e "Type of Column $colName: "
                        select opt in "int" "varchar"
                        do
                            case $opt in
                                "int") colType="int"
                                        break
                                ;;
                                "varchar") colType="varchar"
                                        break
                                ;;
                                #exit so if the user enters a wrong choice the table won't be created anyway
                                *) echo "Wrong Choice" 
                                    echo "$li"
                                    exit;
                                ;;
                            esac
                        done
                        metaData+=$rSep$colName$sep$colType""
                    fi
                    #assign PK constrain
                    
                        # if [[ $pKey == "" ]]
                        # then
                        #     echo -e "Make PrimaryKey? "
                        #     select opt in "Yes" "No"
                        #     do
                        #         case $opt in
                        #             "Yes") 
                        #                 #adding pk constrain
                        #                 pKey="PK"
                        #                 metaData+=$rSep$colName$sep$colType$sep$pKey$sep$tableName$sep$colsNum
                        #                 break
                        #             ;;
                        #             "No") 
                        #                 metaData+=$rSep$colName$sep$colType$sep$tableName$sep$colsNum""
                        #                 break
                        #             ;;
                        #                 #exit so it doesn't create the table anyway
                        #             *) echo "Wrong Choice" 
                        #                 echo "$li"
                        #                 exit;
                                        
                        #             ;;
                        #         esac
                        # done
                        # else
                        #     #then table already have a pk
                        #     metaData+=$rSep$colName$sep$colType$sep""
                        # fi
                    
                    #if one colum OR the last colum then no separator will be add 
                    if [[ $counter == $colsNum ]]
                    then
                        data=$data$colName
                    #if the while loop is not finished yet it will keep adding column names with |
                    else
                        data=$data$colName$sep
                    fi
                    ((counter++))
                done
                touch .$tableName
                echo -e $metaData  >> .$tableName
                touch $tableName
                echo -e $data >> $tableName
                if [[ $? == 0 ]]
                then
                    echo $'\n'
                    echo $tableName $'Created Successfully\n'
                    echo "$li"
                fi
            fi
            fi
        fi
