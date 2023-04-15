WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(board)
  system 'clear'
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ''
  puts '     |     |'
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts '     |     |'
  puts '-----|-----|-----'
  puts '     |     |'
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts '     |     |'
  puts '-----|-----|-----'
  puts '     |     |'
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts '     |     |'
  puts ''
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def place_piece!(board, player)
  if player == :player
    player_places_piece!(board)
  else
    computer_places_piece!(board)
  end
end

def player_places_piece!(board)
  square = ''
  loop do
    prompt("Choose a square (#{joinor(empty_squares(board))}):")
    square = gets.chomp.to_i
    break if empty_squares(board).include?(square)
    prompt("Sorry, that's not a valid choice.")
  end

  board[square] = PLAYER_MARKER
end

def joinor(arr, seperator=', ', word='or')
  return arr[0].to_s if arr.size == 1
  return "#{arr[0]} #{word} #{arr[1]}" if arr.size == 2
  arr[0...-1].join(seperator) + seperator + word + ' ' + arr[-1].to_s
end

def computer_places_piece!(board)
  square = find_winning_move(board, COMPUTER_MARKER)
  square ||= find_winning_move(board, PLAYER_MARKER)
  square ||= 5 if board[5] == INITIAL_MARKER
  square ||= empty_squares(board).sample
  board[square] = COMPUTER_MARKER
end

def find_winning_move(board, marker)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(marker) == 2
      winning_move = empty_squares(board).intersection(line)[0]
      return winning_move if winning_move
    end
  end
  nil
end

def board_full?(board)
  empty_squares(board).empty?
end

def someone_won?(board)
  !!detect_winner(board)
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif board.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def alternate_player(player)
  player == :player ? :computer : :player
end

def ask_first_player
  prompt('Who should play first? p for player, c for computer, r for random')
  loop do
    response = gets.chomp.downcase[0]
    case response
    when 'p' then return :player
    when 'c' then return :computer
    when 'r' then return [:player, :computer].sample
    end
    prompt('Invalid input. Please enter p, c, or r')
  end
end

loop do
  score = { 'Player' => 0, 'Computer' => 0 }
  until score['Player'] == 5 || score['Computer'] == 5

    board = initialize_board
    current_player = ask_first_player
    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      winner = detect_winner(board)
      score[winner] += 1
      prompt("#{winner} won! The score is Player: #{
        score['Player']}, Computer: #{score['Computer']}")
    else
      prompt("It's a tie! The score is #{score['Player']}-#{
        score['Computer']}")
    end

  end

  prompt("The final score is #{score['Player']}-#{score['Computer']}. #{
    winner} victory!")
  prompt('Play again? (y or n)')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thanks for playing Tic-Tac-Toe! Goodbye!')
