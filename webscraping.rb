require 'nokogiri'
require 'open-uri'
require 'sqlite3'

url = "http://en.wikipedia.org/wiki/List_of_highest-grossing_films"

data = Nokogiri::HTML(open(url))
version = "First"

begin 
	db = SQLite3::Database.open "#{version}top50.db"
	
	db.execute "CREATE TABLE IF NOT EXISTS Movies(Id INTEGER PRIMARY KEY, Name TEXT, Gross INTEGER, Year INTEGER)"
	db.execute "DELETE FROM Movies"

	table = data.css("html body div div div table")[1]
	titles = table.css("a").text
	titles.slice!(0,4)
	titles = titles.gsub(/\[. \d+\]/, "\n" )
	title_array = titles.split("\n")

	table = data.css("html body div div div table")[1].text
	array = table.split(/\n\n\n/)
	array.delete_at(0)
	count = 0

	array.each do |string|
		split_string = string.split(/\n/)
		gross = split_string[2]
		gross = gross.gsub("$", '')
		gross = gross.gsub(/,/, '')
		title = title_array[count]
		title = title.gsub(/'/, '')
		# title = split_string[1].gsub(/'/, '')
		db.execute "INSERT INTO Movies VALUES('#{split_string[0]}', '#{title}', '#{gross}', '#{split_string[3]}')"
		count += 1
	end

rescue SQLite3::Exception => e

	puts "Exception occured"
	puts e

ensure
	db.close if db
end