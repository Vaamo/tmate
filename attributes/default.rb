#
# Cookbook Name:: vaamo_tmate
# Attributes:: default
#
# Copyright (C) 2014 Vaamo Finanz AG
#
# All rights reserved - Do Not Redistribute
#

default['tmate']['repoURL']      = 'https://github.com/nviennot/tmate-slave.git'
default['tmate']['username']     = 'tmate'
default['tmate']['home_prefix']  = "/opt"
default['tmate']['home_dir']     = "#{node['tmate']['home_prefix']}/#{node['tmate']['username']}"
default['tmate']['src_dir']      = "#{default['tmate']['home_dir']}/src"
default['tmate']['log_dir']      = '/var/log/tmate'
default['tmate']['log_file']     = '/var/log/tmate/tmate.log'
default['tmate']['host']         = node['fqdn']
default['tmate']['port']         = 22
default['tmate']['dependencies'] = %w{git-core
    build-essential
    pkg-config
    libtool
    libevent-dev
    libncurses-dev
    zlib1g-dev
    automake
    libssh-dev
    cmake
    ruby}