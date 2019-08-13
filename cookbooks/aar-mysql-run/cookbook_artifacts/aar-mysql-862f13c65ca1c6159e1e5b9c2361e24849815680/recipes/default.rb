#
# Cookbook:: aar-mysql
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
mysql_service 'default' do
  port '3306'
  version '5.6'
  initial_root_password node.default['aar-mysql']['mysql_root_pass']
  action [:create, :start]
end

#execute 'su mysql'
link '/var/run/mysqld/mysqld.sock' do
  to '/var/run/mysql-default/mysqld.sock'
end
