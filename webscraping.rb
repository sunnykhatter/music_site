require 'nokogiri'
require 'open-uri'
require 'sqlite3'

url = "http://en.wikipedia.org/wiki/List_of_highest-grossing_films"

data = Nokogiri::HTML(open(url))


begin 
	db = SQLite3::Database.open "test1.db"
	db.execute "CREATE TABLE IF NOT EXISTS Movies(Id INTEGER PRIMARY KEY, Name TEXT, Gross INT)"
	db.execute "INSERT INTO Movies VALUES(1, 'Avatar', 100)"
	db.execute "INSERT INTO Movies VALUES(2, 'Snatch', 99)"

rescue SQLite3::Exception => e

	puts "Exception occured"
	puts e

ensure
	db.close if db
end