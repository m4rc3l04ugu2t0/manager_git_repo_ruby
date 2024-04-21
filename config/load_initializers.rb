initializers = Dir["#{File.dirname(__FILE__)}/initializers/*.rb"]
initializers.each do |initialize|
  require initialize
end
