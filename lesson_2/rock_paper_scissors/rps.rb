require 'pry'

VALID_CHOICES = %w(rock paper scissors lizard Spock)
WINNING_MATCHUPS = { rock: %w(scissors lizard),
                     paper: %w(rock Spock),
                     scissors: %w(paper lizard),
                     lizard: %w(spock paper),
                     Spock: %w(rock scissors) }
ABBREVIATIONS = { r: 'rock',
                  p: 'paper',
                  s: 'scissors',
                  l: 'lizard',
                  S: 'Spock' }

def prompt(message)
  puts("=> #{message}")
end

def win?(first, second)
  WINNING_MATCHUPS[first.to_sym].include?(second)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt('You won!')
  elsif win?(computer, player)
    prompt('Computer won!')
  else
    prompt("It's a tie!")
  end
end

loop do # main loop
  player_score = 0
  computer_score = 0

  loop do # round loop
    choice = ''
    loop do # validation loop
      shortcuts = ABBREVIATIONS.keys.join(' ')
      prompt("Choose one: #{VALID_CHOICES.join(', ')} (#{shortcuts})")
      choice = gets.chomp

      abbreviated = ABBREVIATIONS.keys.include?(choice.to_sym)
      choice = ABBREVIATIONS[choice.to_sym] if abbreviated

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    display_results(choice, computer_choice)
    player_score += 1 if win?(choice, computer_choice)
    computer_score += 1 if win?(computer_choice, choice)
    if player_score == 3
      prompt("Round over. Player victory! (#{player_score}-#{computer_score})")
      break
    elsif computer_score == 3
      final_score = "#{player_score}-#{computer_score}"
      prompt("Round over. Computer victory! (#{final_score})")
      break
    end
  end

  prompt('Do you want to play again?')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thank you for playing. Good bye!')
