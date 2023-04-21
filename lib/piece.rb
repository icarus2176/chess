class Piece
  attr_accessor :x, :y
  attr_reader :color

  def initialize(x, y, color)
    @x = x
    @y = y
    @color = false
  end
end