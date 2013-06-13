require 'sqlite3'
require 'sinatra'

get '/' do

	begin


	db = SQLite3::Database.open "top50.db"

	stm = db.prepare "SELECT * FROM Movies LIMIT 50"
	@rs = stm.execute
	erb :movies

	#just for displaying the rs array
	# rs.each do |row|
	# 	puts row.join(' ')
	# end

	rescue SQLite3::Exception => e 
	    
	    puts "Exception occured"
	    puts e
	    
	ensure
	     stm.close if stm
	     db.close if db

	end

end
