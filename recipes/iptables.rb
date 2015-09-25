#
# Cookbook Name:: tmate
# Recipe:: tmate
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

# Add tmate-slave port to iptables
iptables_ng_rule '50-tmate-slave' do
  rule "--protocol tcp --dport #{node['tmate']['port']} --match state --state NEW --jump ACCEPT"
end
