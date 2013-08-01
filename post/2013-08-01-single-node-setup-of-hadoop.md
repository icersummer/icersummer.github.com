-- Filename: 2013-08-01-single-node-setup-of-hadoop.md

## Single-Node setup of Hadoop

1. 配置hadoop-env.sh

走到这一步时，是参照[Michael-noll.com上的内容](http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-single-node-cluster/)，但是需要配置$HADOOP_HOME/conf/hadoop-env.sh了，我不清楚他在写此篇博客时是基于Hadoop哪个版本，但是在我当前版本-2.0.5-alpha，并没有此目录；所以以下内容和记录转向参考[Install Hadoop 2.0.1-alpha Yarn Next-Gen](http://raseshmori.wordpress.com/2012/09/23/install-hadoop-2-0-1-yarn-nextgen/).

```
hduser@ubuntu:~/hadoop-2.0.5-alpha/etc/hadoop$ hadoop version
Hadoop 2.0.5-alpha
Subversion http://svn.apache.org/repos/asf/hadoop/common -r 1488459
Compiled by jenkins on 2013-06-01T04:05Z
From source with checksum c8f4bd45ac25c31b815f311b32ef17
This command was run using /home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/hadoop-common-2.0.5-alpha.jar
```

2. 需要安装Tarball么，先不安装，待定。

3. 配置环境变量

.bashrc:
```
// configure follow raseshmori.wordpress.com
HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME

HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME

HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME

HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_HDFS_HOME
```

4. 创建2个目录，用于存储namenode和datanode的数据

```
hduser@ubuntu:~$ pwd
/home/hduser
hduser@ubuntu:~$ ls
bak.of.bashrc  examples.desktop  hadoop-2.0.5-alpha  hadoop-2.0.5-alpha.tar.gz
hduser@ubuntu:~$ mkdir hadoop_data
hduser@ubuntu:~$ cd hadoop_data/
hduser@ubuntu:~/hadoop_data$ ls
hduser@ubuntu:~/hadoop_data$ mkdir hdfs
hduser@ubuntu:~/hadoop_data$ cd hdfs/
hduser@ubuntu:~/hadoop_data/hdfs$ mkdir namenode
hduser@ubuntu:~/hadoop_data/hdfs$ mkdir datanode
hduser@ubuntu:~/hadoop_data/hdfs$ pwd
/home/hduser/hadoop_data/hdfs
```

5. 设置Properties在Config文件中：

- yarn-site.xml ($HADOOP_HOME/etc/hadoop)



- core-site.xml ($HADOOP_HOME/etc/hadoop)



#### 待解问题：

- what's YARN?



