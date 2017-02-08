require 'colorize'

class Game
	attr_accessor :board
	def initialize
		@board = []
		create_board
	end
	
	#creates all squares on the board
	def create_board
		8.times{|x| @board.push([nil,nil,nil,nil,nil,nil,nil,nil])}
		populate_board
	end	
	#puts all the pieces on these squares
	def populate_board
		8.times{|x|	@board[x][6] = Pawn.new([x, 6], "black", @board)}
		@board[0][7] = Rook.new([0, 7],  "black", @board)	
		@board[1][7] = Knight.new([1, 7],   "black", @board)
		@board[2][7] = Bishop.new([2, 7], "black", @board)
		@board[3][7] = Queen.new([3, 7], "black", @board)
		@board[4][7] = King.new([4, 7],     "black", @board)		
		@board[5][7] = Bishop.new([5, 7], "black", @board)
		@board[6][7] = Knight.new([6, 7],  "black", @board)
		@board[7][7] = Rook.new([7, 7],    "black", @board)
				
		 8.times{|x|	@board[x][1] = Pawn.new([x, 1], "white", @board)}
		@board[0][0] = Rook.new([0, 0],  "white", @board)	
		@board[1][0] = Knight.new([1, 0],   "white", @board)
		@board[2][0] = Bishop.new([2, 0], "white", @board)
		@board[3][0] = Queen.new([3, 0], "white", @board)
		@board[4][0] = King.new([4, 0],     "white", @board)		
		@board[5][0] = Bishop.new([5, 0], "white", @board)
		@board[6][0] = Knight.new([6, 0],  "white", @board)
		@board[7][0] = Rook.new([7, 0],    "white", @board)
	end
	
	#shows the board in its current state
	def display_board
			system("cls")
			print "\n"
			  7.downto(0).each_with_index{|x|
				 print  "#{x+1}| "
					8.times{|y|
					if y%2==0 && x%2 == 0 || y%2==1 && x%2 == 1
						if @board[y][x] != nil && @board[y][x].color == "white"
							print @board[y][x].class.to_s[0].white.bold.on_red, " ".on_red
						elsif @board[y][x] != nil && @board[y][x].color == "black"
							print @board[y][x].class.to_s[0].green.bold.on_red, " ".on_red
						else 
							print "  ".on_red
						end
					else
						if @board[y][x] != nil  && @board[y][x].color == "white"
							print @board[y][x].class.to_s[0].white.bold, " "
						elsif @board[y][x] != nil && @board[y][x].color == "black"
							print @board[y][x].class.to_s[0].green.bold, " "
						else 
							print " ", " "
						end
					end
					}
				print "\n"
				 }
			 print "------------------\n"
			 print "   a b c d e f g h\n\n"
	end
	
	def move_piece(start, final)
		sx = nil
		fx = nil
		sy = start[1].to_i-1	
		fy = final[1].to_i-1
		
	
		#converts x axis letter to a number
		("a".."h").each_with_index{|x, ind| 
			if start[0] == x
				sx = ind
			end
			if final[0] == x
				fx = ind
			end
		}
		move = [fx, fy]		
		#sets new board location to requested one if the requested location is part of the legal moves array
		@board[sx][sy].get_moves
		if @board[sx][sy].legal_moves.include? move
			@board[sx][sy].get_moves
			@board[fx][fy] = @board[sx][sy]			
			@board[fx][fy].set_location([fx, fy])			
			@board[sx][sy] = nil
		else
			@board[sx][sy].get_moves
			puts "invalid move"
		end
		gets
		
	end
end


class Piece
	attr_accessor :name, :location, :color, :x, :y
	def initialize(location, color, board)
		@location = location
		@color = color
		@x = location[0]
		@y = location[1]
		@board = board
	end
	
	def set_location(new_loc)
		@location = new_loc
		@x = new_loc[0]
		@y = new_loc[1]
		puts "New Location is #{@location}"
	end
end

class Pawn < Piece
	attr_accessor :legal_moves
	def initialize(location, color, board)
		super(location, color, board)
		@first_move = true
		if @color == "white"
			@legal_moves = [[@x, @y+1],[@x, @y+2]]
		else
			@legal_moves = [[@x, @y-1],[@x, @y-2]]
		end
	end
	
	def get_moves
		@legal_moves = []		
		
		if @color == "white"
			if @first_move == true
				@legal_moves = @legal_moves.push([@x, @y+2])
				@first_move = false
			end
			if @board[@x][@y+1] == nil
				@legal_moves.push([@x, @y+1])
			end
			if  @x<7 && @board[@x+1][@y+1] != nil
				@legal_moves.push([@x+1, @y+1])
			end

			if @board[@x-1][@y+1] != nil && @x>0
				@legal_moves.push([@x-1, @y+1])
			end
		else
			if @first_move == true
				@legal_moves = @legal_moves.push([@x, @y-2])
				first_move = false
			end
			if @board[@x][@y-1] == nil
				@legal_moves.push([@x, @y-1])
			end
			if @x<7 && @board[@x+1][@y-1] != nil
					@legal_moves.push([@x+1, @y-1])
			end
			if @x>0 && @board[@x-1][@y-1] != nil
				@legal_moves.push([@x-1, @y-1])
			end
		end

	end
end

 class Rook < Piece
 attr_accessor :legal_moves
	def initialize(location, color, board)
		super(location, color, board)
		@legal_moves = []
	end
	
	def get_moves
		count = 1
		cx = @x
		cy = @y		
		@legal_moves = []
		
		current = @board[cx][cy+count]
		while current == nil	&& (cy+count) <= 7		
			@legal_moves.push([@x, @y+count])			
			count +=1
			current = @board[cx][cy+count]
		end
		
		count = 1		
		current = @board[cx][cy-count]		
		while current == nil && (cy-count) >= 0
			@legal_moves.push([@x, @y-count])			
			count +=1
			current = @board[cx][cy-count]			
		end
		
		count = 1
		if cx-count >=0
			current = @board[cx-count][cy]		
			while current == nil && (cx-count) >= 1
				@legal_moves.push([@x-count, @y])			
				count +=1
				current = @board[cx-count][cy]			
			end
			@legal_moves.push([@x-count, @y])
		end
		
		count = 1		
		if cx+count <=7
			current = @board[cx+count][cy]			
			while current == nil && (cx+count) <= 6
				@legal_moves.push([@x+count, @y])		
				count +=1
				current = @board[cx+count][cy]
				print @legal_moves
			end
			@legal_moves.push([@x+count, @y])		
		end
		
	end
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



