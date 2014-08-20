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

include_recipe 'build-essential'
include_recipe 'imagemagick'
include_recipe 'nodejs'

directory "#{node['scylla']['prefix']}/scylla/images/resources" do
  owner 'root'
  group 'root'
  mode '775'
  recursive true
  action :create
end

directory "#{node['scylla']['prefix']}/scylla/config" do
  owner 'root'
  group 'root'
  mode '775'
  recursive true
  action :create
end

template "#{node['scylla']['prefix']}/scylla/config/storage.js" do
  owner 'root'
  group 'root'
  mode '664'
  variables(
    scylla: node['scylla']
  )
end

template "#{node['scylla']['prefix']}/scylla/config/database.js" do
  owner 'root'
  group 'root'
  mode '664'
  variables(
    scylla: node['scylla']
  )
end

service 'scylla' do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
