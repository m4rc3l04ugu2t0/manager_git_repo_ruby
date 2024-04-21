# frozen_string_literal: true

require_relative '../config/load_initializers'

class App
  attr_accessor :keep_going

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
      $stdout.clear_screen
      @menu.display_menu
      puts 'Opção Selecionada!' if keep_going?
    end
  end

  def keep_going?
    @user_option = gets.chomp.to_i
    @keep_going = false if @menu.options[@user_option] == :exit
    keep_going
  end
end

App.call
