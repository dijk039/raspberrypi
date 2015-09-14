#!/bin/bash
# ---------------------------------------------------------------------------
# create_new_shell_script.sh 

# This script creates a base template for a (ba)sh script and let the
# user enter some basic information regarding the function and the author.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details.

#---------------------------------------------------------------------------

echo "Script Template generator..."
echo "Please provide some basic informatio about your new script"
echo; echo

LOOP=true
while ${LOOP}; do
    read -p "Script Name       : " SCRIPT_NAME
    SCRIPT_NAME="${SCRIPT_NAME:-my_script.sh}"

    if [ -f ${SCRIPT_NAME} ]; then
        echo "Script with name: ${SCRIPT_NAME} already exists!"
        read -p "Overwrite? (Yes/No/Abort)" OVERWRITE
        case ${OVERWRITE} in
            Y|y|Yes|YES ) echo "Ok. Overwriting..."
                          LOOP=false
                          ;;
            A|a|Abort   ) echo "Aborting..."
                          exit 0
                          ;;
            *           ) LOOP=true
                          ;;
        esac
    else
        LOOP=false
    fi
done

read -p "Short Discription : " SHORT_DESC
SHORT_DESC="${SHORT_DESC:-No description available}"

read -p "Author            : " AUTHOR
AUTHOR="${AUTHOR:-Tim van Dijk}"

read -p "E-Mail Address    : " EMAIL_ADDRESS
EMAIL_ADDRESS="${EMAIL_ADDRESS:-dijk039@gmail.com}"

CURRENT_DATE=$(date +"%m-%d-%Y")


cat <<EOF > ${SCRIPT_NAME}
#!/bin/bash
#=============================================================================
# Scriptname        : ${SCRIPT_NAME}
# Short Description : ${SHORT_DESC}
# Author            : ${AUTHOR} <${EMAIL_ADDRESS}>
# Date              : ${CURRENT_DATE}
#-----------------------------------------------------------------------------
# Revision history
#   
#   Version 1.0:    First version
#=============================================================================

PROGNAME=\${0##*/}
PROGPATH=\${0%/*}


#<<Start your code here>>
EOF

chmod +x ${SCRIPT_NAME}
