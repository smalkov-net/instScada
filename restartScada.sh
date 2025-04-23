#!/bin/bash

declare -A a=(["/opt/mplc4/"]="/etc/init.d/mplc4 restart" ["/opt/SibMir_SCADA/"]="/etc/init.d/SibMir_SCADA restart")

for b in "${!a[@]}"; do
    if [ -d "$b" ]; then
        sudo su -c "${a[$b]}"
    fi
done
