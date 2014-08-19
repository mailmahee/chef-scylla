#
# Cookbook Name:: chef-scylla
# Recipe:: default
#
# Copyright (C) 2014 Stefan Dierauf
# 
# All rights reserved - YOU BETTA NOT COPY THIS MMKAY
# TODO:
# - build storage.js from template
# - mkdir images/resources in the right folder
# - cookbook for mysql?
# - logging to syslog?

# include_recipe 'apt'
# include_recipe 'python'
# include_recipe 'build-essential'
# include_recipe 'git'
include_recipe 'imagemagick'
# include_recipe 'mongodb::10gen_repo'
# include_recipe 'mongodb'
include_recipe 'nodejs'
# include_recipe 'sm-service::database' #hah

# 
# Don't need to do this!
# Deployer will take care of getting and pushing down deb
#

remote_file "/scylla.deb" do
  source "http://10.0.2.2:8000/scylla.deb"
  mode 0644
end

dpkg_package "scylla" do
  action :purge
end

dpkg_package "scylla" do
  source "/scylla.deb"
  action :install
end

file "/scylla.deb" do
  action :delete
end

#
# End deployer snip
#

directory "#{node['scylla']['prefix']}/scylla/images/resources" do
  owner 'root'
  group node['root_group']
  mode '775'
  recursive true
  action :create
end

template "#{node['scylla']['prefix']}/scylla/config/storage.js" do
  owner 'root'
  group node['root_group']
  mode '664'
  variables(
    scylla: node['scylla']
  )
end

template "#{node['scylla']['prefix']}/scylla/config/database.js" do
  owner 'root'
  group node['root_group']
  mode '664'
  variables(
    scylla: node['scylla']
  )
end


# user node['scylla']['user'] do
#   supports manage_home: true
#   manage_home true
#   home "/home/#{node['scylla']['user']}"
# end

# git "#{node['scylla']['prefix']}/scylla" do
#   repository node['scylla']['repo']
#   reference node['scylla']['reference']
#   action :sync
# end

# npm_package 'bower'

# execute 'npm install' do
#   cwd "#{node['scylla']['prefix']}/scylla"
#   user 'root'
# end

# execute 'bower install --allow-root' do
#   cwd "#{node['scylla']['prefix']}/scylla/public"
#   user 'root'
# end

# directory "#{node['scylla']['localstatedir']}/log/scylla" do
#   owner node['scylla']['user']
#   group node['scylla']['group']
# end

# directory "#{node['scylla']['localstatedir']}/run/scylla" do
#   owner node['scylla']['user']
#   group node['scylla']['group']
# end

# template "#{node['scylla']['prefix']}/scylla/config/mail.js" do
#   owner 'root'
#   group node['root_group']
#   mode '644'
#   variables(
#     scylla: node['scylla']
#   )
# end

# template "#{node['scylla']['prefix']}/bin/scylla" do
#   source 'executable.erb'
#   owner 'root'
#   group node['root_group']
#   mode '755'
#   variables(
#     scylla: node['scylla']
#   )
# end

# template '/etc/init/scylla.conf' do
#   owner 'root'
#   group node['root_group']
#   mode '644'
#   variables(
#     scylla: node['scylla']
#   )
# end

# link '/etc/init.d/scylla' do
#   to '/lib/init/upstart-job'
# end

service 'scylla' do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
