class Repo < Record
  attr_accessor :owner, :url, :created_at, :updated_at

  def initialize **args
    @owner = args[:owner]
    @url = args[:url]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
  end

  def self.list
    puts 'Listando repos...\n\n'
    all.map do |repo|
      puts "#{repo.owner}, #{repo.url}, created at => #{repo.created_at}, updated at => #{repo.updated_at}"
    end
    puts "\nPresione qualquer tecla para continuar."
    gets
  end

  def self.all
    super
  end

  def base_path
    "#{File.dirname(__FILE__)}/../../config/database/repos.csv"

  end
end
