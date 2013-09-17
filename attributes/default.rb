override['nodejs']['install_method'] = 'package'
override['nodejs']['dir'] = '/usr'
override['npm']['version'] = '1.3.5'

default['scylla']['prefix'] = '/usr/local'
default['scylla']['localstatedir'] = '/var'
default['scylla']['user'] = 'scylla'
default['scylla']['repo'] = 'https://github.com/simplymeasured/scylla.git'
default['scylla']['reference'] = 'master'

default['scylla']['mail_user'] = 'username'
default['scylla']['mail_key'] = 'password'
