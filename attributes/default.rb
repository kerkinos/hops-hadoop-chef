default[:hops][:version]                   = "2.4.0"

include_attribute "kagent"
include_attribute "hadoop"
include_attribute "ndb"


default[:hops][:download_url]              = "#{node[:download_url]}/hops-#{node[:hadoop][:version]}.tgz"
default[:hops][:hadoop_src_url]            = "#{node[:download_url]}/hadoop-#{node[:hadoop][:version]}-src.tar.gz"

default[:hadoop][:leader_check_interval_ms]= 1000
default[:hadoop][:missed_hb]               = 1
default[:hadoop][:db]                      = "hops"
default[:hadoop][:max_retries]             = 0

# set the location of libndbclient.so. set-env.sh sets LD_LIBRARY_PATH to find this library.
default[:ndb][:libndb]                     = "#{default[:mysql][:version_dir]}/lib"
default[:mysql][:port]                     = default[:ndb][:mysql_port]
default[:hadoop][:mysql_url]               = "jdbc:mysql://#{default[:ndb][:mysql_ip]}:#{default[:ndb][:mysql_port]}/"

default[:hops][:log_level]                 = "DEBUG"

default[:dal][:download_url]               = "#{node[:download_url]}/ndb-dal-#{node[:hadoop][:version]}-#{node[:ndb][:version]}.jar"
default[:dal][:lib_url]                    = "#{node[:download_url]}/lib-hopsndb-#{node[:hadoop][:version]}-#{node[:ndb][:version]}.so"
default[:clusterj][:download_url]          = "#{node[:download_url]}/clusterj-#{node[:ndb][:version]}.jar"
default[:dal][:schema_url]                 = "#{node[:download_url]}/hops.sql"

default[:hops][:recipes]                   = %w{ nn dn rm nm jhs ps } 

# limits.d settings
default[:hops][:limits][:nofile]           = '32768'
default[:hops][:limits][:nproc]            = '65536'

#default[:hops][:hadoop_env][:hadoop_opts]  = '-Djava.net.preferIPv4Stack=true ${HADOOP_OPTS}'
#default[:hops][:mapred_env][:hadoop_opts]  = '-Djava.net.preferIPv4Stack=true ${HADOOP_OPTS}'

default[:hops][:nn][:direct_memory_size]   = 500
default[:hops][:nn][:heap_size]            = 500

default[:hops][:nn][:public_ips]           = ['10.0.2.15']
default[:hops][:nn][:private_ips]          = ['10.0.2.15']
default[:hops][:dn][:public_ips]           = ['10.0.2.15']
default[:hops][:dn][:private_ips]          = ['10.0.2.15']
default[:hops][:rm][:public_ips]           = ['10.0.2.15']
default[:hops][:rm][:private_ips]          = ['10.0.2.15']
default[:hops][:nm][:public_ips]           = ['10.0.2.15']
default[:hops][:nm][:private_ips]          = ['10.0.2.15']
default[:hops][:jhs][:public_ips]          = ['10.0.2.15']
default[:hops][:jhs][:private_ips]         = ['10.0.2.15']
default[:hops][:ps][:public_ips]           = ['10.0.2.15']
default[:hops][:ps][:private_ips]          = ['10.0.2.15'] 

default[:hops][:yarn][:resource_tracker]   = "false"

default[:hops][:use_hopsworks]             = "false"

# Blocksize given in Bytes. 134217728 = 128MB
default[:hdfs][:blocksize]                 = 134217728 

default[:hops][:erasure_coding]            = "true"

default[:hops][:nn][:cache]                = "true"
default[:hops][:nn][:partition_key]        = "true"

default[:vagrant]                          = "false"

node.normal[:mysql][:user]                 = node[:mysql][:user]
node.normal[:mysql][:password]             = node[:mysql][:password]

