# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"

puts "Cleaning database..."
User.destroy_all
Deck.destroy_all
Deck_item.destroy_all
Item.destroy_all
Vote.destroy_all

puts "Creating users..."
guillaume = User.create!(username: "Guillaume", email: "guillaume@hello.fr", password: "123456", phone: "07 77 72 64 44")
audrey = User.create!(username: "Audrey", email: "audrey@hello.fr", password: "123456", phone: "06 32 45 67 89")
hugo = User.create!(username: "Hugo", email: "hugo@hello.fr", password: "123456", phone: "06 12 34 56 78")
robin = User.create!(username: "Robin", email: "robin@hello.fr", password: "123456", phone: "07 98 76 54 32")
puts "Users created"

puts "Creating 1 Pending Deck and 2 Closed Decks for Hugo..."
restaurantdeck1 = Deck.create!(name: "hugo1-rest-230301", status: "Pending", user: hugo)
restaurantdeck2 = Deck.create!(name: "hugo2-rest-230302", status: "Closed", user: hugo)
restaurantdeck3 = Deck.create!(name: "hugo3-rest-230303", status: "Closed", user: hugo)
puts "Decks created"

# puts "Creating 5 Restaurants for Pending deck..."
# puts "Restaurants created"
# puts "Creating 5 Restaurants for Future deck..."
# puts "Restaurants created"
