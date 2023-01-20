def multiply(numbers, multiplier)
  counter = 0
  multiplied = []
  loop do
    break if counter == numbers.size
    multiplied << numbers[counter] * multiplier
    counter += 1
  end
  multiplied
end

p multiply([1, 2, 3], 4)