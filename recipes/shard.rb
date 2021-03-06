#
# Cookbook Name:: mongodb
# Recipe:: shard
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

include_recipe "mongodb::default"

# disable and stop the default mongodb instance
service "mongodb" do
  supports :status => true, :restart => true
  action [:disable, :stop]
end

is_replicated = node.recipes.include?("mongodb::replicaset")

#set['mongodb']['port'] = node[:mongodb][:shard][:port]
node['mongodb']['port'] = node['mongodb']['shard']['port']

mongodb_instance "shard" do
  mongodb_type "shard"
  port         node['mongodb']['shard']['port']
  logpath      node['mongodb']['shard']['logpath']
  dbpath       node['mongodb']['shard']['dbpath']
 enable_rest node['mongodb']['enable_rest']
  if is_replicated
    replicaset    node
  end
end

