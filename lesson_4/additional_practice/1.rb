flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

result = {}
flintstones.each_with_index { |flintstone, idx| result[flintstone] = idx }
p result