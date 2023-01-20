statement = "The Flintstones Rock"

frequencies = Hash.new(0)
statement.chars.each { |char| frequencies[char] += 1 }
p frequencies