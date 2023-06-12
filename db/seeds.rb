require "json"
require "open-uri"
require 'faker'


puts "Destroying favorites"
Favorite.destroy_all
puts "Destroying grocery list"
GroceryList.destroy_all
puts "Destroying ingredients"
Ingredient.destroy_all
puts "Destroying mealdays"
MealDay.destroy_all
puts "Destroying grocery"
Grocery.destroy_all
puts "Destroying recipes"
Recipe.destroy_all
puts "Destroying Users"
User.destroy_all

names = [
  "quentin",
  "gab",
  "thomas",
]

puts "creatings users..."
names.each do |name|
  User.create!(
    first_name: name,
    last_name: Faker::Name.last_name,
    username: "#{name.reverse}",
    email: "#{name}@test.com",
    password: "qwerty",
    password_confirmation: "qwerty"
  )
  puts "|"
end

puts "done with users!"

puts "Creating empty grocery to initialize mealdays"
Grocery.create(user: User.first)

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

puts "let's populate the recipes and ingredients !"

cuisine_types.each do |type|
  url = "https://api.edamam.com/api/recipes/v2?type=public&app_id=#{ENV.fetch("EDAMAN_APP_ID")}&app_key=#{ENV.fetch("EDAMAN_APP_KEY")}&cuisineType=#{type}&mealType=Dinner"
  file = URI.open(url).read
  data = JSON.parse(file)
  puts "starting with #{type} recipes"

  data["hits"].each do |hit|
    photo = URI.open(hit["recipe"]["image"])
    recipe = Recipe.new(
      name: hit["recipe"]["label"],
      description: hit["recipe"]["ingredientLines"].join("\n"),
      prep_time: hit["recipe"]["totalTime"].to_i > 0 ? hit["recipe"]["totalTime"].to_i : [15, 30, 45, 60].sample,
      rating: (1..5).to_a.sample,
      servings: hit["recipe"]["yield"].to_i,
      category: type
    )
    recipe.photo.attach(io: photo, filename: "#{recipe.name.split().join("_")}.png", content_type: "image/png")
    recipe.save!
    puts "creating ingredients for #{recipe.name}"
    hit["recipe"]["ingredients"].each do |ingredient|
      Ingredient.create!(
        name: ingredient["food"],
        quantity: ingredient["weight"],
        unit: "grams",
        recipe_id: recipe.id,
        category: ingredient["foodCategory"]
      )
    end
  end
end

puts "creating random favorites"
recipes_ids = Recipe.all.map { |recipe| recipe.id }
User.all.each do |user|
  16.times do
    Favorite.create!(user_id: user.id, recipe_id: recipes_ids.shuffle.pop)
  end
end

puts "done!"
