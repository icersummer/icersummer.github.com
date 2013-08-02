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

```
// Site specifc YARN configuration properties
<property>
  <name>yarn.nodemanager.aux-services</name>
  <value>mapreduce.shuffle</value>
</property>

<property>
  <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
  <value>org.apache.hadoop.mapred.ShuffleHandler</value>
</property>
```

- core-site.xml ($HADOOP_HOME/etc/hadoop)

```
<configuration>

 <property>
    <name>fs.default.name</name>
    <value>hdfs://localhost:9000</value>
 </property>

</configuration>
```

- hdfs-site.xml

```
<configuration>

 <property>
    <name>dfs.replication</name>
    <value>1</value>
 </property>

 <property>
   <name>dfs.namenode.name.dir</name>
   <value>file:/home/hduser/hadoop_data/hdfs/namenode</value>
 </property>

 <property>
   <name>dfs.datanode.data.dir</name>
   <value>file:/home/hduser/hadoop_data/hdfs/datanode</value>
 </property>
</configuration>
```

- mapred-site.xml

```
<configuration>
 <property>
   <name>mapreduce.framework.name</name>
   <value>yarn</value>
 </property>
</configuration>
```

6. 格式化namenode

> This step is needed only for the first time. Doing it every time will result in loss of content on HDFS.
>> 注意1 > 1.1注意 > 1.2注意

`hduser@ubuntu:~/hadoop-2.0.5-alpha/bin$ ./hadoop namenode -format`

