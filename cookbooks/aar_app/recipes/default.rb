#
# Cookbook:: aar_app
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# need epel for some of the python stuff
include_recipe 'yum-epel'

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

# get an apache server running
apache2_install 'default'

