#!/bin/bash

#python full stack diploma
#database engine using bash
#student names : yousif mohamed ebrahim && ebram tooma
#-------------------------------------------------------------
#proj discreption :
----------------------
# project will be divieded into two parts

#first part : main menu considerd as the dbms engine controller with basic features
#- Create Database
# we will consider the database as a folder so when we we are creating database we are creating direory

# - List Databases
#listing  the database we will be (ls) command  to list all the directories as its our database count


# - Connect To Databases
# connecting to database will be accessing the folder of the specific database (cd command $db_name)

# - Drop Database
#dropinng the database will be considerd as removing the directory of this database
#--------------------program starts here first part --------------------
mkdir dbms
clear
echo "************database engine mainmenu **********"
echo "------------------------------------------------"
select selec in create-DataBase list-DataBases delete-DataBase connect-Database loout ; do
    
    case $selec in
        create-DataBase) echo "please enter database name that you want to create : "
            read inp
            mkdir ./dbms/$inp
            if [[ $? == 0 ]]
            then
                echo " $inp database created successfully "
            else
                echo " $inp already exist "
        fi ;;
        list-DataBases) ls dbms ;;
        delete-DataBase) echo "please enter database name that you want to delete : "
            read inp
            rm -r ./dbms/$inp
            if [[ $? == 0 ]]
            then
                echo " $inp database deleted successfully "
            else
                echo " $inp not-exist "
        fi ;;
        connect-Database) echo "please enter database name that you want to connect : "
            read inp
            cd ./dbms/$inp
            if [[ $? == 0 ]]
            then
                echo " $inp database connected successfully "
                echo "--------------------------------------"
                select val in Create-Table List-Tables Drop-Table Insert-into-Table Select-From-Table Delete-From-Table close-connection; do
                    case $val in
                        Create-Table)
                            echo "please enter table name : "
                            read tabname
                            if [[ -f $tabname  ]]
                            then
                                echo "table already exist choose list table to check tables"
                            else
                                touch $tabname
                                echo "please enter number of column :"
                                read no
                                row=""
                                sep=" : "
                                while [ $no -gt 0 ]
                                do
                                    echo "please enter col name : "
                                    read colname
                                    if [[ $no -eq 1 ]]
                                    then
                                        row=$row$colname
                                    else
                                        row=$row$colname$sep
                                    fi
                                    no=$(( $no - 1 ))
                                done
                                echo -e $row >>$tabname
                                echo " $tabname is created "
                        fi ;;
                        
                        List-Tables) ls ;;
                        Drop-Table)  echo "please enter table name : "
                            read tabname
                            rm $tabname
                            if [[ $? == 0 ]]
                            then
                                echo  " $tabname deleted"
                            else
                                echo " $tabname not found"
                        fi   ;;
                        Insert-into-Table) echo "please enter table name : "
                            read tabname
                            if [[ -f $tabname  ]]
                            then
                                col=$(awk 'BEGIN{FS=" : "}{if(NR==1) print NF}' $tabname )
                                # echo  $col
                                prim=$col
                                row=""
                                sep=" : "
                                while [ $col -gt 0 ]
                                do
                                    
                                    echo "please enter col data : "
                                    read coldata
                                    if [[ $col -eq $prim ]]
                                    then
                                        
                                        while [[ true ]]
                                        do
                                            if [ "$coldata" = "`awk -F " : " '{ print $1 }' $tabname | grep "^$coldata$"`" ]; then
                                                echo -e "invalid input for Primary Key !!"
                                                echo -e "please enter unique coldata : "
                                                read coldata
                                            else
                                                break
                                            fi
                                        done
                                    fi
                                    if [[ $col -eq 1 ]]
                                    then
                                        row=$row$coldata
                                    else
                                        row=$row$coldata$sep
                                    fi
                                    col=$(( $col - 1 ))
                                done
                                echo -e $row >>$tabname
                            else
                                echo "table is not exist"
                        fi ;;
                        Select-From-Table) echo "please enter table name that do you want to select :"
                            read tabname
                            if [[ -f $tabname ]]
                            then
                                echo "1-preview all data "
                                echo "2-selcet speccific data with id : "
                                read inp
                                if [[ $inp -eq 1 ]]
                                then
                                    more $tabname
                                else
                                    echo "please enter user id : "
                                    read id
                                    line=$(awk 'BEGIN{FS=" : "}{if ( $1 == "'$id'" ) print NR}' $tabname 2>>/dev/null)
                                    if [[ $line == ""  ]]
                                    then
                                        echo "no record with id : $id "
                                    else
                                        echo  $(awk '{if ( NR == '$line' ) print $0 }' $tabname 2>>/dev/null)
                                    fi
                                fi
                            else
                                echo " $tabname is not exist "
                        fi ;;
                        Delete-From-Table)
                            echo "please enter table name that you want to delete :"
                            read tabname
                            if [[ -f $tabname ]]
                            then
                                echo "please enter user id that you want to delete: "
                                read id
                                line=$(awk 'BEGIN{FS=" : "}{if ( $1 == "'$id'" ) print NR}' $tabname 2>>/dev/null)
                                if [[ $line == ""  ]]
                                then
                                    echo "no record with id : $id "
                                else
                                    # echo  $(awk '{if ( NR == '$line' ) print $0 }' $tabname 2>>/dev/null)
                                    sed -i ''$line'd' $tabname 2>>/dev/null
                                fi
                                
                            else
                                echo " $tabname is not exist "
                        fi ;;
                        close-connection) exit ;;
                        *) echo " $REPLAY not identified " ;;
                    esac
                done
            else
                echo " $inp not-exist || invalid name "
        fi ;;
        loout) exit ;;
        *) echo " $REPLAY not identified " ;;
    esac
done