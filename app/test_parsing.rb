require 'nokogiri'
require 'open-uri'

url = 'https://www.allocine.fr/film/aucinema/'
html = URI.open(url)
doc = Nokogiri::HTML(html)

title1 = doc.css('.meta-title-link').map(&:text).first(15)
director1 = doc.css('.meta-body-direction a.blue-link').map(&:text)
synopsis1 = doc.css('.synopsis .content-txt').map(&:text)
clean_synopsis1 = synopsis1.map do |s|
  s.gsub("\n","")
end

rating1 = doc.css('.stareval-note').map(&:text)
rating_cleaning1 = rating1.delete("--")
indices1 = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29]
rating_spectator1 = rating1.values_at(*indices1)
rating_spectator1.map! { |rating| rating.tr(',', '.').to_f.round.to_i }

photo_url1 = doc.css('.thumbnail-img').map { |links| links['data'] }


genre_links1 = doc.css('.meta-body-info').map(&:text)
clean_genre = genre_links1.map { |s| s[/\b\p{Lu}\p{L}*+\b/] }


url2 = 'https://www.allocine.fr/film/aucinema/?page=2'
html2 = URI.open(url2)
doc2 = Nokogiri::HTML(html2)

#je récupère les titres et je récupère un array. Pour éviter de prendre les bandes annonces des films à venir, je sélectionne les 15 premiers car il n'y a que 15 films par page
title2 = doc2.css('.meta-title-link').map(&:text).first(15)
# p title2

director2 = doc2.css('.meta-body-direction a.blue-link').text
p director2
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

photo_url2 = doc2.css('.thumbnail-img').map { |links| links['data'] }

genre_links2 = doc2.css('.meta-body-info').map(&:text)
clean_genre2 = genre_links2.map { |s| s[/\b\p{Lu}\p{L}*+\b/] }
