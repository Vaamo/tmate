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
  creates "#{node['tmate']['src_dir']}/#{node['tmate']['binary_name']}"
end

directory node['tmate']['cfg_dir']

execute 'move_keys' do
  cwd node['tmate']['home_dir']
  command "mv keys #{node['tmate']['cfg_dir']}"
  creates "#{node['tmate']['key_dir']}"
end

execute 'move_binary' do
  cwd node['tmate']['home_dir']
  command "mv #{node['tmate']['src_dir']}/#{node['tmate']['binary_name']} #{node['tmate']['binary_dir']}"
  creates "#{node['tmate']['binary_dir']}/${node['tmate']['binary_name']}"
end

template "/etc/init/#{node['tmate']['binary_name']}.conf" do
  source 'vaamo-tmate.init.erb'
  owner 'root'
  group 'root'
  mode 0755
end

service "#{node['tmate']['binary_name']}" do
  action [:start, :enable]
end
