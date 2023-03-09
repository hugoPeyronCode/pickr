require 'nokogiri'
require 'open-uri'

url = 'https://www.allocine.fr/film/aucinema/'
html = URI.open(url)
doc = Nokogiri::HTML(html)


title1 = doc.css('.meta-title-link').text
director1 = doc.css('.meta-body-direction a.blue-link').text
synopsis1 = doc.css('.synopsis .content-txt').text.strip
rating1 = doc.css('.stareval-note').text
photo_url1 = doc.css('.thumbnail-img').map{|links| links['data-src']}
genre_links = doc.css('.meta-body-info').text.strip.gsub(/(\d{1,2}\s\w+\s\d{4}|\d{1,2}h\s\d{1,2}min)/, '').split(/\n+/)
genres1 = genre_links.select { |str| str.match?(/\A\p{L}+\z/) }
p genres1

url2 = "https://www.allocine.fr/film/aucinema/?page=2"
html2 = URI.open(url2)
doc2 = Nokogiri::HTML(html2)


title2 = doc2.css('.meta-title-link').text
director2 = doc2.css('.meta-body-direction a.blue-link').text
synopsis2 = doc2.css('.synopsis .content-txt').text.strip
rating2 = doc2.css('.stareval-note').text

photo_url2 = doc2.css('.thumbnail-img').map{|links| links['data-src']}
genre_links = doc2.css('.meta-body-info').text.strip.gsub(/(\d{1,2}\s\w+\s\d{4}|\d{1,2}h\s\d{1,2}min)/, '').split(/\n+/)
genres2 = genre_links.select { |str| str.match?(/\A\p{L}+\z/) }

p genres2
