arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

result = arr.map do |hsh|
  hsh = hsh.dup
  hsh.keys.each {|key| hsh[key] += 1}
  hsh
end

p arr
p result