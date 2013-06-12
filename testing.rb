require 'nokogiri'
require 'open-uri'
require 'sqlite3'

url = "http://en.wikipedia.org/wiki/List_of_highest-grossing_films"

data = Nokogiri::HTML(open(url))


table = data.css("html body div div div table")[1].text
# puts table

array = table.split(/\n\n\n/)
array.delete_at(0)
split_array = array[2].split(/\n/)
puts array