```
hduser@ubuntu:~/hadoop-2.0.5-alpha/bin$ ./hadoop namenode -format
DEPRECATED: Use of this script to execute hdfs command is deprecated.
Instead use the hdfs command for it.

13/07/31 20:42:11 INFO namenode.NameNode: STARTUP_MSG: 
/************************************************************
STARTUP_MSG: Starting NameNode
STARTUP_MSG:   host = ubuntu/127.0.1.1
STARTUP_MSG:   args = [-format]
STARTUP_MSG:   version = 2.0.5-alpha
STARTUP_MSG:   classpath = /home/hduser/hadoop-2.0.5-alpha/etc/hadoop:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-configuration-1.6.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jettison-1.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/snappy-java-1.0.3.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jackson-mapper-asl-1.8.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-cli-1.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jsp-api-2.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-beanutils-core-1.8.0.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jaxb-impl-2.2.3-1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-httpclient-3.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/xmlenc-0.52.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/guava-11.0.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/protobuf-java-2.4.0a.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-el-1.0.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jetty-6.1.26.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jets3t-0.6.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-beanutils-1.7.0.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/asm-3.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/zookeeper-3.4.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-digester-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/avro-1.5.3.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jersey-server-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jasper-compiler-5.5.23.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jackson-core-asl-1.8.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-math-2.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/activation-1.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-lang-2.5.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-collections-3.2.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/paranamer-2.3.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/servlet-api-2.5.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jsch-0.1.42.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-io-2.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jersey-core-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-logging-1.1.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/slf4j-log4j12-1.6.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-net-3.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jsr305-1.3.9.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/log4j-1.2.17.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jackson-xc-1.8.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/hadoop-auth-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jetty-util-6.1.26.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jaxb-api-2.2.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jersey-json-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jackson-jaxrs-1.8.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/stax-api-1.0.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/commons-codec-1.4.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/hadoop-annotations-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/kfs-0.3.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/jasper-runtime-5.5.23.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/lib/slf4j-api-1.6.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/hadoop-common-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/hadoop-common-2.0.5-alpha-tests.jar:/home/hduser/hadoop-2.0.5-alpha/contrib/capacity-scheduler/*.jar:/home/hduser/hadoop-2.0.5-alpha/contrib/capacity-scheduler/*.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/jackson-mapper-asl-1.8.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/commons-cli-1.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/jsp-api-2.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/xmlenc-0.52.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/guava-11.0.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/protobuf-java-2.4.0a.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/commons-el-1.0.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/jetty-6.1.26.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/asm-3.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/jersey-server-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/jackson-core-asl-1.8.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/commons-daemon-1.0.13.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/commons-lang-2.5.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/servlet-api-2.5.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/commons-io-2.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/jersey-core-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/commons-logging-1.1.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/jsr305-1.3.9.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/log4j-1.2.17.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/jetty-util-6.1.26.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/commons-codec-1.4.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/lib/jasper-runtime-5.5.23.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/hadoop-hdfs-2.0.5-alpha-tests.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/hdfs/hadoop-hdfs-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/snappy-java-1.0.3.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/jackson-mapper-asl-1.8.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/guice-servlet-3.0.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/aopalliance-1.0.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/protobuf-java-2.4.0a.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/netty-3.5.11.Final.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/asm-3.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/avro-1.5.3.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/junit-4.8.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/jersey-server-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/jackson-core-asl-1.8.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/paranamer-2.3.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/commons-io-2.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/jersey-core-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/log4j-1.2.17.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/jersey-guice-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/guice-3.0.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/javax.inject-1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/lib/hadoop-annotations-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/hadoop-yarn-server-nodemanager-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/hadoop-yarn-client-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/hadoop-yarn-site-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/hadoop-yarn-server-tests-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/hadoop-yarn-api-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/hadoop-yarn-server-common-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/hadoop-yarn-common-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/hadoop-yarn-applications-unmanaged-am-launcher-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/hadoop-yarn-server-web-proxy-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/hadoop-yarn-server-resourcemanager-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/yarn/hadoop-yarn-applications-distributedshell-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/snappy-java-1.0.3.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/jackson-mapper-asl-1.8.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/guice-servlet-3.0.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/aopalliance-1.0.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/protobuf-java-2.4.0a.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/netty-3.5.11.Final.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/asm-3.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/avro-1.5.3.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/junit-4.8.2.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/jersey-server-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/jackson-core-asl-1.8.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/paranamer-2.3.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/commons-io-2.1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/jersey-core-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/log4j-1.2.17.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/jersey-guice-1.8.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/guice-3.0.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/javax.inject-1.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/lib/hadoop-annotations-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-plugins-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.0.5-alpha-tests.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/hadoop-mapreduce-client-shuffle-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/hadoop-mapreduce-client-app-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.0.5-alpha.jar:/home/hduser/hadoop-2.0.5-alpha/share/hadoop/mapreduce/hadoop-mapreduce-client-common-2.0.5-alpha.jar
STARTUP_MSG:   build = http://svn.apache.org/repos/asf/hadoop/common -r 1488459; compiled by 'jenkins' on 2013-06-01T04:05Z
STARTUP_MSG:   java = 1.7.0_25
************************************************************/
Formatting using clusterid: CID-dcd1e06d-a0f7-450c-b5c8-9f81f40e0114
13/07/31 20:42:12 INFO util.HostsFileReader: Refreshing hosts (include/exclude) list
13/07/31 20:42:12 INFO blockmanagement.DatanodeManager: dfs.block.invalidate.limit=1000
13/07/31 20:42:13 INFO blockmanagement.BlockManager: dfs.block.access.token.enable=false
13/07/31 20:42:13 INFO blockmanagement.BlockManager: defaultReplication         = 1
13/07/31 20:42:13 INFO blockmanagement.BlockManager: maxReplication             = 512
13/07/31 20:42:13 INFO blockmanagement.BlockManager: minReplication             = 1
13/07/31 20:42:13 INFO blockmanagement.BlockManager: maxReplicationStreams      = 2
13/07/31 20:42:13 INFO blockmanagement.BlockManager: shouldCheckForEnoughRacks  = false
13/07/31 20:42:13 INFO blockmanagement.BlockManager: replicationRecheckInterval = 3000
13/07/31 20:42:13 INFO blockmanagement.BlockManager: encryptDataTransfer        = false
13/07/31 20:42:13 INFO namenode.FSNamesystem: fsOwner             = hduser (auth:SIMPLE)
13/07/31 20:42:13 INFO namenode.FSNamesystem: supergroup          = supergroup
13/07/31 20:42:13 INFO namenode.FSNamesystem: isPermissionEnabled = true
13/07/31 20:42:13 INFO namenode.FSNamesystem: HA Enabled: false
13/07/31 20:42:13 INFO namenode.FSNamesystem: Append Enabled: true
13/07/31 20:42:13 INFO namenode.NameNode: Caching file names occuring more than 10 times
13/07/31 20:42:13 INFO namenode.FSNamesystem: dfs.namenode.safemode.threshold-pct = 0.9990000128746033
13/07/31 20:42:13 INFO namenode.FSNamesystem: dfs.namenode.safemode.min.datanodes = 0
13/07/31 20:42:13 INFO namenode.FSNamesystem: dfs.namenode.safemode.extension     = 30000
Re-format filesystem in Storage Directory /home/hduser/hadoop_data/hdfs/namenode ? (Y or N) y
13/07/31 20:42:19 INFO common.Storage: Storage directory /home/hduser/hadoop_data/hdfs/namenode has been successfully formatted.
13/07/31 20:42:19 INFO namenode.FSImage: Saving image file /home/hduser/hadoop_data/hdfs/namenode/current/fsimage.ckpt_0000000000000000000 using no compression
13/07/31 20:42:19 INFO namenode.FSImage: Image file of size 121 saved in 0 seconds.
13/07/31 20:42:19 INFO namenode.NNStorageRetentionManager: Going to retain 1 images with txid >= 0
13/07/31 20:42:19 INFO util.ExitUtil: Exiting with status 0
13/07/31 20:42:19 INFO namenode.NameNode: SHUTDOWN_MSG: 
/************************************************************
SHUTDOWN_MSG: Shutting down NameNode at ubuntu/127.0.1.1
************************************************************/
```

