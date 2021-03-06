require 'spec_helper'


describe service('namenode') do  
  it { should be_enabled   }
  it { should be_running   }
end 

describe service('datanode') do  
  it { should be_enabled   }
  it { should be_running   }
end 

describe service('resourcemanager') do  
  it { should be_enabled   }
  it { should be_running   }
end 

describe service('nodemanager') do  
  it { should be_enabled   }
  it { should be_running   }
end 

describe service('JobHistoryServer') do  
  it { should be_running   }
end 

describe command("/tmp/mysql-cluster/ndb/scripts/mysql-client.sh -e \"show databases\"") do
  its (:stdout) { should match /hops/ }
end

describe command("/tmp/mysql-cluster/ndb/scripts/mgm-client.sh -e \"show\"") do
  its(:exit_status) { should eq 0 }
end

describe command("su hdfs -l -c \"/tmp/hadoop/bin/hdfs dfs -mkdir /hops\"") do
  its(:exit_status) { should eq 0 }
end

describe command("su hdfs -l -c \"/tmp/hadoop/bin/hdfs dfs -ls /\"") do
  its (:stdout) { should match /hops/ }
end

describe command("su hdfs -l -c \"echo 'test data' > /tmp/hopsie\"") do
  its(:exit_status) { should eq 0 }
end

describe command("su hdfs -l -c \"/tmp/hadoop/bin/hdfs dfs -copyFromLocal /tmp/hopsie /hops\"") do
  its(:exit_status) { should eq 0 }
end

describe command("su yarn -l -c \"/tmp/hadoop/bin/yarn jar /tmp/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.4.0.jar pi 1 1000 \"") do
  its (:stdout) { should match /Estimated value of Pi is/ }
end

describe command("service namenode restart") do
  its(:exit_status) { should eq 0 }
end

describe command("service datanode restart") do
  its(:exit_status) { should eq 0 }
end

describe command("service resourcemanager restart") do
  its(:exit_status) { should eq 0 }
end

describe command("service nodemanager restart") do
  its(:exit_status) { should eq 0 }
end

describe command("service historyserver restart") do
  its(:exit_status) { should eq 0 }
end
