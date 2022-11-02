#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval $(dbus export cloudflared_)
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

pid_ali=$(pidof cloudflared)
date=$(echo_date)

if [ -n "$pid_ali" ]; then
    text1="<span style='color: #6C0'>$date Cloudflared 进程运行正常！(PID: $pid_ali)</span>"
else
    text1="<span style='color: red'>$date Cloudflared 进程未在运行！</span>"
fi

aliversion=$(/koolshare/bin/cloudflared -V)
if [ -n "$aliversion" ]; then
	aliversion="$aliversion"
else
	aliversion="null"
fi

http_response "$text1@$aliversion@"
