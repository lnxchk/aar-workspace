#
# Cookbook:: aar_app
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# need epel for some of the python stuff
include_recipe 'yum-epel'

package 'unzip'

# ensure client libraries are install for mysql
mysql_client 'default' do
  action :create
end

# install python bits
package 'mod_wsgi.x86_64' do
  action :install
end

package 'python2-pip'
package 'MySQL-python'

# install Flask
execute "install Flask" do
  command "pip install Flask"
end

# get an apache server running
apache2_install 'default'

service 'apache2' do
  service_name 'httpd'
  supports restart: true, status: true, reload: true
  action [:start, :enable]
end

apache2_module 'wsgi'

# pull down the code, put it in the dir
remote_file "/tmp/AAR-master.zip" do
  source "https://github.com/lnxchk/Awesome-Appliance-Repair/archive/master.zip"
end

execute "unzip" do
  command "cd /tmp; unzip AAR-master.zip"
  not_if {::File.exists?("/var/www/AAR")}
end

execute "move" do
  command "mv /tmp/Awesome-Appliance-Repair-master/AAR /var/www"
  not_if {::File.exists?("/var/www/AAR")}
end

execute "chown dir" do
  command "chown -R #{node['aar_app']['www_user']}:#{node['aar_app']['www_group']} /var/www/AAR"
end

# set up the apache conf file for the app
template "/etc/httpd/sites-available/AAR.conf" do
  source "AAR-apache.conf.erb"
  owner #{node['aar_app']['www_user']}
  group #{node['aar_app']['www_group']}
  variables(
    :logdir => node['aar_app']['logdir'],
    :user => node['aar_app']['www_user'],
    :group => node['aar_app']['www_group']
  )
#  notifies :restart, "service[apache2]"
  notifies :run, "execute[enable]"
  notifies :reload, "service[apache2]"
end

execute "enable" do
  command "a2ensite AAR"
  not_if {::File.exists?("/etc/httpd/sites-enabled/AAR.conf")}
end
# set up the app 
template "/var/www/AAR/AAR_config.py" do
	source "AAR_config.py.erb"
end

# centos and rhel lock down the run dirs and that breaks wsgi
execute "chown run" do
  command "chgrp #{node['aar_app']['www_user']} /var/run/httpd"
end
