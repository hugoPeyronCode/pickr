require 'nokogiri'
require 'open-uri'

url = 'https://www.allocine.fr/film/aucinema/'
html = URI.open(url)
doc = Nokogiri::HTML(html)


title1 = doc.css('.meta-title-link').map(&:text).first(15)
director1 = doc.css('.meta-body-direction a.blue-link').text
synopsis1 = doc.css('.synopsis .content-txt').map(&:text)
clean_synopsis1 = synopsis1.map do |s|
  s.gsub("\n","")
end


rating1 = doc.css('.stareval-note').map(&:text)
rating_cleaning1 = rating1.delete("--")
indices1 = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29]
rating_spectator1 = rating1.values_at(*indices1)
rating_spectator1.map! { |rating| rating.tr(',', '.').to_f.round.to_i }
photo_url1 = doc.css('.thumbnail-img').map { |links| links['data-src'] }

genre_links1 = doc.css('.meta-body-info').map(&:text)
clean_genre = genre_links1.map { |s| s[/\b\p{Lu}\p{L}*+\b/] }


# .gsub(/(\d{1,2}\s\w+\s\d{4}|\d{1,2}h\s\d{1,2}min)/, '').split(/\n+/)
# genres1 = genre_links1.select { |str| str.match?(/\A\p{L}+\z/) }
p clean_genre


url2 = 'https://www.allocine.fr/film/aucinema/'
html2 = URI.open(url2)
doc2 = Nokogiri::HTML(html2)

#je récupère les titres et je récupère un array. Pour éviter de prendre les bandes annonces des films à venir, je sélectionne les 15 premiers car il n'y a que 15 films par page
title2 = doc2.css('.meta-title-link').map(&:text).first(15)
director2 = doc2.css('.meta-body-direction a.blue-link').text
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
indices2 = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29]
rating_spectator2 = rating2.values_at(*indices1)
#j'arrondis à l'entier supérieur
rating_spectator2.map! { |rating| rating.tr(',', '.').to_f.round.to_i }


photo_url2 = doc2.css('.thumbnail-img').map { |links| links['data-src'] }

genre_links2 = doc2.css('.meta-body-info').text.strip.gsub(/(\d{1,2}\s\w+\s\d{4}|\d{1,2}h\s\d{1,2}min)/, '').split(/\n+/)
genres2 = genre_links2.select { |str| str.match?(/\A\p{L}+\z/) }

movies_seed = doc.map do |result|

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
