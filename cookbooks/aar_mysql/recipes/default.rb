#
# Cookbook:: aar_mysql
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# mysql still hates selinux. this app is old and i'm not sure it will like mariadb
selinux_state "SELinux Disabled" do
  action :disabled
end

# install the database service
mysql_service 'AAR_DB' do
  port '3306'
  version '5.6'
  initial_root_password node.default['aar_mysql']['db_root']
  action [:create, :start]
end

link '/var/run/mysqld/mysqld.sock' do
  to '/var/run/mysql-AAR_DB/mysqld.sock'
end

# install the AAR schema
cookbook_file "/tmp/AAR_db.sql" do
  source "AAR_db.sql"
  action :create
end

execute "createdb" do
  command "mysql -u root --socket=#{node['aar_mysql']['db_sock']} -p#{node['aar_mysql']['db_root']} < \"/tmp/AAR_db.sql\""
  not_if {::File.exists?("/var/lib/mysql-AAR_DB/AARdb/")} 
  action :run
end

execute "create aar user" do
  command "mysql -u root --socket=#{node['aar_mysql']['db_sock']} -p#{node['aar_mysql']['db_root']} -e \"GRANT CREATE,INSERT,DELETE,UPDATE,SELECT on AARdb.* to 'aarapp'@'localhost' IDENTIFIED BY '#{node['aar_mysql']['db_pw']}'\""
  action :run
end


