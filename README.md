# application_solr

Provides a `solr` sub-resource for use with the `application` cookbook,
especially the `application_java` cookbook, as well as a definition to avoid
having to even know about that. Besides that, there's a recipe that makes solr
cores using node attributes.

## Usage

Choose your own adventure

## Recipe

Simply include the default recipe and if you want to call the core
'my_collection' configure attributes like so:

```
node['application_solr']['cores']['my_collection'] = {
  'solrconfig_xml' => 'http://example.com/dist/path/to/solrconfig.xml',
  'schema_xml' => 'http://example.com/dist/path/to/schema.xml',
  'conf_dir' => 'http://example.com/dist/path/to/conf.tar.gz'
}
```

## Definition

The recipe just passes off straight to the definition, so if you want a core:

```
solr_core 'my_collection' do
  solrconfig_xml 'http://example.com/dist/path/to/solrconfig.xml'
  schema_xml 'http://example.com/dist/path/to/schema.xml'
  conf_dir 'http://example.com/dist/path/to/conf.tar.gz'
end
```

## Application Sub-Resource

Just read the definition and of course the provider for the resource it
configures, and of course the documentation for the application and
application_java cookbooks. That will make more sense than an interpretation of
that material here.
