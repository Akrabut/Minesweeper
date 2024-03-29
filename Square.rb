require 'colorize'

class Square

  attr_accessor :value, :show

  def initialize(value)
    @value = value
    @show = false
  end

  def flip
    @show = true
    @value = "_" if @value == "*"
  end

  def ==(other)
    @value==other.value
  end

  def !=(other)
    !(self==other)
  end

  def flippable?
    @value != "O" && @value != "_" && !@show
  end

  def to_s
    if @show == true
      return @value.to_s.colorize(:magenta) if @value == 1
      return @value.to_s.colorize(:green) if @value == 2
      return @value.to_s.colorize(:cyan) if @value == 3
      return @value.to_s.colorize(:blue) if @value == 4
      return @value.to_s.colorize(:yellow) if @value == 5
      return @value.to_s.colorize(:yellow) if @value == 6
      return @value.to_s.colorize(:black) if @value == 7
      return @value.to_s.colorize(:black) if @value == 8
      return @value.colorize(:red) if @value == "O"
      return @value
    else "*"
    end
  end
  
end
