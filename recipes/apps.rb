#
# Cookbook Name:: rundeck
# Recipe:: apps
#
# Copyright (C) 2015 Leonard TAVAE
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.set['java']['install_flavor'] = 'openjdk'
node.set['java']['jdk_version'] = '7'

include_recipe 'java::default'

remote_file '/usr/local/src/rundeck.deb' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'http://download.rundeck.org/deb/rundeck-' + node['rundeck']['version'] + '-GA.deb'
  not_if { ::File.exist?('/usr/local/src/rundeck.deb') }
end

bash 'Install rundeck' do
  user 'root'
  cwd '/usr/local/src'
  code <<-EOH
  dpkg -i rundeck.deb
  EOH
  not_if { ::File.exist?('/etc/rundeck') }
end

service 'rundeckd' do
  supports status: true, restart: true, reload: true
  action [:start, :enable]
end

template '/etc/rundeck/framework.properties' do
  source 'framework.properties.erb'
  owner 'rundeck'
  group 'rundeck'
  mode '0640'
  notifies :restart, 'service[rundeckd]'
end

template '/etc/rundeck/rundeck-config.properties' do
  source 'rundeck-config.properties.erb'
  owner 'rundeck'
  group 'rundeck'
  mode '0640'
  notifies :restart, 'service[rundeckd]'
end
