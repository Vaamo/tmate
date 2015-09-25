#
# Cookbook Name:: tmate
# Attributes:: default
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

default['tmate']['repo_url']     = 'https://github.com/nviennot/tmate-slave.git'
default['tmate']['binary_name']  = 'tmate-slave'
default['tmate']['username']     = 'tmate'
default['tmate']['home_prefix']  = '/home'
default['tmate']['binary_dir']   = '/usr/local/bin'
default['tmate']['cfg_dir']      = '/usr/local/etc/tmate'
default['tmate']['home_dir']     = "#{node['tmate']['home_prefix']}/#{node['tmate']['username']}"
default['tmate']['key_dir']      = "#{node['tmate']['cfg_dir']}/keys"
default['tmate']['src_dir']      = "#{node['tmate']['home_dir']}/src"
default['tmate']['log_dir']      = '/var/log/tmate'
default['tmate']['log_file']     = "#{node['tmate']['log_dir']}/tmate.log"
default['tmate']['host']         = node['fqdn']
default['tmate']['port']         = 2222
default['tmate']['dependencies'] = %w(
  git-core build-essential pkg-config libtool libevent-dev libncurses-dev
  zlib1g-dev automake libssh-dev cmake ruby
)
