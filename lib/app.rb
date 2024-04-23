# frozen_string_literal: true

require_relative '../config/load_initializers'

# class principal de inicio no app, onde chamara a principais funções de inicio
class App
  attr_accessor :keep_going

  # self se refere a propria class, quando chama "App.call", ele criara uma nova
  # instancia da class usando o metodo "new", seria como chama "App.new"
  def self.call
    new
  end

  def initialize
    @keep_going = true
    @menu = Menu.new
    run
  end

  private

  def run
    while keep_going
      # $stdout.clear_screen
      @menu.display_menu
      trigger_option if keep_going?
    end
  end

  def keep_going?
    @user_option = gets.chomp.to_i
    @keep_going = false if @menu.options[@user_option] == :exit
    keep_going
  end

  def trigger_option
    # $stdout.clear_screen
    call_method_from_class
  end

  def call_method_from_class
    # transforma em uma string e separa ela por "_",
    # assim tranformando em um array, ex: "gatinho_fofo".split '_' -> ["gatinho", "fofo"].last -> "fofo"
    class_name = @menu.options[@user_option].to_s.split('_').last

    # o mesmo da linha de cima, so que pegando o primeiro elemento do array
    class_action = @menu.options[@user_option].to_s.split('_').first

    # chama a função responsavel por trata a string que vai ser o nome da class, de forma
    # adequada, para que corresponda ao padrão
    class_name = format_class_name class_name

    # retorna a class cujo o nome for especificado
    class_constant = Object.const_get class_name

    # Então, class_constant.send(class_action) está chamando o método na
    # classe representada por class_constant, onde o nome do método é
    # especificado pela string class_action.
    class_constant.send class_action
  end

  def format_class_name(class_name)
    # caso tenha um 's' no fim, ele sera removido e depois os resto da string sera convertida
    # para letras caixa alta
    if class_name.chars.last == 's'
      class_name.slice(0, class_name.length - 1).capitalize
    else
      class_name.capitalize
    end
  end
end

App.call
