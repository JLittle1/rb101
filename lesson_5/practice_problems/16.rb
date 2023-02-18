def create_uuid
  digits = '1234567890abcdef'.chars
  uuid = [8, 4, 4, 4, 12]
  uuid.map! { |num| digits.sample(num).join }
  uuid.join('-')
end

p create_uuid