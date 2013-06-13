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

	table = data.css("html body div div div table")[1].text
	# puts table

	array = table.split(/\n\n\n/)
	array.delete_at(0)
	# rank = whole_table.css("tbody tr td").text.strip
	array.each do |string|
		split_string = string.split(/\n/)
		gross = split_string[2]
		gross = gross.gsub("$", '')
		gross = gross.gsub(/,/, '')
		title = split_string[1].gsub(/'/, '')
		db.execute "INSERT INTO Movies VALUES('#{split_string[0]}', '#{title}', '#{gross}', '#{split_string[3]}')"
	end

rescue SQLite3::Exception => e

	puts "Exception occured"
	puts e

ensure
	db.close if db
end