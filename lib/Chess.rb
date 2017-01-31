require 'colorize'

class Game
	attr_accessor :board
	def initialize
		@board = {}
		create_board
	end
	
	#creates all squares on the board
	def create_board
		counter = 1
		(1..8).each{|row|
			#col means column(a-h)
			@board[row] = [Square.new("a", row),Square.new("b", row), Square.new("c", row),Square.new("d", row), Square.new("e", row),Square.new("f", row), Square.new("g", row),Square.new("h", row)]
		}		
		(1..8).each{|row|
			@board[row].each{|x|
			x.index = counter
			counter += 1			
			}
		}
		populate_board
	end
	
	#puts all the pieces on these squares
	def populate_board		
		@board[7].each{|sq| sq.occupied_by = Pawn.new([sq.x, sq.y], "black")	}		
		@board[8][0].occupied_by = Rook.new([@board[8][0].x, @board[8][0].y], "black")		
		@board[8][1].occupied_by = Knight.new([@board[8][1].x, @board[8][1].y], "black")
		@board[8][2].occupied_by = Bishop.new([@board[8][2].x, @board[8][2].y], "black")
		@board[8][3].occupied_by = Queen.new([@board[8][3].x, @board[8][3].y], "black")
		@board[8][4].occupied_by = King.new([@board[8][4].x, @board[8][4].y], "black")		
		@board[8][5].occupied_by = Bishop.new([@board[8][5].x, @board[8][5].y], "black")
		@board[8][6].occupied_by = Knight.new([@board[8][6].x, @board[8][6].y], "black")
		@board[8][7].occupied_by = Rook.new([@board[8][7].x, @board[8][7].y], "black")
				
		@board[2].each{|sq| sq.occupied_by = Pawn.new([sq.x, sq.y], "white")	}
		@board[1][0].occupied_by = Rook.new([@board[1][0].x, @board[1][0].y], "white")		
		@board[1][1].occupied_by = Knight.new([@board[1][1].x, @board[1][1].y], "white")
		@board[1][2].occupied_by = Bishop.new([@board[1][2].x, @board[1][2].y], "white")
		@board[1][3].occupied_by = Queen.new([@board[1][3].x, @board[1][3].y], "white")
		@board[1][4].occupied_by = King.new([@board[1][4].x, @board[1][4].y], "white")		
		@board[1][5].occupied_by = Bishop.new([@board[1][5].x, @board[1][5].y], "white")
		@board[1][6].occupied_by = Knight.new([@board[1][6].x, @board[1][6].y], "white")
		@board[1][7].occupied_by = Rook.new([@board[1][7].x, @board[1][7].y], "white")
	end
	
	#shows the board in its current state
	def display_board
			system("cls")
			print "\n"
			 8.downto(1).each{|x|
				print "#{x}| "
				@board[x].each{|y|
					if y.occupied_by != nil
						print  y.occupied_by.class.to_s[0], " "
					else
						print "  "
					end
				}
				print "\n"
			 }
			 print "------------------\n"
			 print "   a b c d e f g h\n\n"
	end
	
	def move_piece(start, final)
		sx = start[0]
		sy = start[1].to_i
		
		fx = final[0]
		fy = final[1].to_i
		
		start_sq = nil
		final_sq = nil
		
		@board[sy].each{|sq| 
			if sq.x == sx
				start_sq = sq
				
			end
		}
		puts start_sq.occupied_by.legal_moves
			gets
		@board[fy].each_with_index{|sq, ind| 
			if sq.x == fx
				@board[fy][ind].occupied_by = start_sq.occupied_by
				@board[sy].each_with_index{|sq, ind| 
					if sq.x == sx
						@board[sy][ind].occupied_by = nil
					end
		}
			end
		}
		
	end
	
end
class Square
	attr_accessor :x, :y, :occupied_by, :index
	def initialize(x, y)
		@x = x
		@y = y
		@occupied_by = nil
		@index = nil
	end
end

class Piece
	attr_accessor :name, :location, :color
	def initialize(location, color)
		#@name = name
		@location = location
		@color = color
	end
end

class Pawn < Piece
	attr_accessor :legal_moves
	def initialize(location, color)
		super(location, color)
		@legal_moves = ["whatever"]
	end
	
end

 class Rook < Piece
 end

 class Knight < Piece
 end

 class Bishop < Piece
 end

 class Queen < Piece
 end

 class King <Piece
 end



#game.board["a"].each{|x| print x.x, x.y, "\n"}

game = Game.new
game_over = true
while game_over != false
	game.display_board
	puts "Which piece would you like to move?"
	game.move_piece(gets.chomp, gets.chomp)
end



