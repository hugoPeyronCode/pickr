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
Item.destroy_all
Deck.destroy_all


puts "Creating users..."
guillaume = User.create!(username: "Guillaume", email: "guillaume@hello.fr", password: "123456", phone_number: "07 77 72 64 44")
audrey = User.create!(username: "Audrey", email: "audrey@hello.fr", password: "123456", phone_number: "06 32 45 67 89")
hugo = User.create!(username: "Hugo", email: "hugo@hello.fr", password: "123456", phone_number: "06 12 34 56 78")
robin = User.create!(username: "Robin", email: "robin@hello.fr", password: "123456", phone_number: "07 98 76 54 32")
puts "Users created"

puts "Creating 1 Pending Deck and 2 Closed Decks for Hugo..."
restaurantdeck1 = Deck.create!(name: "hugo1-rest-230301", status: "Pending", user: hugo, deck_type: "Restaurant")
restaurantdeck2 = Deck.create!(name: "hugo2-rest-230302", status: "Closed", user: hugo, deck_type: "Restaurant")
restaurantdeck3 = Deck.create!(name: "hugo3-rest-230303", status: "Closed", user: hugo, deck_type: "Restaurant")
puts "Decks created"

puts "Creating 5 Restaurants for Pending deck..."
item1 = Item.create!(
  name: "Sürpriz - Berliner Kebab",
  item_url: "https://www.surpriz.paris/",
  address: "110 Rue Oberkampf, 75011 Paris",
  rating: 4.7,
  price_range: 1,
  item_type: "Restaurant",
  photo_url: "https://storage.googleapis.com/mon-resto-halal/restaurants/ce93030e-dbe8-4357-9cce-c630fc628c75/thumb@1024_e1df9f14-b6ba-453c-85bc-ac6dab538cf8.jpg"
)
item2 = Item.create!(
  name: "Sukhumvit Thaï Street Food Paris 11",
  item_url: "https://www.instagram.com/sukhumvit.paris11/",
  address: "88 Rue Oberkampf, 75011 Paris",
  rating: 4,
  price_range: 0,
  item_type: "Restaurant",
  photo_url: "https://lh3.googleusercontent.com/p/AF1QipPX6bNfUxmIoN4atu0Y8HavtfYQJIDX-T_h3wLh=w1080-h608-p-no-v0"
)
item3 = Item.create!(
  name: "Boulangerie Chambelland",
  item_url: "https://chambelland.com/",
  address: "14 Rue Ternaux, 75011 Paris",
  rating: 4,
  price_range: 2,
  item_type: "Restaurant",
  photo_url: "https://www.ixelles.city/_custom_storage/collections/137/chambelland_20190517_73670.jpg"
)
item4 = Item.create!(
  name: "Açaï & You - St Ambroise (Brunch & Bowls Take away)",
  item_url: "http://www.acaiandyou.com/",
  address: "28 Rue Saint-Ambroise, 75011 Paris",
  rating: 5,
  price_range: 0,
  item_type: "Restaurant",
  photo_url: "https://meilleur-brunch.com/wp-content/uploads/2021/11/acaiandyou2_5_1125.jpeg"
)
item5 = Item.create!(
  name: "Scaria",
  item_url: "http://scaria.fr/",
  address: "88 Ave Parmentier, 75011 Paris",
  rating: 5,
  price_range: 2,
  item_type: "Restaurant",
  photo_url: "https://v2cdn1.centralappstatic.com/cache?url=gwBZASxXb5aRoDFLzKC_tPBNZW_8gQAU5teZacA5PGYUt85YiYjuwWQuzoCO6xpay10_CU97c2dAJQNlY4503SZS4vIwZ9RFzYgJFjRZotMk34y0sy3msnQ4KYwwffRJeTbKdDk7Fdx3sYrM4xrIVrSSgqBwTIv4p2qbB7JdM9tQDBUa0ga5PDssxBpn8JZYsdA_IZMgn4x1bja8ZF-Psbs8lgYfUpK1EbQ-YwGP8stHpZ_qv6rPXNNlsd5sDmWuWes5K0gCIhvrqRKLHca1hzTWEWmKXjGq9-aLuh356lLBilzu9Gh470zct1Wl8_3v5XWOWoFpGm_MBc3wLVEcAQXDrIPayZGkOSO8gcqQDH0E2FdN9rv_ClzEwuSffMPp62QJHRCgbSPZWONnnxuK6TZQK42wHwu5-aCw8bvkZt5LuA"
)
puts "Restaurants created"

