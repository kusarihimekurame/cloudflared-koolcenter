#!/bin/sh
# For RedHat and cousins:
# chkconfig: 2345 99 01
# description: cloudflared
# processname: /usr/bin/cloudflared
### BEGIN INIT INFO
# Provides:          /usr/bin/cloudflared
# Required-Start:
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: cloudflared
# Description:       cloudflared agent
### END INIT INFO
eval `dbus export cloudflared`
source /koolshare/scripts/base.sh
alias echo_date='echo $(date +%Y年%m月%d日\ %X):'

name=cloudflared
cmd="/koolshare/bin/cloudflared --pidfile /var/run/$name.pid --logfile /tmp/upload/$name.log --protocol http2 --url localhost:7913 tunnel run --token ${cloudflared_token}"
pid_file="/var/run/$name.pid"
pid_ali=$(pidof cloudflared)
stdout_log="/tmp/upload/$name.log"
stderr_log="/tmp/upload/$name.err"
LOG_FILE="/tmp/upload/cloudflaredconfig.log"

[ -e /opt/etc/sysconfig/$name ] && . /opt/etc/sysconfig/$name
is_running() {
    [ -n "$pid_ali" ] > /dev/null 2>&1
}
case "$1" in
    start)
        if is_running; then
            echo_date "已经启动" >> $LOG_FILE
        else
            echo_date "启动 $name" >> $LOG_FILE
            $cmd >> "$stdout_log" 2>> "$stderr_log" &
            echo_date pid: $! > "$pid_file" >> $LOG_FILE
        fi
    ;;
    stop)
        if is_running; then
            echo_date "正在停止 $name.." >> $LOG_FILE
            kill $pid_ali
            if [ -f "$pid_file" ]; then
                rm "$pid_file"
            fi
            echo_date "停止成功" >> $LOG_FILE
        else
            echo_date "没有运行" >> $LOG_FILE
        fi
    ;;
    restart)
        if is_running; then
            $0 stop
            echo_date "正在重新启动..." >> $LOG_FILE
            sleep 3
        fi
        $0 start
    ;;
    status)
        if is_running; then
            echo "正在运行"
        else
            echo "停止"
            exit 1
        fi
    ;;
    *)
    echo "Usage: $0 {start|stop|restart|status}"
    exit 1
    ;;
esac
exit 0