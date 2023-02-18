arr = [[2], [3, 5, 7, 12], [9], [11, 13, 15]]

result = arr.map do |sub_arr|
  sub_arr.select { |num| num % 3 == 0 }
end

p result