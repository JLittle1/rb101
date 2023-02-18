arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]

result = arr.sort_by do |sub_arr|
  sub_arr.select { |num| num.odd? }
end

p result