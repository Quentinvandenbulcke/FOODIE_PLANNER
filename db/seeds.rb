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
  "pedro",
  "cassandra",
  "ali",
  "alejandro",
  "gaby",
  "charlotte",
  "dioulde",
  "matt"
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
  puts "#{name} added"
  puts "."
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
  url = "https://api.edamam.com/api/recipes/v2?type=public&app_id=#{ENV.fetch("EDAMAN_APP_ID")}&app_key=#{ENV.fetch("EDAMAN_APP_KEY")}&cuisineType=#{type}&dishType=Main%20course"
  file = URI.open(url).read
  data = JSON.parse(file)

  puts "\nstarting with #{type} recipes - pagee 1\n"

  data["hits"].each do |hit|
    photo = URI.open(hit["recipe"]["image"])
    recipe = Recipe.new(
      name: hit["recipe"]["label"],
      description: hit["recipe"]["ingredientLines"].join("\n"),
      prep_time: hit["recipe"]["totalTime"].to_i > 0 ? hit["recipe"]["totalTime"].to_i : [15, 30, 45, 60].sample,
      rating: (1..5).to_a.sample,
      servings: hit["recipe"]["yield"].to_i,
      category: type,
      calories: hit["recipe"]["calories"].to_f.round(1),
      carbon: hit["recipe"]["totalCO2Emissions"],
      fat: hit["recipe"]["totalNutrients"]["FAT"]["quantity"].to_f.round(1),
      protein: hit["recipe"]["totalNutrients"]["PROCNT"]["quantity"].to_f.round(1),
      sugar: hit["recipe"]["totalNutrients"]["SUGAR"]["quantity"].to_f.round(1),
      glucid: hit["recipe"]["totalNutrients"]["CHOCDF.net"]["quantity"].to_f.round(1)
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

  sleep(2)
  puts"...sleeping for 2 sec..."

  url_2 = data["_links"]["next"]["href"]
  file_2 = URI.open(url_2).read
  data_2 = JSON.parse(file_2)

  puts "\nstarting with #{type} recipes - pagee 2\n"

  data_2["hits"].each do |hit|
    photo = URI.open(hit["recipe"]["image"])
    recipe = Recipe.new(
      name: hit["recipe"]["label"],
      description: hit["recipe"]["ingredientLines"].join("\n"),
      prep_time: hit["recipe"]["totalTime"].to_i > 0 ? hit["recipe"]["totalTime"].to_i : [15, 30, 45, 60].sample,
      rating: (1..5).to_a.sample,
      servings: hit["recipe"]["yield"].to_i,
      category: type,
      calories: hit["recipe"]["calories"].to_f.round(1),
      carbon: hit["recipe"]["totalCO2Emissions"],
      fat: hit["recipe"]["totalNutrients"]["FAT"]["quantity"].to_f.round(1),
      protein: hit["recipe"]["totalNutrients"]["PROCNT"]["quantity"].to_f.round(1),
      sugar: hit["recipe"]["totalNutrients"]["SUGAR"]["quantity"].to_f.round(1),
      glucid: hit["recipe"]["totalNutrients"]["CHOCDF.net"]["quantity"].to_f.round(1)
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

  sleep(2)
  puts"...sleeping for 2 sec..."

  url_3 = data_2["_links"]["next"]["href"]
  file_3 = URI.open(url_3).read
  data_3 = JSON.parse(file_3)

  puts "\nstarting with #{type} recipes - pagee 3\n"

  data_3["hits"].each do |hit|
    photo = URI.open(hit["recipe"]["image"])
    recipe = Recipe.new(
      name: hit["recipe"]["label"],
      description: hit["recipe"]["ingredientLines"].join("\n"),
      prep_time: hit["recipe"]["totalTime"].to_i > 0 ? hit["recipe"]["totalTime"].to_i : [15, 30, 45, 60].sample,
      rating: (1..5).to_a.sample,
      servings: hit["recipe"]["yield"].to_i,
      category: type,
      calories: hit["recipe"]["calories"].to_f.round(1),
      carbon: hit["recipe"]["totalCO2Emissions"],
      fat: hit["recipe"]["totalNutrients"]["FAT"]["quantity"].to_f.round(1),
      protein: hit["recipe"]["totalNutrients"]["PROCNT"]["quantity"].to_f.round(1),
      sugar: hit["recipe"]["totalNutrients"]["SUGAR"]["quantity"].to_f.round(1),
      glucid: hit["recipe"]["totalNutrients"]["CHOCDF.net"]["quantity"].to_f.round(1)
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
    sleep(2)
  end

  sleep(2)
  puts"...sleeping for 2 sec..."

  url_4 = data_3["_links"]["next"]["href"]
  file_4 = URI.open(url_4).read
  data_4 = JSON.parse(file_4)

  puts "\nstarting with #{type} recipes - pagee 4\n"

  data_4["hits"].each do |hit|
    photo = URI.open(hit["recipe"]["image"])
    recipe = Recipe.new(
      name: hit["recipe"]["label"],
      description: hit["recipe"]["ingredientLines"].join("\n"),
      prep_time: hit["recipe"]["totalTime"].to_i > 0 ? hit["recipe"]["totalTime"].to_i : [15, 30, 45, 60].sample,
      rating: (1..5).to_a.sample,
      servings: hit["recipe"]["yield"].to_i,
      category: type,
      calories: hit["recipe"]["calories"].to_f.round(1),
      carbon: hit["recipe"]["totalCO2Emissions"],
      fat: hit["recipe"]["totalNutrients"]["FAT"]["quantity"].to_f.round(1),
      protein: hit["recipe"]["totalNutrients"]["PROCNT"]["quantity"].to_f.round(1),
      sugar: hit["recipe"]["totalNutrients"]["SUGAR"]["quantity"].to_f.round(1),
      glucid: hit["recipe"]["totalNutrients"]["CHOCDF.net"]["quantity"].to_f.round(1)
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

  sleep(2)
  puts"...sleeping for 2 sec..."

  url_5 = data_4["_links"]["next"]["href"]
  file_5 = URI.open(url_4).read
  data_5 = JSON.parse(file_5)

  puts "\nstarting with #{type} recipes - pagee 5\n"

  data_5["hits"].each do |hit|
    photo = URI.open(hit["recipe"]["image"])
    recipe = Recipe.new(
      name: hit["recipe"]["label"],
      description: hit["recipe"]["ingredientLines"].join("\n"),
      prep_time: hit["recipe"]["totalTime"].to_i > 0 ? hit["recipe"]["totalTime"].to_i : [15, 30, 45, 60].sample,
      rating: (1..5).to_a.sample,
      servings: hit["recipe"]["yield"].to_i,
      category: type,
      calories: hit["recipe"]["calories"].to_f.round(1),
      carbon: hit["recipe"]["totalCO2Emissions"],
      fat: hit["recipe"]["totalNutrients"]["FAT"]["quantity"].to_f.round(1),
      protein: hit["recipe"]["totalNutrients"]["PROCNT"]["quantity"].to_f.round(1),
      sugar: hit["recipe"]["totalNutrients"]["SUGAR"]["quantity"].to_f.round(1),
      glucid: hit["recipe"]["totalNutrients"]["CHOCDF.net"]["quantity"].to_f.round(1)
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
  20.times do
    Favorite.create!(user_id: user.id, recipe_id: recipes_ids.shuffle.pop)
  end
  puts "creating favorites for #{user.first_name}"
  puts "."
end

puts "done!"
