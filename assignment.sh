#making an addressbook using shell script

# It should use functions to perform the required tasks. It should be menu-based, allowing you the options of:

# Search address book
# Add entries
# Remove / edit entries
# You will also need a "display" function to display a record or records when selected.


#! /bin/bash

#function for searching address
function searchAddressbook() {
    echo "Whose address would you like to search"
    read name
    if [ -f $name.txt ]; then
        echo "The file exists and is stored in $PWD with file name: $name.txt"
        echo "***********************************"
        cat $name.txt
        echo "***********************************"
    else
        echo "File $name.txt does not exist"
    fi
}


function addEntries() {
    echo "Enter your name"
    read name
    echo "Enter your surname"
    read surname
    echo "Enter your email"
    read email
    echo "Enter your phone"
    read phone
    echo "Your records will be stored in $PWD"
    touch $name.txt
    echo -e " Name: $name \n Surname: $surname \n Email: $email \n Phone Number: $phone " >> $name.txt
    # cat $name.txt
}


#function to remove the file from the directory
function removeEntries() {
    echo "Enter the name of the file you want to remove: "
    read del_name
    if [ -f $del_name.txt ]; then
        echo "Are you sure that you want to delete the record of $del_name?(0/1)"
        read confirmation
        if [ $confirmation = "1" ]; then
            echo "The record is removed from the system"
            rm $del_name.txt
        else 
            echo "The record is not deleted"
        fi
    else
        echo "The file you are trying to remove doesnot exist"
    fi
}


function displayRecord() {
    echo "Enter the record you want to display"
    read name
    if [ -f $name.txt ]; then
        echo "----------------------RECORD OF $name-----------------------"
        cat $name.txt
        echo "------------------------------------------------------------"
    else 
        echo "The record doesnot exist"
    fi
}

#to edit a record
function editRecord() {
    echo "Whose record whould you like to edit? Please enter the name: "
    read name
    if [ -f $name.txt ]; then
        echo "What field would you like to edit?"
        read field
        grep -w "$field" $name.txt
        echo "Value you want to set it to?"
        read edit_field
            if [ $edit_field = "Number"]; then
                echo "Enter the number you want to update with..."
                read num
                sed "s/Number \[[^]]*\]/Number \[$NUMBER\]/g" "$name.txt"
                echo "The number was edited successfully"
            elif [$edit_field = "Email"]; then
                echo "Enter the email you want to update  with..."
                read num
                sed "s/Email \[[^]]*\]/Email \[$EMAIL\]/g" "$name.txt"
                echo "The number was edited successfully"
            elif [ $edit_field = "Name"]; then
                echo "Enter the name you want to update with..." 
                read num
                sed "s/Name \[[^]]*\]/Name \[$NAME\]/g" "$name.txt"
                echo "The number was edited successfully"
            else 
                echo "Please enter a valid field to edit"
            fi

    else 
        echo "The file doesnot exist to edit."
    fi
}

n=1
while [ $n -eq 1 ]
do 
    echo -e "WELCOME TO ADDRESSBOOK SHELL APPLICATION \n What operation would you like to do? \n 1. Search address book \n 2. Add entries \n 3. Remove entries \n 4. Display record \n 5. Edit Entries \n 6. Quit Application"
    read selectedOption

    case "$selectedOption" in
        "1")
            searchAddressbook ;;
        "2")
            addEntries ;;
        "3")
            removeEntries ;;
        "4")
            displayRecord ;;
        "5") 
            editRecord ;;
        "6")
            exit ;;
        *)
            echo -e "Unknown Option. \n ENTER A VALID CHARACTER" ;;
    esac
done