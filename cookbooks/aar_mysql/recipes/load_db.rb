#
# Cookbook:: aar_mysql
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Which host are we using
case node[Chef::Config.policy_group]
when 'acceptance', 'production'
  db_host = node[Chef::Config.policy_group]['aar_app']['db_host']
else
  db_host = node['aar_app']['db_host']
end

# install the AAR schema
cookbook_file "/tmp/AAR_db.sql" do
  source "AAR_db.sql"
  action :create
end

execute "createdb" do
  command "mysql -u root --host #{db_host} < \"/tmp/AAR_db.sql\""
  not_if "mysql -u root --host #{db_host} -e \"show databases\" | grep AARdb"
  action :run
end

execute "create aar user" do
  command "mysql -u root --host #{db_host} -e \"GRANT CREATE,INSERT,DELETE,UPDATE,SELECT on AARdb.* to 'aarapp'@'%' IDENTIFIED BY '#{node['aar_mysql']['db_pw']}'\""
  not_if "mysql -u root --host #{db_host} -e \"select * from mysql.user where user='aarapp'\" | grep aarapp"
  action :run
end


