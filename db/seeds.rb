# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

puts "Starting seed"
Cocktail.destroy_all
Ingredient.destroy_all

url = "https://www.thecocktaildb.com/api/json/v1/1/random.php"

15.times do
  drink_serialised = open(url).read
  drink = JSON.parse(drink_serialised)

  drink["drinks"].each do |info|
    cocktail = Cocktail.create!(name: info["strDrink"])
    15.times do |i|
      if info["strIngredient#{i}"] != nil
        ingredient = Ingredient.create!(name: info["strIngredient#{i}"])
        dose = Dose.create!(description: info["strMeasure#{i}"], cocktail: cocktail, ingredient: ingredient)
      end
    end
    puts cocktail.name
  end
end

puts "Finished seed"
