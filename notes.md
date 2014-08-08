# Chef todo:

1. Rip out all the mongodb/depricated shit
2. understand how it works by fixing it. 
3. get chef-zero working with vagrant?
4. need some way to deal with sql crap

to test it looks like we need to add this to a node's run list..?

this chef recipe does a lot of stuff I do in my deb builder script, notably making the .conf and executable


--------
directory:

attributes/default.rb : sets some state variables?
recipies/default.rb : huge entire recipe for setting up scylla, looks like it actually gets it from github and builds it. 
    questions ->
        `template '/etc/init/scylla.conf' do` does it just know to get the erb in templates/ ?
            | because bin/scylla do has a source param


questions for realzies
- how do I actually run this shit for myself so I can see how it works?
    - have chef-zero, vagrant I can get to with --ssh-user root --ssh-password vagrant -p 2222

- what am I going to have to do to just install a deb package
    assuming:
        1. build deb, shove it into s3
        2. chef grabs it from s3
        3. does some diddling.

//mabe make-deb.sh should package the node app and then let chef build the conf/bin/etc, even though its pretty much only going to be installed to ubuntu
