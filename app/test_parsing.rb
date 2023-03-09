require 'nokogiri'
require 'open-uri'

url = 'https://www.allocine.fr/film/aucinema/'
html = URI.open(url)
doc = Nokogiri::HTML(html)


title1 = doc.css('.meta-title-link').text
# genre = doc.css('.meta-body-info').map(&:text).join(', ')
# puts genre => besoin de retravailler car on chope les dates aussi
director1 = doc.css('.meta-body-direction a.blue-link').text
synopsis1 = doc.css('.synopsis .content-txt').text.strip
rating1 = doc.css('.stareval-note').text
photo_url1 = doc.css('.thumbnail-img').map{|links| links['data-src']}

url2 = "https://www.allocine.fr/film/aucinema/?page=2"
html2 = URI.open(url2)
doc2 = Nokogiri::HTML(html2)


title2 = doc2.css('.meta-title-link').text
director2 = doc2.css('.meta-body-direction a.blue-link').text
synopsis2 = doc2.css('.synopsis .content-txt').text.strip
rating2 = doc2.css('.stareval-note').text
puts rating2
photo_url2 = doc2.css('.thumbnail-img').map{|links| links['data-src']}
