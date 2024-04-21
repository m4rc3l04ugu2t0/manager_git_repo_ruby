class Menu
  attr_reader :options
  def initialize
    @options = {
      0 => :exit,
      1 => :list_repos
    }
  end

  def display_menu
    @options.each do |option|
      puts "#{option.first.to_s.center 5, ' '} -> #{option.last}"
    end
  end
end
