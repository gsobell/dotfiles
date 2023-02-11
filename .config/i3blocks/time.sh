#!/bin/bash 


time=$(date +%d\/%m\ %H:%M)


# Shows the date and seconds
if [[ "${BLOCK_BUTTON}" -eq 1 ]];then
        time=$(date +%d/%m\ %X)

# Show yearly calendar
elif [[ "${BLOCK_BUTTON}" -eq 2 ]];then 
       alacritty -e sh -c "cal -y & read"

# Show hebrew date
elif [[ "${BLOCK_BUTTON}" -eq 3 ]];then
        time=$(taarich)
fi

echo -e "$time"
