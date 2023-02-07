def prompt(message)
  puts '=> ' + message
end

def valid_number?(number)
  number.to_f.to_s.include?(number)
end

def valid_percentage?(input)
  /\d/.match(input) && /^\d*\.?\d*%?$/.match(input)
end

def valid_time?(input)
  /\d/.match(input) && /^\d*y?\d*m?$/.match(input) &&
    time_to_months(input) > 0
end

def time_to_months(duration)
  duration = duration.split('y')
  months = 0
  if duration[-1].include?('m')
    months += duration[-1].to_i + (duration.fetch(-2, 0).to_i * 12)
  else
    months += duration[-1].to_i * 12
  end
  months
end

def convert_to_currency(float)
  parts = float.round(2).to_s.split('.')
  parts[1] = parts[1] + '0' if parts[1].length == 1
  '$' + parts.join('.')
end

def get_loan_amount
  loan_amount = ''
  loop do
    prompt("How much did you loan?")
    loan_amount = gets.chomp.delete('$,')
    break if valid_number?(loan_amount)

    prompt("Please enter a number.")
  end
  loan_amount = loan_amount.to_f
end

def get_apr
  apr = ''
  loop do
    prompt("What's your APR as a percenage? Examples: 4.2%, 5%, 1.8")
    apr = gets.chomp
    break if valid_percentage?(apr)

    prompt("Please enter a number.")
  end
  apr = apr.delete('%').to_f / 100
end

def get_loan_duration
  loan_duration = ''
  loop do
    prompt("What's the loan duration? Examples: 3y2m, 2y, 18m")
    loan_duration = gets.chomp.downcase
    break if valid_time?(loan_duration)

    prompt("Please enter a non-zero time duration in format XyXm")
  end
  loan_duration = time_to_months(loan_duration)
end

def display_calculations(interest, duration, payment, total)
  # Following three lines round and prepare for printing
  payment = convert_to_currency(payment)
  total = convert_to_currency(total)
  interest = (interest * 100).round(2)

  puts
  prompt("With a monthly interest rate of #{interest}\% and a loan duration \
of #{duration} months:")
  prompt("Your monthly payment is #{payment}")
  prompt("Your total payment is #{total}")
  puts
  prompt("Would you like to calculate another loan? (y/n)")
end

def repeat_or_exit
  loop do
    reply = gets.chomp.downcase
    unless reply.empty?
      break if reply[0] == 'y'

      if reply[0] == 'n'
        prompt("Goodbye")
        exit
      end
    end
    prompt("I didn't get that. Please enter y or n:")
  end
end

# Main Program

prompt('Welcome. Calculate your monthly interest.')

loop do
  loan_amount = get_loan_amount
  apr = get_apr
  loan_duration = get_loan_duration

  monthly_interest = apr / 12
  monthly_payment = loan_amount * (monthly_interest /
    (1 - (1 + monthly_interest)**-loan_duration))
  total = monthly_payment * loan_duration

  display_calculations(monthly_interest, loan_duration, monthly_payment, total)
  repeat_or_exit
end
