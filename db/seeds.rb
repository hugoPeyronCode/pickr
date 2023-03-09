# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"
require "nokogiri"

puts "Cleaning database..."
Vote.destroy_all
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
restaurantdeckOber = Deck.create!(name: "hugo4-rest-230304", status: "Pending", user: hugo, deck_type: "Restaurant")
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


######### METHODO AVEC GOOGLE API ##########

# requête coordonnées:
# https://maps.googleapis.com/maps/api/geocode/json?
# address=Oberkampf
# &components=country:FR
# &key=#{ENV["GOOGLE_API_KEY"]}

# requête nearby:
# https://maps.googleapis.com/maps/api/place/nearbysearch/json
# ?location=48.8700698%2C2.3852427
# &radius=1500
# &maxprice=2
# &type=restaurant
# &key=#{ENV["GOOGLE_API_KEY"]}

# requête photo:
# https://maps.googleapis.com/maps/api/place/photo?
# maxwidth=1200
# &photo_reference=[ICI LE PHOTO REFERENCE ID]
# &key=#{ENV["GOOGLE_API_KEY"]}

# requête opening hours:
# https://maps.googleapis.com/maps/api/place/details/json?
# place_id=[ICI LA PLACE ID]
# &fields=name%2Crating%2Cformatted_phone_number&key=#{ENV["GOOGLE_API_KEY"]}

#methode pour récup une URL
def final_redirection_url(url)
  uri = URI(url)
  request = Net::HTTP::Head.new(uri)
  response = Net::HTTP.start(uri.host, uri.port, { use_ssl: uri.scheme == "https" }) do |http|
    http.request(request)
  end
  response["Location"]
end

# steps dans le terminal:
quartier = "Oberkampf"
radius = "500"
price = "2"

#1 obtention des coordonnées du quartier
url_coord = URI("https://maps.googleapis.com/maps/api/geocode/json?" \
  "address=#{quartier}" \
  "&components=country:FR" \
  "&key=#{ENV["GOOGLE_API_KEY"]}")
json_response_coord = JSON.parse(URI.open(url_coord).read)
lat = json_response_coord.dig("results", 0, "geometry", "location", "lat")
lng = json_response_coord.dig("results", 0, "geometry", "location", "lng")

#2 obtention des 20 premiers résultats de restaurants pour ce quartier
url_nearby = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json" \
"?location=#{lat}%2C#{lng}" \
"&radius=#{radius}" \
"&maxprice=#{price}" \
"&type=restaurant" \
"&key=#{ENV["GOOGLE_API_KEY"]}")
json_response_nearby = JSON.parse(URI.open(url_nearby).read)

restaus_nearby = json_response_nearby.dig("results").map do |result|

  parsed_photo_url = URI("https://maps.googleapis.com/maps/api/place/photo?" \
    "maxwidth=1200" \
    "&photo_reference=#{result.dig("photos", 0, "photo_reference")}" \
    "&key=#{ENV["GOOGLE_API_KEY"]}")
    json_response_photo_url = final_redirection_url(parsed_photo_url)

  parsed_item_url = URI("https://maps.googleapis.com/maps/api/place/details/json?" \
    "place_id=#{result.dig("place_id")}" \
    "&key=#{ENV["GOOGLE_API_KEY"]}")
    json_response_item_url = JSON.parse(URI.open(parsed_item_url).read)
    item_url = json_response_item_url.dig("results", 0, "website")

  item = Item.create!(
    name: result.dig("name"),
    item_url: item_url,
    address: result.dig("vicinity"),
    rating: result.dig("rating").round(0).to_i,
    price_range: result.dig("price_level"),
    item_type: "Restaurant",
    photo_url: json_response_photo_url
  )
  puts "Restaurant #{item.name} created"
  item
end

puts "Creation des Deck_items du restaurantdeckOber"
restaus_nearby.each do |item|
  DeckItem.create!(item: item, deck: restaurantdeckOber)
end
puts "finished"


# parsed_photo_url = URI("https://maps.googleapis.com/maps/api/place/photo?" \
#   "maxwidth=1200" \
#   "&photo_reference=#{json_response_nearby.dig("results", index, "photos", 0, "photo_reference")}" \
#   "&key=#{ENV["GOOGLE_API_KEY"]}")
#   json_response_photo_url = JSON.parse(URI.open(parsed_photo_url).read)

# pour test :
# parsed_photo_url = URI("https://maps.googleapis.com/maps/api/place/photo?" \
#   "maxwidth=1200" \
#   "&photo_reference=AfLeUgP8XJVAbfekkXIr_q4ijaTbX95EI9wcxKkIur6Djyt1XTa7ml8rlFcTuU5kTikueVn2GseRPSZheTuxjbSaotBGOYjZWWwXYxNWrVPX1iRKuQxe2hynaNN8G-JJg-nGUtp61slpHV2sH6ovzo1ZG5rqH6Gb8btqL1kDX6ikWDJMEBJP" \
#   "&key=#{ENV["GOOGLE_API_KEY"]}")
#   json_response_photo_url = JSON.parse(URI.open(parsed_photo_url).read)

# parsed_item_url = URI("https://maps.googleapis.com/maps/api/place/details/json?" \
#   "place_id=#{json_response_nearby.dig("results", index, "place_id")}" \
#   "&key=#{ENV["GOOGLE_API_KEY"]}")
#   json_response_item_url = JSON.parse(URI.open(parsed_item_url).read)
#   => item_url: "#{json_response_item_url.dig("results", index, "website")}"

url1 = 'https://www.allocine.fr/film/aucinema/'
html = URI.open(url1)
doc = Nokogiri::HTML(html)

puts "Creation de la 1ère page de films"
title = doc.css('.meta-title-link').text
# genre = doc.css('.meta-body-info').map(&:text).join(', ')
# puts genre => besoin de retravailler car on chope les dates aussi
director = doc.css('.meta-body-direction a.blue-link').text
synopsis = doc.css('.synopsis .content-txt').text.strip
rating = doc.css('.stareval-note').text
photo_url = doc.css('.thumbnail-img').map { |links| links['data-src'] }
puts "finished"

url2 = "https://www.allocine.fr/film/aucinema/?page=2"
html2 = URI.open(url2)
doc2 = Nokogiri::HTML(html2)

puts "Creation de la 2ème page de films"
title2 = doc2.css('.meta-title-link').text
director2 = doc2.css('.meta-body-direction a.blue-link').text
synopsis2 = doc2.css('.synopsis .content-txt').text.strip
rating2 = doc2.css('.stareval-note').text
photo_url2 = doc2.css('.thumbnail-img').map { |links| links['data-src'] }
puts "finished"

# genres = doc.css('.meta-body-info a.xXx').map(&:text).join(', ')
