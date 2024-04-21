entities_path = '../../lib/entities'

initializers = Dir["#{File.dirname(__FILE__)}/#{entities_path}/*.rb"]

initializers.each do |initialize|
  require initialize
end
