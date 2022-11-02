#!/bin/sh
eval `dbus export cloudflared`
source /koolshare/scripts/base.sh
alias echo_date='echo $(date +%Y年%m月%d日\ %X):'
LOG_FILE=/tmp/upload/cloudflaredconfig.log
rm -rf $LOG_FILE
BIN=/koolshare/bin/cloudflared
http_response "$1"

case $2 in
1)
    echo_date "当前已进入cloudflared.sh" >> $LOG_FILE
    if [ "$cloudflared_enable" == "1" ];then
        sh /koolshare/scripts/cloudflared.sh restart
    else
        sh /koolshare/scripts/cloudflared.sh stop
    fi
    echo BBABBBBC >> $LOG_FILE
    ;;
esac
