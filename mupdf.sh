!#/bin/bash

# run mupdf as terminal program if launched from the terminal or first launch the open file dialog otherwise

if [ -t 0 ] && terminal=1; then

    /usr/bin/zenity $@

else

    FILE=`zenity --file-selection --title="Select a File"`

    case $? in
             0)
                    /usr/bin/mupdf "$FILE";;
             1)
                    echo "No file selected.";;
            -1)
                    echo "An unexpected error has occurred.";;
    esac
fi;
