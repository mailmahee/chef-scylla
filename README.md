Scylla Cookbook [![Build Status]((https://www.recipe-tester.com/repo/simplymeasured/chef-scylla/badge.png)](https://www.recipe-tester.com/repo/simplymeasured/chef-scylla/)
===============

Installs and configures a [scylla](https://github.com/simplymeasured/scylla) server.

Usage
-----

Just include `scylla` in your node or role's `run_list`:

```ruby
name 'scylla'

run_list [
  'recipe[scylla]'
]
```

Requirements
------------
### Chef

Tested on 11.6.0 but newer and older versions (of 11.x)
should work just fine.

File an [issue][issues] if this isn't the case.

### Platforms: ###

`scylla` has only been tested on the following platform:

* Ubuntu 12.04

Please [report][issues] any additional platforms so they can be added.

### Recipes: ###

* 'git'
* 'imagemagick'
* 'mongodb::10gen_repo'
* 'mongodb'
* 'nodejs'
* 'npm'

### Resources ###

* `npm_package`: from the npm cookbook

Installation
------------

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

### Using Berkshelf

[Berkshelf][berkshelf] is a way to manage a cookbook or an application's
cookbook dependencies. Include the cookbook in your Berksfile, and then run
`berks install`. To install using Berkshelf:

    gem install berkshelf
    cd chef-repo
    berks init
    cat >> Berksfile <<END_OF_BERKSFILE
    cookbook 'scylla', github: 'simplymeasured/chef-scylla'
    END_OF_BERKSFILE
    berks install

### Using Librarian-Chef

[Librarian-Chef][librarian] is a bundler for your Chef cookbooks.
Include a reference to the cookbook in a [Cheffile][cheffile] and run
`librarian-chef install`. To install Librarian-Chef:

    gem install librarian
    cd chef-repo
    librarian-chef init
    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'scylla', git: 'git://github.com/simplymeasured/chef-scylla.git'
    END_OF_CHEFFILE
    librarian-chef install

Attributes:
-----------

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['scylla']['prefix']</tt></td>
    <td>String</td>
    <td>per autotools/GNU Coding Standards, the prefix used for installing most parts of the program, especially executables and libraries</td>
    <td><tt>/opt</tt></td>
  </tr>
  <tr>
    <td><tt>['scylla']['localstatedir']</tt></td>
    <td>String</td>
    <td>per autotools/GNU Coding Standards: the directory for installing data files which the programs modify while they run, and that pertain to one specific machine. Users should never need to modify files in this directory to configure the package's operation; configuration information should go in `sysconfdir`. In particular: caches, logs & pid files.</td>
    <td><tt>/var</tt></td>
  </tr>
  <tr>
    <td><tt>['scylla']['user']</tt></td>
    <td>String</td>
    <td>user that runs the scylla service</td>
    <td><tt>`scylla`</tt></td>
  </tr>
  <tr>
    <td><tt>['scylla']['repo']</tt></td>
    <td>String</td>
    <td>git source code repository for scylla</td>
    <td><tt>'https://github.com/simplymeasured/scylla.git'</tt></td>
  </tr>
  <tr>
    <td><tt>['scylla']['reference']</tt></td>
    <td>String</td>
    <td>git referecence for the version of scylla to be deployed</td>
    <td><tt>'master'</tt></td>
  </tr>
</table>

Contributing
------------

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every seperate change you make.

### Testing

Make sure you have the following requirements setup:

* [Vagrant][vagrant]
* [vagrant-verkshelf][vagrant-verkshelf]

After you `bundle install` run `rake` for unit tests and `kitchen test` for
integration level tests.

### TODO

* support external mongodb service
* add nagios checks
* add statsd disco
* support package install (vs source)
* support non-upstart init
* travis-ci checks


License and Author
------------------

Author:: [Joseph Holsten][josephholsten] (<joseph@josephholsten.com>) [![endorse](http://api.coderwall.com/josephholsten/endorsecount.png)][coderwall]

Contributors:: https://github.com/simplymeasured/chef-scylla/contributors

Copyright:: 2013 Simply Measured

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[berkshelf]:         http://berkshelf.com
[cheffile]:          https://github.com/applicationsonline/librarian/blob/master/lib/librarian/chef/templates/Cheffile
[librarian]:         https://github.com/applicationsonline/librarian#readme
[vagrant]:           http://vagrantup.com
[vagrant-verkshelf]: https://github.com/riotgames/vagrant-berkshelf

[chef_repo]:            https://github.com/opscode/chef-repo
[josephholsten]:        https://github.com/josephholsten
[coderwall]:            http://coderwall.com/josephholsten

[repo]:         https://github.com/simplymeasured/chef-scylla
[issues]:       https://github.com/simplymeasured/chef-scylla/issues
