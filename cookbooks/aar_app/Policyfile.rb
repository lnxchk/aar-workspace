# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'aar_app'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'aar_app::default'

# Specify a custom source for a single cookbook:
cookbook 'aar_app', path: '.'

default['aar_app']['db_host'] = '172.31.39.16'
default['aar_app']['db_port'] = '3306'
default['aar_app']['db_name'] = 'AAR_DB'
default['aar_app']['db_user'] = "aarapp"
default['aar_app']['db_pw'] = "trystatone"
default['aar_app']['db_root'] = "tillylacto"

