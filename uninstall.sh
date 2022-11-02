#!/bin/sh
eval `dbus export cloudflared_`
source /koolshare/scripts/base.sh
logger "[软件中心]: 正在卸载 cloudflared..."
MODULE=cloudflared
cd /
/koolshare/scripts/cloudflared.sh stop
rm -f /koolshare/init.d/S99cloudflared.sh
rm -f /koolshare/scripts/cloudflared*
rm -f /koolshare/webs/Module_cloudflared.asp
rm -f /koolshare/res/cloudflared*
rm -f /koolshare/res/icon-cloudflared.png
rm -f /koolshare/bin/cloudflared
rm -fr /tmp/cloudflared* >/dev/null 2>&1
rm -fr /tmp/upload/cloudflared* >/dev/null 2>&1
values=`dbus list cloudflared | cut -d "=" -f 1`
for value in $values
do
  dbus remove $value
done
logger "[软件中心]: 完成 cloudflared 卸载"
rm -f /koolshare/scripts/uninstall_cloudflared.sh
