#
# Cookbook Name:: test_solr
# Recipe:: default
#
# Copyright (C) 2014 
#

include_recipe 'apt' if platform_family? 'debian'

package 'curl'
