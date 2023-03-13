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
# restaurantdeck1 = Deck.create!(name: "hugo1-rest-230301", status: "Pending", user: hugo, deck_type: "Restaurant")
restaurantdeck2 = Deck.create!(name: "Dej team Pickr", status: "Closed", user: guillaume, deck_type: "Restaurant")
restaurantdeck3 = Deck.create!(name: "new dej Schwiper", status: "Closed", user: guillaume, deck_type: "Restaurant")
# restaurantdeckOber = Deck.create!(name: "hugo4-rest-230304", status: "Pending", user: hugo, deck_type: "Restaurant")
puts "Decks created"


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

url = 'https://www.allocine.fr/film/aucinema/'
html = URI.open(url)
doc = Nokogiri::HTML(html)

#je récupère les titres et je récupère un array. Pour éviter de prendre les bandes annonces des films à venir, je sélectionne les 15 premiers car il n'y a que 15 films par page
title1 = doc.css('.meta-title-link').map(&:text).first(15)

director1 = doc.css('.meta-body-direction a.blue-link').map(&:text)
# p director1

#je récupère les synopsis que je récupère en array, je supprime les balises \n qui sont les sauts de ligne
synopsis1 = doc.css('.synopsis .content-txt').map(&:text)
clean_synopsis1 = synopsis1.map do |s|
  s.gsub("\n","")
end

#je récupère les rating, à chaque fois il y en a 3 pour chaque film (presse, spectateurs, mes amis sur allociné).
rating1 = doc.css('.stareval-note').map(&:text)
#les avis d'amis étant toujours vides, je les supprime
rating_cleaning1 = rating1.delete("--")
#le cleaning ne doit pas être appelé car il retourne seulement la string vide
#je sélectionne les indices impairs qui correspondent à l'avis presse
indices1 = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30]
rating_press1 = rating1.values_at(*indices1)
#j'arrondis à l'entier supérieur
rating_press1.map! { |rating| rating.tr(',', '.').to_f.round.to_i }

photo_url1 = doc.css('.thumbnail-img').map do |links|
  if links['src'].match?(/\bdata/)
    links['data-src']
  else
    links['src']
  end
end
#je récupère les genres qui sont mélangés avec les horaires et les dates. j'enlève les horaires et les dates
genre_links1 = doc.css('.meta-body-info').map(&:text)
genre1 = genre_links1.map { |s| s[/\b\p{Lu}\p{L}*+\b/] }


url2 = 'https://www.allocine.fr/film/aucinema/?page=2'
html2 = URI.open(url2)
doc2 = Nokogiri::HTML(html2)

#je récupère les titres et je récupère un array. Pour éviter de prendre les bandes annonces des films à venir, je sélectionne les 15 premiers car il n'y a que 15 films par page
title2 = doc2.css('.meta-title-link').map(&:text).first(15)
# p title2

director2 = doc2.css('.meta-body-direction a.blue-link').map(&:text)
#je récupère les synopsis que je récupère en array, je supprime les balises \n qui sont les sauts de ligne
synopsis2 = doc2.css('.synopsis .content-txt').map(&:text)
clean_synopsis2 = synopsis2.map do |s|
  s.gsub("\n","")
end

#je récupère les rating, à chaque fois il y en a 3 pour chaque film (presse, spectateurs, mes amis sur allociné).
rating2 = doc2.css('.stareval-note').map(&:text)
#les avis d'amis étant toujours vides, je les supprime
rating_cleaning2 = rating2.delete("--")
#le cleaning ne doit pas être appelé car il retourne seulement la string vide
#je sélectionne les indices impairs qui correspondent aux avis des spectateurs
indices2 = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30]
rating_press2 = rating2.values_at(*indices1)
#j'arrondis à l'entier supérieur
rating_press2.map! { |rating| rating.tr(',', '.').to_f.round.to_i }

photo_url2 = doc2.css('.thumbnail-img').map do |links|
  if links['src'].match?(/\bdata/)
    links['data-src']
  else
    links['src']
  end
end

genre_links2 = doc2.css('.meta-body-info').map(&:text)
clean_genre2 = genre_links2.map { |s| s[/\b\p{Lu}\p{L}*+\b/] }


puts "création de la 1ère page de films"
movies = []

title1.each_with_index do |title, index|
  movie = Item.new(
    name: title,
    movie_genre: genre1[index],
    movie_director: director1[index],
    synopsis: clean_synopsis1[index],
    rating: rating_press1[index],
    photo_url: photo_url1[index],
    item_type: "Movie"
  )
  if movie.save!
  p "Movie #{movie.name} created"
  end
  movies << movie
end
puts "finished creating first 15 movies"

puts "création de la 2ème page de films"
movies2 = []
title2.each_with_index do |title2, index|
  movie = Item.new(
    name: title2,
    movie_genre: clean_genre2[index],
    movie_director: director2[index],
    synopsis: clean_synopsis2[index],
    rating: rating_press2[index],
    photo_url: photo_url2[index],
    item_type: "Movie"
  )
  if movie.save!
    p "Movie #{movie.name} created"
  end
  movies2 << movie
end

puts "finished creating the last 15 movies"
