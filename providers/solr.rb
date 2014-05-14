action :before_compile do
end

action :before_deploy do

  download

  create_hierarchy

  create_schema_file

  create_solr_file

  create_solrconfig_file

end

action :before_migrate do
end

action :before_symlink do
end

action :before_restart do
end

action :after_restart do
end

def download
  ark 'solr' do
    url node['application_solr']['url']
    path node['application_solr']['lib_dir']
    action :put
  end

  %w{
    slf4j-jdk14-1.6.6.jar
    log4j-over-slf4j-1.6.6.jar
    slf4j-api-1.6.6.jar
    jcl-over-slf4j-1.6.6.jar
  }.each do |file|
    ark file do
      url "http://www.slf4j.org/dist/slf4j-1.6.6.tar.gz"
      action :cherry_pick
      creates ::File.join("slf4j-1.6.6", file)
      path ::File.join(node["tomcat"]["home"],"lib")
    end
  end
end

def create_hierarchy
  core_dir = "#{new_resource.path}/shared/solr_home/#{new_resource.name}"
  directory core_dir do
    owner new_resource.owner
    group new_resource.group
    mode '0755'
    recursive true
  end
  if new_resource.conf_dir.nil?
    ruby_block 'copy_default_solr_config' do
      block do
        default_conf = ::File.join(node['application_solr']['lib_dir'], 'solr', 'example', 'solr')
        FileUtils.cp_r("#{default_conf}/conf", core_dir)
      end
    end
  else
    ark 'solr' do
      url new_resource.conf_dir
      path ::File.join(core_dir, 'conf')
      action :put
    end
  end
end

def create_schema_file
  unless new_resource.schema_xml.nil?
    remote_file "#{new_resource.path}/shared/solr_home/#{new_resource.name}/conf/schema.xml" do
      source new_resource.schema_xml
      owner new_resource.owner
      group new_resource.group
      mode "644"
    end
  end
end

def create_solrconfig_file
  unless new_resource.solrconfig_xml.nil?
    remote_file "#{new_resource.path}/shared/solr_home/#{new_resource.name}/solrconfig.xml" do
      source new_resource.solrconfig_xml
      owner new_resource.owner
      group new_resource.group
      mode "644"
    end
  end
end

def create_solr_file
  template "#{new_resource.path}/shared/solr_home/solr.xml" do
    source "solr.xml.erb"
    owner new_resource.owner
    group new_resource.group
    mode "644"
    variables lazy {
      {
        collections: Array(Pathname.new("#{new_resource.path}/shared/solr_home").children.select { |c| c.directory? }.collect { |p| p.basename })
      }
    }
  end
end
