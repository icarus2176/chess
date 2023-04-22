class Piece
  attr_accessor :x, :y
  attr_reader :color, :moves, :board, :symbol

  def initialize(x, y, color, board)
    @x = x
    @y = y
    @color = color
    @board = board
    @moves = []
  end
end