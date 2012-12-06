#
# Cookbook Name:: mongodb
# Recipe:: configserver
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
  supports :status => true, :restart => true
  action [:disable, :stop]
end

#only for custom init script
#node['mongodb']['initport'] = node['mongodb']['configserver']['port']

mongodb_instance "configserver" do
  mongodb_type "configserver"
  port         node['mongodb']['configserver']['port']
  logpath      node['mongodb']['configserver']['logpath']
  dbpath       node['mongodb']['configserver']['dbpath']
 enable_rest  node['mongodb']['enable_rest']
end
