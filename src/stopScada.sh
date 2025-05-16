#!/bin/bash

declare -A services=(
    ["/opt/mplc4/"]="/etc/init.d/mplc4 restart"
    ["/opt/SibMir_SCADA/"]="/etc/init.d/SibMir_SCADA restart"
)

for dir in "${!services[@]}"; do
    if [ -d "$dir" ]; then
        echo "Directory $dir exists. Restarting service..."
        sudo su -c "${services[$dir]}"
    else
        #echo "Directory $dir does not exist."
    fi
done
