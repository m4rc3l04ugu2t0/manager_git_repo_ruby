# frozen_string_literal: true

# Classe base para representar registros genéricos
class Record
  # Método para converter os atributos de uma instância em um hash
  def to_h
    # Inicializa um hash vazio para armazenar os atributos
    object = {}

    # Itera sobre todas as variáveis de instância da instância atual
    instance_variables.each do |variable|
      # Remove o caractere '@' do nome da variável e converte para símbolo
      # Exemplo: '@name' se torna :name
      key = variable.to_s.delete('@').to_sym

      # Adiciona a variável de instância e seu valor ao hash
      # Exemplo: { :name => "valor", :age => 30, ... }
      object[key] = instance_variable_get(variable)
    end

    # Retorna o hash com os atributos
    object
  end

  def save
    delete url

    @created_at ||= fetch_current_date_time

    @created_at = fetch_current_date_time

    mode = 'a+'
    write_headers = false

    data = to_h # {owner:, url:, created_at:, :updated_at}
    CSV.open base_path, mode, write_headers:, headers: data.keys do |csv|
      csv << data.values
    end
  end

  def delete(url)
    Record.destroy url, base_path.to_s
  end

  def self.delete(url)
    Record.destroy url, new.base_path.to_s
  end

  def self.destroy(url, path)
    table = CSV.table path

    table.delete_if do |row|
      row[:url] == url
    end

    File.open path, 'w' do |file|
      file.write table.to_csv
    end
  end

  def fetch_current_date_time
    DateTime.parse(DateTime.now.strftime('%FT%T%:z')).strftime('%d/%m/%y - %H:%M:% %P')
  end

  # Método de classe para recuperar todos os registros de uma fonte de dados
  def self.all
    # Lê os dados da fonte de dados (por exemplo, um arquivo CSV)
    table = CSV.read(new.base_path.to_s, headers: true)

    # Mapeia cada linha da tabela para um objeto Record
    table.map do |item|
      # Converte a linha em um hash e transforma as chaves em símbolos
      data = item.to_h.transform_keys(&:to_sym)

      # Cria uma nova instância de Record com os dados do hash
      new(**data)
    end
  end
end
