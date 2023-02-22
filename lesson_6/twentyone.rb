DECK = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'] * 4

def prompt(msg)
  puts "=> #{msg}"
end

def points(card)
  case card
  when 2..10 then card
  when 'Ace' then 11
  else 10
  end
end

def calculate_score(hand)
  score = hand.inject(0) { |total, card| total + points(card) }
  if score > 21
    hand.count('Ace').times do
      score -= 10
      break if score <= 21
    end
  end
  score
end

def dealer_turn!(deck, hand)
  score = calculate_score(hand)
  prompt("Dealer's hand: #{hand.inspect}")
  while score < 17
    hand.push(deck.pop)
    score = calculate_score(hand)
    prompt('Dealer hits!')
    prompt("Dealer's hand: #{hand.inspect}")
  end
end

def busted?(hand)
  calculate_score(hand) > 21
end

def player_won?(player, dealer)
  player_score = calculate_score(player)
  dealer_score = calculate_score(dealer)
  return true if dealer_score > 21 || player_score > dealer_score
  return false if player_score > 21 || player_score < dealer_score
  # Returns nil in event of a tie
end

def display_results(player, dealer, winner)
  prompt('Dealer busted!') if busted?(dealer)
  prompt("Player Score: #{calculate_score(player)}")
  p player
  prompt("Dealer Score: #{calculate_score(dealer)}")
  p dealer
  if winner
    prompt('Congratulations! You won!')
  elsif winner.nil?
    prompt("It's a tie!")
  else
    prompt('Dealer wins.')
  end
end

def play_again?
  prompt('Would you like to play again?')
  answer = gets.chomp.downcase
  answer.start_with?('y')
end

loop do
  deck = DECK.shuffle
  player_hand = deck.pop(2)
  dealer_hand = deck.pop(2)
  prompt("Dealer's revealed card: #{dealer_hand[0].inspect}")

  prompt("Your hand: #{player_hand.inspect}")
  prompt("Your total: #{calculate_score(player_hand)}")
  answer = nil
  loop do
    prompt('Hit or stay?')
    answer = gets.chomp
    break if answer == 'stay'
    prompt('You hit!')
    player_hand.push(deck.pop)
    prompt("Your hand: #{player_hand.inspect}")
    prompt("Your total: #{calculate_score(player_hand)}")
    break if busted?(player_hand)
  end
  if busted?(player_hand)
    prompt('You busted! Dealer wins.')
    play_again? ? next : break
  end
  prompt('You chose to stay!')

  prompt('Dealer turn...')
  dealer_turn!(deck, dealer_hand)
  winner = player_won?(player_hand, dealer_hand)
  display_results(player_hand, dealer_hand, winner)
  break unless play_again?
end
