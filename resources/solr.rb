include ApplicationCookbook::ResourceBase
require 'pathname'
require 'uri'

attr_accessor :repository
attr_accessor :scm_provider

attribute :solrconfig_xml, kind_of: String
attribute :schema_xml, kind_of: String
attribute :conf_dir, kind_of: String
attribute :name, kind_of: String
