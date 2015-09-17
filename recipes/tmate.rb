#
# Cookbook Name:: vaamo_tmate
# Recipe:: tmate
#
# Copyright (C) 2015 Vaamo Finanz AG
#
# All rights reserved - Do Not Redistribute
#

# Declare variables
repo_url = node['tmate']['repo_url']
binary_name = node['tmate']['binary_name']
username = node['tmate']['username']
binary_dir = node['tmate']['binary_dir']
cfg_dir = node['tmate']['cfg_dir']
home_dir = node['tmate']['home_dir']
key_dir = node['tmate']['key_dir']
src_dir = node['tmate']['src_dir']
log_dir = node['tmate']['log_dir']
dependencies = node['tmate']['dependencies']

# Install dependencies
package dependencies

# Create service user
user username do
  comment 'A service user for tmate'
  home home_dir
  manage_home true
  shell '/bin/false'
end

# Create log directory
directory log_dir do
  owner username
  group username
  mode 0755
  action :create
end

# Clone tmate-slave repository
git src_dir do
  repository repo_url
  action :sync
end

# Generate private and public keys
execute 'create_keys' do
  cwd home_dir
  command "#{src_dir}/create_keys.sh"
  creates "#{home_dir}/keys"
end

# Compile tmate-slave
execute 'compile_all_the_things' do
  cwd src_dir
  command './autogen.sh && ./configure && make'
  creates "#{src_dir}/#{binary_name}"
end

# Create configuration directory
directory cfg_dir

# Move private and public keys to the configuration directory
execute 'move_keys' do
  cwd home_dir
  command "mv keys #{cfg_dir}"
  creates key_dir
end

# Move tmate-slave binary to 'binary_dir'
execute 'move_binary' do
  cwd home_dir
  command "mv #{src_dir}/#{binary_name} #{binary_dir}"
  creates "#{binary_dir}/#{binary_name}"
end

# Create upstart script
template "/etc/init/#{binary_name}.conf" do
  source 'vaamo-tmate.init.erb'
  owner 'root'
  group 'root'
  mode 0755
end

# Create, start and enable a service for tmate-slave
service binary_name do
  action [:start, :enable]
end
