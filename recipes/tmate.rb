#
# Cookbook Name:: vaamo_tmate
# Recipe:: tmate
#
# Copyright (C) 2015 Vaamo Finanz AG
#
# All rights reserved - Do Not Redistribute
#

package node['tmate']['dependencies']

user node['tmate']['username'] do
  comment 'A service user for tmate'
  home node['tmate']['home_dir']
  manage_home true
  shell '/bin/false'
end

directory node['tmate']['log_dir'] do
  owner node['tmate']['username']
  group node['tmate']['username']
  mode 0755
  action :create
end

directory "#{node['tmate']['home_dir']}/bin" do
  owner node['tmate']['username']
  group node['tmate']['username']
  mode 0755
  action :create
end

git node['tmate']['src_dir'] do
  repository node['tmate']['repo_url']
  action :sync
end

execute 'create_keys' do
  cwd node['tmate']['home_dir']
  command "#{node['tmate']['src_dir']}/create_keys.sh"
  creates "#{node['tmate']['home_dir']}/keys"
end

execute 'compile_all_the_things' do
  cwd node['tmate']['src_dir']
  command './autogen.sh && ./configure && make'
  creates "#{node['tmate']['src_dir']}/tmate-slave"
end

link "#{node['tmate']['binary_dir']}/tmate-slave" do
  to "#{node['tmate']['src_dir']}/tmate-slave"
end

directory node['tmate']['cfg_dir']

link "#{node['tmate']['cfg_dir']}/keys" do
  to "#{node['tmate']['home_dir']}/keys"
end

template '/etc/init/tmate-slave.conf' do
  source 'vaamo-tmate.init.erb'
  owner 'root'
  group 'root'
  mode 0755
end

service 'tmate-slave' do
  action [:start, :enable]
end
