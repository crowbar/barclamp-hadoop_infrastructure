#
# Cookbook Name: hadoop_infrastructure
# Recipe: cm-namenode.rb
#
# Copyright (c) 2011 Dell Inc.
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

#######################################################################
# Begin recipe
#######################################################################
debug = node[:hadoop_infrastructure][:debug]
Chef::Log.info("HI - BEGIN hadoop_infrastructure:cm-namenode") if debug

# Configuration filter for the crowbar environment.
env_filter = " AND environment:#{node[:hadoop_infrastructure][:config][:environment]}"

# Look for the ha filer node role definition.
ha_filer_active = false
search(:node, "roles:hadoop_infrastructure-ha-filernode#{env_filter}") do |n|
  if n[:fqdn] and not n[:fqdn].empty?
    ha_filer_active = true
    break;
  end
end

# Make the HA file system mount if HA filer active. 
if ha_filer_active
  include_recipe 'hadoop_infrastructure::cm-ha-filer-mount'
end

#######################################################################
# End recipe
#######################################################################
Chef::Log.info("HI - END hadoop_infrastructure:cm-namenode") if debug
