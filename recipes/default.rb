#
# Cookbook Name:: mongodb
# Recipe:: default
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

package node[:mongodb][:package_name] do
  action :install
end

needs_mongo_gem = (node.recipes.include?("mongodb::replicaset") or node.recipes.include?("mongodb::mongos"))

if needs_mongo_gem
  # install the mongo ruby gem at compile time to make it globally available
  gem_package 'mongo' do
    action :nothing
  end.run_action(:install)
  Gem.clear_paths
end

if node.recipes.include?("mongodb::default") or node.recipes.include?("mongodb")
  # configure default instance

  mongodb_instance "mongodb" do
    mongodb_type "mongod"
    port         node['mongodb']['mongod']['port']
    logpath      node['mongodb']['mongod']['logpath']
    dbpath       node['mongodb']['mongod']['dbpath']
 enable_rest  node['mongodb']['enable_rest']
  end
end

if node.recipes.include?("mongodb::default")
  set['mongodb']['port'] = node['mongodb']['mongod']['port']
  #only for custom init script
  #set['mongodb']['initport'] = node['mongodb']['mongod']['port']
end

