override['nodejs']['install_method'] = 'package'
override['nodejs']['dir'] = '/usr'
override['npm']['version'] = '1.3.5'

default['scylla']['prefix'] = '/opt/sm'
default['scylla']['localstatedir'] = '/var'
default['scylla']['user'] = 'scylla'
default['scylla']['repo'] = 'https://github.com/simplymeasured/scylla.git'
default['scylla']['reference'] = 'master'

default['scylla']['mail_user'] = 'username'
default['scylla']['mail_key'] = 'password'

default['scylla']['storage_base'] = '/opt/sm/scylla/images'
default['scylla']['storage_resources'] = 'resources'

# need to abstract this out to databags
default['scylla']['database_user'] = 'scylla'
default['scylla']['database_password'] = 'scylla'
default['scylla']['database_dialect'] = 'mysql'

