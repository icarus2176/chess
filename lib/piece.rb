class Piece
  attr_accessor :x, :y
  attr_reader :color, :moves

  def initialize(x, y, color)
    @x = x
    @y = y
    @color = false
    @moves = []
  end
end