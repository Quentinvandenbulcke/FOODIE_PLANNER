
require "json"
require "open-uri"

app_id = "2df0c1e7"
app_key = "d8f7fc5422fbb9639eab44868599c0a6"

cuisine_types = [
  "Mexican",
  "Asian",
  "British",
  "Caribbean",
  "Chinese",
  "Indian",
  "Italian",
  "Nordic",
  "Mediterranean"
]

puts "let's populate the databases !"

cuisine_types.each do |type|
  url = "https://api.edamam.com/api/recipes/v2?type=public&app_id=#{app_id}&app_key=#{app_key}&cuisineType=#{type}"
  file = URI.open(url).read
  data = JSON.parse(file)

  data["hits"].each do |hit|
    recipe = Recipe.new(
      name: hit["recipe"]["label"],
      description: hit["recipe"]["ingredientLines"].join("\n"),
      prep_time: hit["recipe"]["totalTime"].to_i,
      rating: (1..5).to_a.sample,
      servings: hit["recipe"]["yield"].to_i,
      category: type
    ).save!
    hit["recipe"]["ingredients"].each do |ingredient|
      Ingredient.new(
        name: ingredient["food"],
        quantity: ingredient["quantity"],
        unit: ingredient["measure"],
        recipe_id: recipe.id
      ).save!
    end
  end
end