7. start HDFS processes

*Name node*

```
hduser@ubuntu:~/hadoop-2.0.5-alpha/sbin$ ./hadoop-daemon
hadoop-daemon.sh   hadoop-daemons.sh  
hduser@ubuntu:~/hadoop-2.0.5-alpha/sbin$ ./hadoop-daemon.sh  start namenode
starting namenode, logging to /home/hduser/hadoop-2.0.5-alpha/logs/hadoop-hduser-namenode-ubuntu.out
hduser@ubuntu:~/hadoop-2.0.5-alpha/sbin$ jps
The program 'jps' can be found in the following packages:
 * openjdk-6-jdk
 * openjdk-7-jdk
Ask your administrator to install one of them
// 不清楚jps命令是什么，但是这里应该对安装没有影响，已经安装了Oracle JDK 1.7
```

*Data node*

```
hduser@ubuntu:~/hadoop-2.0.5-alpha/sbin$ ./hadoop-daemon.sh start datanode
starting datanode, logging to /home/hduser/hadoop-2.0.5-alpha/logs/hadoop-hduser-datanode-ubuntu.out
```

8. start Hadoop Map-Reduce Processes

*Resource Manager*

```
hduser@ubuntu:~/hadoop-2.0.5-alpha$ sbin/yarn-daemon.sh start resourcemanager
starting resourcemanager, logging to /home/hduser/hadoop-2.0.5-alpha/logs/yarn-hduser-resourcemanager-ubuntu.out
```

*Node Manager*

```
hduser@ubuntu:~/hadoop-2.0.5-alpha$ sbin/yarn-daemon.sh start nodemanager
starting nodemanager, logging to /home/hduser/hadoop-2.0.5-alpha/logs/yarn-hduser-nodemanager-ubuntu.out
```

*Job History Server*

