#
# Cookbook Name:: application_solr
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
#

node['application_solr']['cores'].each do |name, core|
  solr_core name do
    solrconfig_xml core.solrconfig_xml unless core['solrconfig_xml'].nil?
    schema_xml core.schema_xml unless core['schema_xml'].nil?
    conf_dir core.conf_dir unless core['conf_dir'].nil?
  end
end
