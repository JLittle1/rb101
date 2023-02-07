require 'yaml'
require 'pry'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'en'

def prompt(message)
  puts "=> #{MESSAGES[LANGUAGE][message]}"
end

def valid_number?(num)
  num.to_i.to_s == num || num.to_f.to_s == num
end

def operation_to_message(operation)
  case operation
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt('welcome')

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt('invalid_name')
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  number1 = ''
  loop do
    prompt('first_number')
    number1 = gets.chomp

    if valid_number?(number1)
      break
    else
      prompt('invalid_number')
    end
  end

  number2 = ''
  loop do
    prompt('second_number')
    number2 = gets.chomp

    if valid_number?(number2)
      break
    else
      prompt('invalid_number')
    end
  end

  prompt('operation_ask')

  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('invalid_operator')
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when '1'
             number1.to_i + number2.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
           end

  prompt("The result is #{result}")
  prompt('ask_another')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
