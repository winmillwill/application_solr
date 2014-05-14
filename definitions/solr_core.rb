define :solr_core, conf_dir: nil, schema_xml: nil, solrconfig_xml: nil do
  base = Pathname.new(URI.parse(node['application_solr']['url']).path).basename.to_s
  %w( tgz gz bz zip tar ).each do |suffix|
    base = Pathname.new(base).basename(suffix).to_s
  end
  repo = ::File.join(node['application_solr']['lib_dir'], 'solr', 'dist', "#{base}war")
  application 'solr' do
    path node["application_solr"]["path"]
    owner node["tomcat"]["user"]
    group node["tomcat"]["group"]
    repository repo
    scm_provider Chef::Provider::File::Deploy
    java_webapp do
      context_template "tomcat.xml.erb"
    end
    solr do
      name params[:name]
      schema_xml params[:schema_xml]
      conf_dir params[:conf_dir]
      solrconfig_xml params[:solrconfig_xml]
    end
    tomcat
  end
end
