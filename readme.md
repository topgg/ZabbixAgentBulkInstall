
### Zabbix Agent 一键自动安装 脚本 Zabbix Agent one-click automatic installation script

一个是 源码安装，一个是tar包安装，本次发布的是 tar包安装，如果你用的是 jumpserver 其内置的批量执行模块无法直接使用 ansible 语句，可以尝试此方法。

PS: 如果有调价，更好的解决方案是使用 ansible, 按照 ansible playbook 语法编写 zabbix 安装程序

安装方式说明 
----------------------
- 源码安装 兼容性移植性好
- Source code installation has the best compatibility and portability 
- Tar 包安装 程序已经编译好复制就能用，会根据系统自动选择合适的包下载，你也可自己修改去指定 LTS版本
- Tar package installation The program has been compiled and copied and can be used. It will automatically select the appropriate package to download according to the system. You can also modify it yourself to specify the LTS version


系统支持说明
----------------------
- tar 包目前只支持 centos 5678 ubuntu 还没写好。
- 源码包支持所有系统

使用方法 Tar 包
----------------------

wget https://raw.githubusercontent.com/topgg/ZabbixAgentBulkInstall/main/zabbix_agent_installer.sh -O zabbix_agent_installer.sh && chmod +x zabbix_agent_installer.sh && sh zabbix_agent_installer.sh  'zabbix服务器地址' 'zabbixagent 端地址'


如果 没有root权限 比如 跳板机中 需要 sudo 才能执行的 
----------------------

sudo sh -c "wget https://raw.githubusercontent.com/topgg/ZabbixAgentBulkInstall/main/zabbix_agent_installer.sh -O zabbix_agent_installer.sh && chmod +x zabbix_agent_installer.sh && sh zabbix_agent_installer.sh  '你的IP地址' "

使用方法 源码编译包
----------------------

wget https://raw.githubusercontent.com/topgg/ZabbixAgentBulkInstall/main/zabbix_agent_installer.sh -O zabbix_agent_installer.sh && chmod +x zabbix_agent_installer.sh && sh zabbix_agent_installer.sh  'zabbix服务器地址' 'zabbixagent 端地址'


如果 没有root权限 比如 跳板机中 需要 sudo 才能执行的 
----------------------

sudo sh -c "wget https://raw.githubusercontent.com/topgg/ZabbixAgentBulkInstall/main/zabbixAgent_installer_sources.sh -O zabbixAgent_installer_sources.sh && chmod +x zabbixAgent_installer_sources.sh && sh zabbixAgent_installer_sources.sh  '你的IP地址' "


更新日期， 2021/02/09

