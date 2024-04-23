# frozen_string_literal: true

# Classe para representar registros de repositórios, herda da classe Record
class Repo < Record
  # Atributos de instância
  attr_accessor :owner, :url, :created_at, :updated_at

  @@repos = []

  # Método de inicialização da classe
  def initialize(**args)
    # Define os atributos usando os argumentos passados
    @owner = args[:owner]
    @url = args[:url]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
  end

  # Método de classe para listar todos os repositórios
  def self.list
    # Imprime uma mensagem de cabeçalho
    puts "Listando repos...\n\n"

    # Chama o método all para obter todos os registros e itera sobre eles
    all.map do |repo|
      # Imprime os detalhes de cada repositório
      puts "#{repo.owner}, #{repo.url}, created at => #{repo.created_at}, updated at => #{repo.updated_at}"
    end

    # Imprime uma mensagem de conclusão e aguarda qualquer entrada do usuário
    puts "\nPresione qualquer tecla para continuar."
    gets
  end

  # Método de classe para recuperar todos os registros de repositórios
  def self.all
    # Chama o método all da classe pai (Record) para ler os registros de um arquivo CSV
    super
  end

  # Método para obter o caminho do arquivo CSV que contém os dados dos repositórios
  def base_path
    # Retorna o caminho do arquivo CSV
    "#{File.dirname(__FILE__)}/../../config/database/repos.csv"
  end

  def save
    repo = @@repos.select do |repo|
      repo.url == url
    end
    @created_at = repo.first.created_at if repo.any?

    super

    @@repos.delete_if do |repo|
      repo.url == url
    end

    @@repos << self
  end

  def self.load_repos
    @@repos = all
  end

  def self.add
    puts 'Criando novo repo'
    puts "\nEntre com o nome do repositório"
    owner = gets.chomp
    puts "\nEntre com a url do repositório"
    url = gets.chomp

    new(owner:, url:).save
    sleep 2
  end

  def self.delete
    puts 'Apagar repo'
    puts "\nEntre com a url do repositório"
    url = gets.chomp

    @@repos.delete_if do |repo|
      repo.url == url
    end
    super url
    sleep 2
  end

  def self.fetch
    FetchRepos.call @@repos
  end
end
