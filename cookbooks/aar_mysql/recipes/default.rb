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
  initial_root_password node.default['aar_mysql']['bdpasswd']
  action [:create, :start]
end

link '/var/run/mysqld/mysqld.sock' do
  to '/var/run/mysql-default/mysqld.sock'
end

# install the AAR schema
cookbook_file "/tmp/AAR_db.sql" do
  source "AAR_db.sql"
  action :create
end

execute "cratedb" do
  command "mysql -u root --socket=/var/run/mysql-AAR_DB/mysqld.sock -ptillylacto < \"/tmp/AAR_db.sql\""
  # not_if {::File.exists?("AARdb")}  how to chk DB exists????
  action :run
end
