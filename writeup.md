# Revitalizing Chef-Scylla

The chef repo for scylla is fairly out of date, and needs to be updated to conform to the new sm-service style of making internal services. This document serves as a record of what I did in order to make those changes

## Development setup

*Warning: the following includes disgusting hacks*

I'm working on chef-scylla using the following things:

1. Chef-zero server run from the simplymeasured/chef repo
2. Nick Hatch's sm-vagrant
3. A branch of chef-scylla
4. (for now) a simple local server for hosting the created deb package.


### Chef-zero

chef-zero acts as a fake chef-server for local testing purposes.

To get this server up and running, run:

1. `bundle install` to install the necessary gems
2. `bundle exec berks install --path vendor/cookbooks` to get non-sm cookbooks. Scylla is not part of our internal cookbooks as it is open source
3. `bundle exec rake server:start` to start the server. This will shove ***EVERY*** cookbook into the chef-zero server

note: in order to use a specific branch of chef-scylla instead of the default, I edited the `Berksfile` to point to the `feature/deb-package` branch of chef-scylla. I also have to delete the "scylla" part of the Berksfile.lock every time (done via `sed -i.bak '49,53d' Berksfile.lock` [which is bad])

After this is all done, you should have a chef-zero server running on port 4444. The full command I use to kick over the chef-zero server every time I push to `feature/deb-package` is

`sed -i.bak '49,53d' Berksfile.lock && export CHEF_USER='stefan' && be berks install --path vendor/cookbooks && ber server:stop && ber server:start && export CHEF_SERVER_URL='http://localhost:4444'`

where `be` is `bundle exec` and `ber` is `bundle exec rake`

### Nick Hatch's sm-vagrant

Nick has provided me with an awesome Vagrantfile that automagically listens to port 4444 on the host machine and runs all the chef stuff when it gets provisioned. After I kick over the chef-zero server, I just have to kick over the vagrant image and it will pull down everything it needs from the chef zero server

Magic lines from the config:

<add magic lines here>

### A branch of chef-scylla

I made a branch of chef-scylla called `feature/deb-package`. See recipes/default.rb to see actual implementation. Currently very minimal, almost nothing implemented

Currently implemented:

* Pull down .deb file
* Install it

To be implemented:

* sql stuff
* mailer stuff (?)
* handle when scylla's version (and arch?) gets bumped
* change host to s3 etc
* checking hash of download?

Unsure about how the .deb file goes about getting packaged, assuming it's going to be a jenkins job when pushed to master

### (for now) a simple local server for hosting the created deb package

I don't know how/don't have access to our s3 repository, so I've just been running a local server hosting the deb package for simulating s3 and making sure it'll actually work

## The Result

It actually works! after running the chef-scylla recipe, the vagrant vm has scylla in bin/ and an upstart script (doesn't appear to actually run though). Scylla doesn't actually *work*, as it is still lacking proper configuration for storage.js (sql stuff) and images.js (sql stuff?)
