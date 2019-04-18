require_relative 'Square'
require_relative 'Input'
require 'set'

class Board

  def init_board
    @NUM_OF_ROWS = 9
    @NUM_OF_COLUMNS = 9
    @board = Array.new(@NUM_OF_ROWS){Array.new(@NUM_OF_COLUMNS){|e| Square.new("*")}}
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

  def within_boundaries?(x, y)
    x < @NUM_OF_ROWS && y < @NUM_OF_COLUMNS && x > -1 && y > -1
  end

  def count_traps(x, y)
    total = 0
    total += 1 if within_boundaries?(x-1,y-1) && @board[x-1][y-1].value == "O"
    total += 1 if within_boundaries?(x-1,y) && @board[x-1][y].value == "O"
    total += 1 if within_boundaries?(x-1,y+1) && @board[x-1][y+1].value == "O"
    total += 1 if within_boundaries?(x,y+1) && @board[x][y+1].value == "O"
    total += 1 if within_boundaries?(x+1,y+1) && @board[x+1][y+1].value == "O"
    total += 1 if within_boundaries?(x+1,y) && @board[x+1][y].value == "O"
    total += 1 if within_boundaries?(x+1,y-1) && @board[x+1][y-1].value == "O"
    total += 1 if within_boundaries?(x,y-1) && @board[x][y-1].value == "O"
    total
  end

  def set_numbers
    @board.each.with_index do |arr, x|
      arr.each.with_index do |e, y|
        next if e.value == "O"
        traps = count_traps(x, y)
        next if traps == 0
        e.value = traps
      end
    end
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

  def initialize
    init_board
    generate_bombs
    set_numbers
    render
  end

  def reveal_adjacent_cells(coords)
    self[coords].flip
    return if self[coords].value.is_a?(Integer)
    left = [coords[0], coords[1]-1]
    reveal_adjacent_cells(left) if within_boundaries?(left[0], left[1]) && self[left].flippable?
    right = [coords[0], coords[1]+1]
    reveal_adjacent_cells(right) if within_boundaries?(right[0], right[1]) && self[right].flippable?
    up = [coords[0]+1, coords[1]]
    reveal_adjacent_cells(up) if within_boundaries?(up[0], up[1]) && self[up].flippable?
    down = [coords[0]-1, coords[1]]
    reveal_adjacent_cells(down) if within_boundaries?(down[0], down[1]) && self[down].flippable?
  end

  def game_over?
    @board.all? {|arr| arr.none? {|e| e.value == "*"}}
  end

  def loss(input)
    #reveal_everything
    self[input].flip
    render
    puts "\n\nDefeat!!\nYou've been exploded to pieces!\n\n".colorize(:red)
    exit(1)
  end

  def get_input
    user = Input.new
    loop do
      input = user.get_input
      return loss(input) if self[input].value == "O"
      return reveal_adjacent_cells(input) if !self[input].show
      puts "Invalid input"
    end
  end

  def reveal_everything
    @board.each {|column| column.each {|e| e.flip}}
    render
  end

  def play
    until game_over?
      get_input
      system("cls")
      render
    end
    render
    puts "\n\nVicory!!\nYou've sweeped everything!!\n\n".colorize(:green)
    sleep(5)
    reveal_everything
  end


end

Board.new.play

