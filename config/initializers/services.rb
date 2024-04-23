services_path = '../../lib/services'

initializers = Dir["#{File.dirname(__FILE__)}/#{services_path}/*.rb"]

require_relative './gems'
initializers.each do |initialize|
  require initialize
end
