#
# Cookbook Name:: mongodb
# Recipe:: mongos
#
# Copyright 2011, edelight GmbH
# Authors:
#       Markus Korn <markus.korn@edelight.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "mongodb"

service "mongodb" do
  action [:disable, :stop]
end

configsrv = search(
  :node,
  "mongodb_cluster_name:#{node['mongodb']['cluster_name']} AND \
   recipes:mongodb\\:\\:configserver AND \
   chef_environment:#{node.chef_environment}"
)

#S.D. 2012 this is breaking a new install
#if configsrv.length != 1 and configsrv.length != 3
#  Chef::Log.error("Found #{configsrv.length} configserver, need either one or three of them")
#  raise "Wrong number of configserver nodes"
#end

if configsrv.length != 1 and configsrv.length != 3
  Chef::Log.warning("Found #{configsrv.length} configserver, need either one or three of them.  Perhaps just run recipes one more time, if the config servers haven't been added yet.")
end

#only for custom init script
#node['mongodb']['initport'] = node['mongodb']['mongos']['port']

mongodb_instance "mongos" do
  mongodb_type "mongos"
  port         node['mongodb']['mongos']['port']
  logpath      node['mongodb']['mongos']['logpath']
  dbpath       node['mongodb']['mongos']['dbpath']
  configserver configsrv
  enable_rest  node['mongodb']['enable_rest']
end