puts "Creating 5 Restaurants for Future deck..."
item6 = Item.create!(
  name: "Future Sürpriz - Berliner Kebab",
  item_url: "https://www.surpriz.paris/",
  address: "110 Rue Oberkampf, 75011 Paris",
  rating: 4.7,
  price_range: 1,
  item_type: "Restaurant",
  photo_url: "https://storage.googleapis.com/mon-resto-halal/restaurants/ce93030e-dbe8-4357-9cce-c630fc628c75/thumb@1024_e1df9f14-b6ba-453c-85bc-ac6dab538cf8.jpg"
)
item7 = Item.create!(
  name: "Future Sukhumvit Thaï Street Food Paris 11",
  item_url: "https://www.instagram.com/sukhumvit.paris11/",
  address: "88 Rue Oberkampf, 75011 Paris",
  rating: 4.7,
  price_range: 0,
  item_type: "Restaurant",
  photo_url: "https://lh3.googleusercontent.com/p/AF1QipPX6bNfUxmIoN4atu0Y8HavtfYQJIDX-T_h3wLh=w1080-h608-p-no-v0"
)
item8 = Item.create!(
  name: "Future Boulangerie Chambelland",
  item_url: "https://chambelland.com/",
  address: "14 Rue Ternaux, 75011 Paris",
  rating: 4.4,
  price_range: 2,
  item_type: "Restaurant",
  photo_url: "https://www.ixelles.city/_custom_storage/collections/137/chambelland_20190517_73670.jpg"
)
item9 = Item.create!(
  name: "Future Açaï & You - St Ambroise (Brunch & Bowls Take away)",
  item_url: "http://www.acaiandyou.com/",
  address: "28 Rue Saint-Ambroise, 75011 Paris",
  rating: 4.8,
  price_range: 0,
  item_type: "Restaurant",
  photo_url: "https://meilleur-brunch.com/wp-content/uploads/2021/11/acaiandyou2_5_1125.jpeg"
)
item10 = Item.create!(
  name: "Future Scaria",
  item_url: "http://scaria.fr/",
  address: "88 Ave Parmentier, 75011 Paris",
  rating: 4.6,
  price_range: 2,
  item_type: "Restaurant",
  photo_url: "https://v2cdn1.centralappstatic.com/cache?url=gwBZASxXb5aRoDFLzKC_tPBNZW_8gQAU5teZacA5PGYUt85YiYjuwWQuzoCO6xpay10_CU97c2dAJQNlY4503SZS4vIwZ9RFzYgJFjRZotMk34y0sy3msnQ4KYwwffRJeTbKdDk7Fdx3sYrM4xrIVrSSgqBwTIv4p2qbB7JdM9tQDBUa0ga5PDssxBpn8JZYsdA_IZMgn4x1bja8ZF-Psbs8lgYfUpK1EbQ-YwGP8stHpZ_qv6rPXNNlsd5sDmWuWes5K0gCIhvrqRKLHca1hzTWEWmKXjGq9-aLuh356lLBilzu9Gh470zct1Wl8_3v5XWOWoFpGm_MBc3wLVEcAQXDrIPayZGkOSO8gcqQDH0E2FdN9rv_ClzEwuSffMPp62QJHRCgbSPZWONnnxuK6TZQK42wHwu5-aCw8bvkZt5LuA"
)
puts "Restaurants created"

puts "Creation de Deck_Items"
deck_item1 = DeckItem.create!(item: item1, deck: restaurantdeck1)
deck_item1 = DeckItem.create!(item: item2, deck: restaurantdeck1)
deck_item1 = DeckItem.create!(item: item3, deck: restaurantdeck1)
deck_item1 = DeckItem.create!(item: item4, deck: restaurantdeck1)
deck_item1 = DeckItem.create!(item: item5, deck: restaurantdeck1)
puts "finished"
