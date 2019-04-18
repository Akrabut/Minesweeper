class Input

  def get_input
    loop do
      puts "Enter coordinates in following formats - x y or x,y or x, y between 0 and 8"
      puts "Coordinates must be of an undiscovered square"
      input = gets.chomp.split(%r[, |,| ]).map {|n| n.to_i}
      return input if input.all? {|n| n.between?(0, 8)}
      puts "Invalid input"
    end
  end

end