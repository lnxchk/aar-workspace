name 'aar-host-el'
default_source :supermarket
run_list 'yum-mysql-community::mysql56','aar_mysql::default','aar_app::default'
cookbook 'aar_mysql', path: '../cookbooks/aar_mysql'
cookbook 'aar_app', path: '../cookbooks/aar_app'

default['acceptance']['aar_app']['db_host'] = '127.0.0.1'
default['production']['aar_app']['db_host'] = '172.31.37.51'
default['aar_app']['db_host'] = '127.0.0.1'
