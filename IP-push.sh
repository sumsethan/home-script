#!/bin/bash

#QYWX推送函数
PushQYWX6(){
    key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx #QYWXkey
    content="HomePi的IPv6地址已变动到<br>$ip6"
    curl 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key='$key''    -H 'Content-Type: application/json'    -d '{ "msgtype": "text","text": {"content": "'$content'"} }' >/dev/null 2>&1 &
}

PushQYWXcm(){
    key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx #QYWXkey
    content="移动IPv4出口地址已变动到<br>$cmip"
    curl 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key='$key''    -H 'Content-Type: application/json'    -d '{ "msgtype": "text","text": {"content": "'$content'"} }' >/dev/null 2>&1 &
}

PushQYWXcu(){
    key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx #QYWXkey
    content="联通IPv4出口地址已变动到<br>$cuip"
    curl 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key='$key''    -H 'Content-Type: application/json'    -d '{ "msgtype": "text","text": {"content": "'$content'"} }' >/dev/null 2>&1 &
}

ip6_file="/opt/ippush/ip6.txt" 
cmip_file="/opt/ippush/cmip.txt" 
cuip_file="/opt/ippush/cuip.txt" 



ip6=$(curl -6 ip.sb)
cmip=$(curl --interface 192.168.88.12 ip.sb)
cuip=$(curl --interface 192.168.88.13 ip.sb)


#IPv6
if [ -f $ip6_file ]; then
    old_ip=$(cat $ip6_file)
    if [ $ip6 == $old_ip ]; then
        echo "IPv6 has not changed."
    else
        message6="IP changed to: $ip6"
        echo "$ip6" > $ip6_file
        PushQYWX6
        echo $message6
    fi
else touch $ip6_file
	echo "$ip6" > $ip6_file
	PushQYWX6
fi

#CM-IP
if [ -f $cmip_file ]; then
    oldcm_ip=$(cat $cmip_file)
    if [ $cmip == $oldcm_ip ]; then
        echo "CM-IP has not changed."
    else
        messagecm="IP changed to: $cmip"
        echo "$cmip" > $cmip_file
        PushQYWXcm
        echo $messagecm
    fi
else touch $cmip_file
	echo "$cmip" > $cmip_file
	PushQYWXcm
fi

#CU-IP
if [ -f $cuip_file ]; then
    oldcu_ip=$(cat $cuip_file)
    if [ $cuip == $oldcu_ip ]; then
        echo "CU-IP has not changed."
    else
        messagecu="IP changed to: $cuip"
        echo "$cuip" > $cuip_file
        PushQYWXcu
        echo $messagecu=
    fi
else touch $cuip_file
	echo "$cuip" > $cuip_file
	PushQYWXcu
fi
