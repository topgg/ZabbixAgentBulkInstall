#!/bin/bash/

configfile='/etc/zabbix/zabbix_agentd.conf'
Server=$1 #Zabbix 服务器地址或者代理地址
ServerActive=$1 #服务器地址或者代理地址或者代理地址
if[ -n $2 ];then  #第二个位置写本机IP，对于多 IP 服务器需要指定,未指定则从网卡取
ipaddr=`ip a | grep inet | grep -v inet6 | grep -v 127 | sed 's/^[ \t]*//g' | cut -d ' ' -f2|grep -E -o "([0-9]{1,3}\.){3}[0-9]{1,3}"`
if
rm -rf /etc/zabbix/zabbix_agentd.conf
yum install pcre* -y # 解决源方式 二级制库缺失问题 源码安装 zabbix 报错总结 https://www.cnblogs.com/yanjieli/p/10736916.html

function check(){
    netstat -ntlp | grep zabbix_agentd >/dev/null &&  echo "Exit for zabbix_agentd has been already installed." && exit
    test -f zabbix_agent.sh && rm -f zabbix_agent.sh
    test -f /usr/local/zabbix/sbin/zabbix_agentd && rm -rf /usr/local/zabbix/sbin/zabbix_agentd
    test -f /etc/init.d/zabbix_agentd && rm -f /etc/init.d/zabbix_agentd
}

function checkOSdistribution(){

if [ -n "$(grep 'Aliyun Linux release' /etc/issue)" -o -e /etc/redhat-release ]; then
	OS=CentOS
    [ -n "$(grep ' 8\.' /etc/redhat-release 2> /dev/null)" ] && CentOS_RHEL_version=8 && Kernel_OS_VERSION='4'
	[ -n "$(grep ' 7\.' /etc/redhat-release 2> /dev/null)" ] && CentOS_RHEL_version=7 && Kernel_OS_VERSION='3.0'
	[ -n "$(grep ' 6\.' /etc/redhat-release 2> /dev/null)" -o -n "$(grep 'Aliyun Linux release6 15' /etc/issue)" ] && CentOS_RHEL_version=6 && Kernel_OS_VERSION='2.6.23'
	[ -n "$(grep ' 5\.' /etc/redhat-release 2> /dev/null)" -o -n "$(grep 'Aliyun Linux release5' /etc/issue)" ] && CentOS_RHEL_version=5 && Kernel_OS_VERSION='2.6'
elif [ -n "$(grep 'Amazon Linux AMI release' /etc/system-release)" -o -e /etc/system-release ]; then
	OS=CentOS
	CentOS_RHEL_version=6
	Kernel_OS_VERSION ='2.6.23'
elif [ -n "$(grep 'Ubuntu 18' /etc/issue 2> /dev/null)" ];then
	OS=Ubuntu
	Kernel_OS_VERSION='3.0'
	apt install selinux-utils
fi
}

function downloadinstall(){
    if [ ! -f zabbix-5.0.8.tar.gz ];then
    wget https://cdn.zabbix.com/zabbix/sources/stable/5.0/zabbix-5.0.8.tar.gz -O zabbix-5.0.8.tar.gz
    fi
    tar -zxvf zabbix-5.0.8.tar.gz -C ~/zabbix-agent
    cd ~/zabbix-agent/zabbix-5.0.8
    ./configure --prefix=/usr/ --enable-agent
    make && make install
    }
    
function configureconf(){
    
    #sed -i sed 的 -i 选项可以直接修改文件内容，这功能非常有帮助
    sed -i "s/^Server=127.0.0.1/Server = ${Server}/g" $configfile
    sed -i "s/^ServerActive=127.0.0.1/ServerActive = ${Server}/g" $configfile
    sed -i "s/^Hostname=Zabbix server/Hostname=${ipaddr}/g" $configfile
    # 超级权限权限脚本修改 Edit the config file
    sed -i 's/# EnableRemoteCommands=0/EnableRemoteCommands=1/g' $configfile
    sed -i 's/# LogRemoteCommands=0/LogRemoteCommands=1/g' $configfile
    sed -i "s/Server=127.0.0.1/Server=$server/g" $configfile
    sed -i "s/ServerActive=127.0.0.1/ServerActive=$server/g" $configfile
    sed -i "s/Hostname=Zabbix server/Hostname=$hostname/g" $configfile
    echo "zabbix	ALL=NOPASSWD: ALL" >> /etc/sudoers
    sed -i -r "s/Defaults(.*)requiretty/#Defaults		requiretty/g" /etc/sudoers
    if [ $? -eq 0 ] ; then
    	sed -i -r "s/(.*)Defaults(.*)\!visiblepw/Defaults		visiblepw/g" /etc/sudoers
    else
    	echo "Defaults		visiblepw" >> /etc/sudoers
    fi
    
    }

# 设置文件权限
function configurepermission(){
    setenforce 0
    mkdir /var/log/zabbix/ && chown zabbix:zabbix /var/log/zabbix/ && chmod 777 /var/log/zabbix/ && touch  /var/log/zabbix/zabbix_agentd.log && chmod 777 /var/log/zabbix/zabbix_agentd.log
    #创建/var/log/zabbix/并给予权限。
    #chown zabbix:zabbix /var/log/zabbix/
    #chmod 777 /var/log/zabbix/
    #touch  /var/log/zabbix/zabbix_agentd.log
    #chmod 777 /var/log/zabbix/zabbix_agentd.log
    #拷贝启动脚本
    configfile='/etc/zabbix/zabbix_agentd.conf'
    #创建zabbix用户和组
    groupadd zabbix
    useradd -g zabbix zabbix -s /sbin/nologin
    #新建zabbix用户并将其加入到zabbix组，并将他设置为不可登录的类型的用户。
    #下载
    mkdir ~/zabbix-agent
    mkdir /etc/zabbix/
    cd ~/zabbix-agent/zabbix-5.0.8/conf
    #这里面有一个zabbix_agentd.conf，这个就是zabbix-agent的配置文件我们将它copy到/ect/zzabbix/目录下面。生效的是 /etc/zabbix/zabbix_agentd.conf
    cp ~/zabbix-agent/zabbix-5.0.8/conf/zabbix_agentd.conf $configfile
    
# 写入配置 
    }

function openfirewall(){
	if [ "$OS" = "Ubuntu" ];then
	    firewall-cmd --permanent --add-port=10050-10051/tcp
	    firewall-cmd --reload
	elif [ $CentOS_RHEL_version -eq 7 ];then
	    firewall-cmd --permanent --add-port=10050-10051/tcp
	    firewall-cmd --reload
	elif [ $CentOS_RHEL_version -eq 8 ];then
	    firewall-cmd --permanent --add-port=10050-10051/tcp
	    firewall-cmd --reload    
	elif [ $CentOS_RHEL_version -eq 6 -o $CentOS_RHEL_version -eq 5 ];then
	    iptables -m state --state ESTABLISHED,RELATED -A INPUT -p tcp --dport 10050 -j ACCEPT
	    iptables -m state --state ESTABLISHED,RELATED -A OUTPUT -p tcp --dport 10051 -j ACCEPT
	    service iptables save # /etc/rc.d/init.d/iptables save 写入 /etc/sysconfig/iptables文件 重启后还会保留。
	    service iptables restart
	    fi
}

function start(){
    /usr/sbin/zabbix_agentd -c $configfile #启动zabbix客户端 
}

# 开机自动启动

check
configurepermission
downloadinstall
configureconf $1
openfirewall
start

#启动检查
#ps -ef | grep zabbix
