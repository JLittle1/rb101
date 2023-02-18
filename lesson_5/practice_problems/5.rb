munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

total = munsters.values.inject(0) do |sum, munster|
  if munster['gender'] == 'male'
    sum + munster['age']
  else
    sum
  end
end

p total
