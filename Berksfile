Encoding.default_external = "UTF-8"
source 'https://supermarket.chef.io'
metadata


cookbook 'java'
cookbook 'hadoop', github: 'hopshadoop/apache-hadoop-chef'
cookbook 'kagent', github: 'karamelchef/kagent-chef'
cookbook 'ndb', github: 'hopshadoop/ndb-chef'
#cookbook 'hostsfile'
# cookbook "aws", ">= 2.2.2"
# This is here until bmhatfield/chef-ulimit#41 is merged and a new version of the cookbook is released
# cookbook 'ulimit', github: 'wolf31o2/ulimit_cookbook', ref: 'feature/matchers'

group :testing do
  cookbook 'hostsfile'
end