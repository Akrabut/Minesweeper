require_relative 'Square'
require 'set'

class Board

  def init_board
    @NUM_OF_ROWS = 9
    @NUM_OF_COLUMNS = 9
    @board = Array.new(@NUM_OF_ROWS){Array.new(@NUM_OF_COLUMNS, Square.new("*"))}
    @bomb_locations = Set.new
  end

  def [](coords)
    @board[coords[0]][coords[1]]
  end

  def []=(coords, value)
    @board[coords[0]][coords[1]] = value
  end

  def generate_bombs
    until @bomb_locations.length == 10
      coords = [rand(0..@NUM_OF_ROWS-1), rand(0..@NUM_OF_COLUMNS-1)]
      if !@bomb_locations.include?(coords) && (!self[coords] || self[coords].value != "O")
        @bomb_locations.add(coords)
        self[coords] = Square.new("O")
      end
    end
  end

  def count_traps(coords)
    total = 0
    total += 1 if @board[coords[0]-1][coords[1]-1].value = "O"
    total += 1 
  end

  def set_numbers
    @board.each do |arr|
      arr.each do |e|
        
      end
    end
  end

  def initialize
    init_board
    generate_bombs
  end

  def render
    print " "
    (0..@NUM_OF_COLUMNS-1).each {|e| print "#{e} "}
    puts
    @board.each.with_index do |arr, i| 
      print i
      arr.each{|e| print "#{e.to_s} "}
      puts "\n\n"
    end
  end

end

Board.new.render