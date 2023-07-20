#!/bin/bash
# 1U
# crontab -l > mycron
# echo "#" >> mycron
# echo "# At every 2nd minute" >> mycron
# echo "*/1 * * * * /bin/bash /autofan.sh >> /tmp/cron.log" >> mycron
# crontab mycron
# rm mycron
# chmod +x /autofan.sh
#

PASSWORD="fanfanfanfan"
USERNAME="fan"
ILOIP="10.1.10.30"

FILE="/usr/bin/sshpass"
if [ -f "$FILE" ]; then
    echo "sshpass already loaded."

else
    pwdlocation=$(pwd)
    cd /tmp
    wget https://ghproxy.com/https://github.com/thomaswilbur/HP-ILO-Fan-Control/blob/main/Files/sshpass?raw=true --no-check-certificate
    mv sshpass?raw=true /usr/bin/sshpass
    chmod +x /usr/bin/sshpass
    cd pwdlocation
    echo "sshpass loaded."

fi


#T1="$(sensors -Aj coretemp-isa-0000 | jq '.[][] | to_entries[] | select(.key | endswith("input")) | .value' | sort -rn | head -n1)"
#T2="$(sensors -Aj coretemp-isa-0001 | jq '.[][] | to_entries[] | select(.key | endswith("input")) | .value' | sort -rn | head -n1)"

sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP show /system1/sensor2 > temp.txt
T1CLEAN=$(grep -Ihr "CurrentReading" temp.txt)
T1=$(echo "${T1CLEAN/    CurrentReading=/}" | xargs)
rm -rf temp.txt

sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP show /system1/sensor16 > temp16.txt
T16CLEAN=$(grep -Ihr "CurrentReading" temp16.txt)
T16=$(echo "${T16CLEAN/    CurrentReading=/}" | xargs)
rm -rf temp16.txt

T1=${T1//$'\n'/}
T1=${T1%$'\n'}

T16=${T16//$'\n'/}
T16=${T16%$'\n'}

echo "CPU 1 Temp $T1 C"
echo "PCI 2 Temp $T16 C"

if [[ $T1 > 87 ]]; then
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 0 max 255'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 1 max 255'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 2 max 255'

elif [[ $T1 > 77 ]]; then
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 0 max 180'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 1 max 180'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 2 max 180'

elif [[ $T1 > 67 ]]; then
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 0 max 150'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 1 max 150'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 2 max 150'

elif [[ $T1 > 58 ]]; then
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 0 max 130'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 1 max 130'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 2 max 130'

elif [[ $T1 > 54 ]]; then
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 0 max 100'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 1 max 100'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 2 max 100'

elif [[ $T1 > 52 ]]; then
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 0 max 85'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 1 max 85'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 2 max 85'

elif [[ $T1 > 50 ]]; then
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 0 max 80'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 1 max 80'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 2 max 80'

else
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 0 max 50'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 1 max 50'
    sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss $USERNAME@$ILOIP 'fan p 2 max 65'

fi
