#this prints out the index of every square in board[2]
@board[2].each{|x| print x.index, " "}


#board info
# (1..8).each{|col|
			# @board[col].each{|element|
				# print element.index, " "
				 # begin
					 # puts "Square: #{element.x},#{element.y}, index: #{element.index}, Occupied by:  #{element.occupied_by.color} #{element.occupied_by.class}"
				 # rescue
					 # puts "Square: #{element.x},#{element.y}, index: #{element.index}, Occupied by:  None"
				 # end
			# }
			# puts "\n"
		# }