#
# Cookbook:: aar_app
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# create the app user on the database
mysql -u root --socket=/var/run/mysql-AAR_DB/mysqld.sock -ptillylacto
