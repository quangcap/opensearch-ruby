# require './lib/api_generator'
# require 'openapi_parser'
# generator = ApiGenerator.new('./opensearch-openapi.yaml')
# generator.generate_spec_methods
# document = Openapi3Parser.load(File.open('./opensearch-openapi.yaml'))
# root = OpenAPIParser.parse(YAML.load_file('./opensearch-openapi.yaml'))
# puts root.components.to_a
# puts document.valid?
# puts '--'
# puts document.errors.to_h
require 'open-uri'
require 'openapi3_parser'

openapi_url = "https://github.com/opensearch-project/opensearch-api-specification/releases/download/main-latest/opensearch-openapi.yaml"
openapi_path = "opensearch-openapi.yaml"
File.write(openapi_path, URI.open(openapi_url).read) unless File.exists?(openapi_path)
puts "Loading #{openapi_path} (#{File.size(openapi_path)} byte(s)) ..."

doc = Openapi3Parser.load_file(openapi_path)
puts "Loaded #{openapi_url} with #{doc.paths.size} path(s)."
puts "Spec is valid: " + doc.valid?.to_s

puts "Errors:"
doc.errors.to_h.each do |key, val|
  puts "#{key} HAS ERROR: #{val}"
end

# doc.paths.keys.each do |key|
#   puts key
# end

puts "Done."
