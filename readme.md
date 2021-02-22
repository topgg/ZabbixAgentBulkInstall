### 

The future script will be divided into two versions, one is source installation, the other is tar package installation, and the tar package installation is released this time.

Installation instructions
----------------------
-Source code installation has the best compatibility and portability,
-Tar package installation The program has been compiled and copied and can be used. It will automatically select the appropriate package to download according to the system. You can also modify it yourself to specify the LTS version

System Support Instructions
----------------------
-The tar package currently only supports centos 5678 ubuntu has not been written yet.

How to use it has root privileges
----------------------

wget https://raw.githubusercontent.com/topgg/ZabbixAgentBulkInstall/main/zabbix_agent_installer.sh -O zabbix_agent_installer.sh && chmod +x zabbix_agent_installer.sh && sh zabbix_agent_installer.sh'your IP address'


How to use it does not have root privileges. For example, sudo is required in the springboard to execute
----------------------

sudo sh -c "wget ​​https://raw.githubusercontent.com/topgg/ZabbixAgentBulkInstall/main/zabbix_agent_installer.sh -O zabbix_agent_installer.sh && chmod +x zabbix_agent_installer.sh && sh zabbix_agent_installer.sh'your IP address' "

Update date, 02/09/2021





### Zabbix Agent 一键自动安装 脚本 Zabbix Agent one-click automatic installation script

未来脚本分为两个版本，一个是 源码安装，一个是tar包安装，本次发布的是 tar包安装。

安装方式说明 
----------------------
- 源码安装 兼容性最好，可移植性最好
- Source code installation has the best compatibility and portability 
- Tar 包安装 程序已经编译好复制就能用，会根据系统自动选择合适的包下载，你也可自己修改去指定 LTS版本
- Tar package installation The program has been compiled and copied and can be used. It will automatically select the appropriate package to download according to the system. You can also modify it yourself to specify the LTS version


系统支持说明
----------------------
- tar 包目前只支持 centos 5678 ubuntu 还没写好。
- 源码包支持所有系统

使用方法 
----------------------

wget https://raw.githubusercontent.com/topgg/ZabbixAgentBulkInstall/main/zabbix_agent_installer.sh -O zabbix_agent_installer.sh && chmod +x zabbix_agent_installer.sh && sh zabbix_agent_installer.sh  'zabbix服务器地址' 'zabbixagent 端地址'


如果 没有root权限 比如 跳板机中 需要 sudo 才能执行的 
----------------------

sudo sh -c "wget https://raw.githubusercontent.com/topgg/ZabbixAgentBulkInstall/main/zabbix_agent_installer.sh -O zabbix_agent_installer.sh && chmod +x zabbix_agent_installer.sh && sh zabbix_agent_installer.sh  '你的IP地址' "

更新日期， 2021/02/09

