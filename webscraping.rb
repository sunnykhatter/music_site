require 'nokogiri'
require 'open-uri'

url = ""

data = Nokogiri::HTML(open(url))
