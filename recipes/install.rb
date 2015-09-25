#
# Cookbook Name:: tmate
# Recipe:: install
#
# Copyright (C) 2015 Vaamo Finanz AG
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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
  user username
  group username
  cwd home_dir
  command "#{src_dir}/create_keys.sh"
  creates "#{home_dir}/keys"
end

# Compile tmate-slave
execute 'compile_all_the_things' do
  user username
  group username
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
