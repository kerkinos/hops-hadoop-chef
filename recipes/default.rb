# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2015, KTH
#
# All rights reserved - Do Not Redistribute
#


require 'resolv'

nnPort=node[:hadoop][:nn][:port]
my_ip = my_private_ip()
my_public_ip = my_public_ip()
rm_private_ip = private_recipe_ip("hops","rm")
rm_public_ip = public_recipe_ip("hops","rm")



if "#{node["vagrant"]}" == "true"
   hostsfile_entry "#{my_ip}" do
     hostname  node['fqdn']
     action    :create
     unique    true
   end
   hostsfile_entry "#{my_ip}" do
     hostname  node['hostname']
     action    :create
     unique    true
   end
end


include_recipe "hops::wrap"
include_recipe "hadoop::default"

# Convert all private_ips to their hostnames
# Hadoop requires fqdns to work - won't work with IPs
hostf = Resolv::Hosts.new

ndb_connectstring()

jdbc_url()


firstNN = "hdfs://" + private_recipe_ip("hops", "nn") + ":#{nnPort}"
rpcNN = private_recipe_ip("hops", "nn") + ":#{nnPort}"

# allNNs = ""

if node[:hops][:nn][:private_ips].length > 1 
  allNNIps = node[:hops][:nn][:private_ips].join(":#{nnPort},") + ":#{nnPort}"
else
  allNNIps = "#{node[:hops][:nn][:private_ips][0]}" + ":#{nnPort}"
end

hopsworksNodes = ""
if node[:hops][:use_hopsworks].eql? "true"
  hopsworksNodes = node[:hopsworks][:default][:private_ips].join(",")
end

file "#{node[:hadoop][:home]}/etc/hadoop/core-site.xml" do 
  owner node[:hdfs][:user]
  action :delete
end

template "#{node[:hadoop][:home]}/etc/hadoop/core-site.xml" do 
  source "core-site.xml.erb"
  owner node[:hdfs][:user]
  group node[:hadoop][:group]
  mode "755"
  variables({
              :firstNN => firstNN,
              :hopsworks => hopsworksNodes,
              :allNNs => allNNIps
            })
end

file "#{node[:hadoop][:home]}/etc/hadoop/hdfs-site.xml" do 
  owner node[:hdfs][:user]
  action :delete
end

template "#{node[:hadoop][:conf_dir]}/hdfs-site.xml" do
  source "hdfs-site.xml.erb"
  owner node[:hdfs][:user]
  group node[:hadoop][:group]
  mode "755"
  variables({
              :firstNN => firstNN
            })
end

template "#{node[:hadoop][:conf_dir]}/erasure-coding.xml" do
  source "erasure-coding.xml.erb"
  owner node[:hdfs][:user]
  group node[:hadoop][:group]
  mode "755"
end
