# puts "let's populate the recipe database !"
# puts "."
# puts "1"
# puts "."
# puts "2"
# puts "."
# puts "3"
# puts "."
# puts "let's gooo"

require "json"
require "open-uri"

app_id = "2df0c1e7"
app_key = "d8f7fc5422fbb9639eab44868599c0a6"


#https://api.edamam.com/api/recipes/v2?type=public&q=pasta&app_id=2df0c1e7&app_key=d8f7fc5422fbb9639eab44868599c0a6


url = "https://api.edamam.com/api/recipes/v2?type=public&q=pasta&app_id=2df0c1e7&app_key=d8f7fc5422fbb9639eab44868599c0a6"
#url = "https://api.edamam.com/api/recipes/v2/?&app_id=#{app_id}&app_key=#{app_key}"
file = URI.open(url).read
data = JSON.parse(file)

puts "#{data}"
