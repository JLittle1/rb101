def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    # number % divisor checks if the number is cleanly divisible by divisor
    divisor -= 1
  end
  factors # Provides the return value
end