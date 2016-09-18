require 'securerandom'

class RosettaCode24
  attr_accessor :numbers
  def initialize
    @numbers = []
    get_random_numbers
  end

  def run
    print_prompt
    get_user_input
    verify_equation_uses_each_number
    calculate_total
    print_total
    print_result
  end

  private
  attr_reader :equation, :total
  def get_random_numbers
    4.times do
      numbers << SecureRandom.random_number(8) + 1
    end
  end

  def print_prompt
    prompt = "Please enter an equation that equals 24 using the following numbers:"
    $stdout.puts prompt
    $stdout.puts "\t" + numbers.join(', ')
  end

  def get_user_input
    @equation = $stdin.gets.chomp
  end

  def print_total
    $stdout.puts "Total: " + total.to_s
  end

  def calculate_total
    @total = eval(equation)
  end

  def print_result
    if total == 24
      $stdout.puts 'WINNER'
    else
      $stdout.puts 'LOSER'
    end
  end

  def verify_equation_uses_each_number
    user_numbers = equation.scan(/\d+/).map(&:to_i).sort
    unless user_numbers == numbers.sort
      $stderr.puts "Error: Invalid equation, you must use each number once."
    end
  end
end
