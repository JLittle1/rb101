munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, value|
  if value['age'] < 18
    value['age_group'] = 'kid'
  elsif value['age'] < 65
    value['age_group'] = 'adult'
  else
    value['age_group'] = 'senior'
  end
end

p munsters