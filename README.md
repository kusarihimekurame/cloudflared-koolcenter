# Cloudflared-Koolcenter

华硕koolcenter软件中心插件中安装cloudflared，主要根据token连接cloudflare tunnel，进行内网穿透

## 使用说明
[Cloudflare Tunnel 官方说明](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)

需要先在[Cloudflare Zeor Trust](https://one.dash.cloudflare.com/)中Access->Tunnels创建一条隧道，然后将隧道的token填入插件中对应的栏目就能和隧道连接。

在Cloudflare Zeor Trust中添加public hostname就能访问对应的网站，如果套用application中的self-hosted就能用邮箱进行双重认证，并且只有指定的邮箱才能收到验证码，比其他的内网穿透软件更安全。

## 架构及其替换方法
适用于`ax68u`路由器以及架构为`armhf`，带有koolcenter软件中心的路由器

仓库里面`cloudflared`的核心程序是`armhf`架构，如果是其他架构的路由器可以参考

[cloudflared github](https://github.com/cloudflare/cloudflared/releases)中找到对应的二进制文件(没有后缀名)下载并替换`/bin/cloudflared`

修改`install.sh`中的检测架构方法`platform_test()`
