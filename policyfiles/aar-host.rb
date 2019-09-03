# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'aar-host'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'yum-mysql-community::mysql56','aar_mysql::default','aar_app::default'

# Specify a custom source for a single cookbook:
# cookbook 'example_cookbook', path: '../cookbooks/example_cookbook'
cookbook 'aar_mysql', path: '../cookbooks/aar_mysql'
cookbook 'aar_app', path: '../cookbooks/aar_app'

include_policy 'base', policy_name: "base", policy_group: "acceptance", server: "https://manage.chef.io/organizations/mandi_learnchef"

default['acceptance']['aar_app']['db_host'] = '127.0.0.1'
default['production']['aar_app']['db_host'] = '172.31.37.51'
default['aar_app']['db_host'] = '127.0.0.1'
