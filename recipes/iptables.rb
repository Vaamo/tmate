#
# Cookbook Name:: vaamo_tmate
# Recipe:: tmate
#
# Copyright (C) 2015 Vaamo Finanz AG
#
# All rights reserved - Do Not Redistribute
#

# Add tmate-slave port to iptables
iptables_ng_rule 'tmate-slave' do
      rule "--protocol tcp --dport #{node['tmate']['port']} --match state --state NEW --jump ACCEPT"
end
