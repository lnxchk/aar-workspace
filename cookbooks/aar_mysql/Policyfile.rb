# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'aar_mysql'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'yum-mysql-community::mysql56','aar_mysql::default'

# Specify a custom source for a single cookbook:
cookbook 'aar_mysql', path: '.'


default['aar_mysql']['db_sock'] = '/var/run/mysql-AAR_DB/mysqld.sock'
default['aar_mysql']['db_name'] = 'AARdb'
default['aar_mysql']['db_user'] = "aarapp"
default['aar_mysql']['db_pw'] = "trystatone"
default['aar_mysql']['db_root'] = 'tillylacto'

