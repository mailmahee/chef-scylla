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


to get chef going

cd chef repo
export CHEF_USER=‘stefan’
bundle exec berks install --path vendor/cookbooks
bundle exec rake server:start


to see all cookbooks in the server 
export CHEF_SERVER_URL='http://localhost:4444'
bundle exec knife cookbook list --all  


------------------

12/8/2014
Notes from Dusty:
    - version (and arch) will come from package.json (somehow)
    - jenkins will build the deb
    - grunt-release will incrememt the version

questions/todo for today
    - timeline for getting sql stuff setup? will it be a specific mysql-scylla cookbook/recipe, or generic
    - breaking apart stuff/getting kickover time faster
    - start stubbing out storage.js and images.js
    - not totally sure what images.js does, will check out with local version of scylla later
    - integration with deployer?
    - verifying scylla actually will work and stuff

Notes from Chris/Dusty
    - **Deployer** will take care of pushing deb to box
    - will also provide sql creds or something, which I will then replace attributes/whatever (data bags?)



```
#Stefan Dierauf June 2014
#Stefan's .bash_profile

# Remember:
# ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime

alias a="ssh sdierauf@attu.cs.washington.edu"
alias mv="mv -i"
alias cp="cp -i"
alias attu="a"
alias ntest="ping google.com"
alias ll="ls -alG"
alias ls="ls -G"
alias grep="grep --color=auto"
alias myip="ifconfig | grep -e ' broadcast '"
alias site="ssh root@107.170.122.111"
alias be="bundle exec"
alias ber="bundle exec rake"
alias kick="vagrant halt && vagrant up && vagrant provision"
alias cur="cd ~/proj/sm-bootstrap-angular"
alias kickberks="sed -i.bak '49,53d' Berksfile.lock && export CHEF_USER=‘stefan’ && be berks install --path vendor/cookbooks && ber server:stop && ber server:start && export CHEF_SERVER_URL='http://localhost:4444'"
alias pyserve="python -m SimpleHTTPServer"
echo Welcome back, Stefan. You are exceptionally handsome today.

export CHEF_USER='stefan'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
source /usr/local/share/chruby/chruby.sh
```