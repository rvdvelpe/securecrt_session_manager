#!/bin/bash

read -p "Session name search: " search

#Search all the session in securecrt with the search string (case insensitive)
n=0;IFS=$'\n';for f in $(find $HOME/.vandyke/SecureCRT/Config/Sessions -iname "*$search*.ini"); do output[$n]=$f && ((n++)); done;

#Print the output
n=0
for each in "${output[@]}"
do
  echo "$n : $each"
  ((n++))
done

if [ ${n} = 1 ]; then
    session=${output[0]}
else
    read -p "Which session do you want to connect to: " session
    session=${output[$session]}
fi

#Get the variables to connect to
username=`grep \"Username\" "${session}" | cut -d'=' -f 2`
protocol=`grep \"Protocol\ Name\" "${session}" | cut -d'=' -f 2`
hostname=`grep \"Hostname\" "${session}" | cut -d'=' -f 2`

case "$protocol" in
"SSH2")
    echo "ssh $username@$hostname"
    ssh $username@$hostname
    ;;
"TELNET")
    echo "code not yet written"
    ;;
*)
    echo "protocol $protocol not know yet"
    ;;
esac

exit
