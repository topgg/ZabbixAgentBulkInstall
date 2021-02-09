### Zabbix Agent 一键自动安装 脚本 

未来脚本分为两个版本，一个是 源码安装，一个是tar包安装，本次发布的是 tar包安装。

安装方式说明 
----------------------
- 源码安装 兼容性最好，可移植性最好， 
- Tar 包安装 程序已经编译好复制就能用，会根据系统自动选择合适的包下载，你也可自己修改去指定 LTS版本 

系统支持说明
----------------------
- tar 包目前只支持 centos 5678 ubuntu 还没写好。

使用方法 有root权限 
----------------------

wget https://raw.githubusercontent.com/topgg/ZabbixAgentBulkInstall/main/zabbix_agent_installer.sh -O zabbix_agent_installer.sh && chmod +x zabbix_agent_installer.sh && sh zabbix_agent_installer.sh  '你的IP地址'


使用方法 没有root权限 比如 跳板机中 需要 sudo 才能执行的 
----------------------

sudo sh -c "wget https://raw.githubusercontent.com/topgg/ZabbixAgentBulkInstall/main/zabbix_agent_installer.sh -O zabbix_agent_installer.sh && chmod +x zabbix_agent_installer.sh && sh zabbix_agent_installer.sh  '你的IP地址' "

更新日期， 2021/02/09