```
hduser@ubuntu:~/hadoop-2.0.5-alpha$ sbin/mr-jobhistory-daemon.sh start historyserver
starting historyserver, logging to /home/hduser/hadoop-2.0.5-alpha/logs/mapred-hduser-historyserver-ubuntu.out
```

9. 运行一个简单/经典的字符统计示例，来验证安装是否成功

```
hduser@ubuntu:~/hadoop-2.0.5-alpha$ mkdir in
hduser@ubuntu:~/hadoop-2.0.5-alpha$ cat > in/file    //这个命令不错
This is one line
This is another one
```

Add this directory to HDFS:

```
hduser@ubuntu:~/hadoop-2.0.5-alpha$ bin/hadoop dfs -copyFromLocal in /in
DEPRECATED: Use of this script to execute hdfs command is deprecated.
Instead use the hdfs command for it.
// note: dfs命令已经被弃用，应用fs命令，见[fs replace dfs](http://stackoverflow.com/questions/11715082/why-is-it-keep-showing-deprecated-error-when-running-hadoop-or-dfs-command)
hduser@ubuntu:~/hadoop-2.0.5-alpha$ ./bin/hadoop fs -copyFromLocal in /in
```

运行share目录中提供的wordcount示例：

`hduser@ubuntu:~/hadoop-2.0.5-alpha/logs$ bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.0.5-alpha.jar wordcount /in /out3`

to continue...

10. 运行_netstat_命令，查看是否Hadoop监听在已经配置的端口

```
hduser@ubuntu:~/hadoop-2.0.5-alpha/logs$ sudo netstat -plten | grep java
[sudo] password for hduser: 
tcp        0      0 0.0.0.0:19888           0.0.0.0:*               LISTEN      1001       33451       6931/java       
tcp        0      0 0.0.0.0:50070           0.0.0.0:*               LISTEN      1001       31961       6436/java       
tcp        0      0 0.0.0.0:50010           0.0.0.0:*               LISTEN      1001       32345       6510/java       
tcp        0      0 0.0.0.0:50075           0.0.0.0:*               LISTEN      1001       32352       6510/java       
tcp        0      0 0.0.0.0:10020           0.0.0.0:*               LISTEN      1001       33459       6931/java       
tcp        0      0 0.0.0.0:50020           0.0.0.0:*               LISTEN      1001       32358       6510/java       
tcp        0      0 127.0.0.1:9000          0.0.0.0:*               LISTEN      1001       31785       6436/java       
tcp6       0      0 :::8042                 :::*                    LISTEN      1001       33369       6825/java       
tcp6       0      0 :::8080                 :::*                    LISTEN      1001       33367       6825/java       
tcp6       0      0 :::8088                 :::*                    LISTEN      1001       32771       6594/java       
tcp6       0      0 :::8030                 :::*                    LISTEN      1001       32823       6594/java       
tcp6       0      0 :::8031                 :::*                    LISTEN      1001       32779       6594/java       
tcp6       0      0 :::8032                 :::*                    LISTEN      1001       32831       6594/java       
tcp6       0      0 :::8033                 :::*                    LISTEN      1001       32843       6594/java       
tcp6       0      0 :::8040                 :::*                    LISTEN      1001       33363       6825/java       
tcp6       0      0 :::37896                :::*                    LISTEN      1001       33353       6825/java       
hduser@ubuntu:~/hadoop-2.0.5-alpha/logs$
```

11. Web界面

- 查看HDFS及其health信息

[http://132.253.222.240:50070](http://132.253.222.240:50070) 或者 [http://132.253.222.240:50070/dfshealth.jsp](http://132.253.222.240:50070/dfshealth.jsp)

- 查看Hadoop All Applications：

[http://132.253.222.240:8088](http://132.253.222.240:8088) 或者 [http://132.253.222.240:8088/cluster](http://132.253.222.240:8088/cluster)

#### 待解问题：

- what's YARN ?

- what's jps ?



