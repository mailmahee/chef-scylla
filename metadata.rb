name             'scylla'
maintainer       'Simply Measured'
maintainer_email 'ops@simplymeasured.com'
license          'All rights reserved'
description      'Installs/Configures chef-scylla'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.14'

depends 'imagemagick'
depends 'nodejs'
depends 'npm'
depends 'sm-service'
depends 'build-essential'
