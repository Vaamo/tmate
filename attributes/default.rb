#
# Cookbook Name:: vaamo_tmate
# Attributes:: default
#
# Copyright (C) 2014 Vaamo Finanz AG
#
# All rights reserved - Do Not Redistribute
#

default['tmate']['repo_url']     = 'https://github.com/nviennot/tmate-slave.git'
default['tmate']['binary_name']  = 'tmate-slave'
default['tmate']['username']     = 'tmate'
default['tmate']['home_prefix']  = '/home'
default['tmate']['binary_dir']   = '/usr/local/bin'
default['tmate']['cfg_dir']      = '/usr/local/etc/tmate'
default['tmate']['home_dir']     = "#{node['tmate']['home_prefix']}/#{node['tmate']['username']}"
default['tmate']['key_dir']      = "#{node['tmate']['home_dir']}/keys"
default['tmate']['src_dir']      = "#{node['tmate']['home_dir']}/src"
default['tmate']['log_dir']      = '/var/log/tmate'
default['tmate']['log_file']     = "#{node['tmate']['log_dir']}/tmate.log"
default['tmate']['host']         = node['fqdn']
default['tmate']['port']         = 2222
default['tmate']['dependencies'] = %w(
  git-core build-essential pkg-config libtool libevent-dev libncurses-dev
  zlib1g-dev automake libssh-dev cmake ruby
)
