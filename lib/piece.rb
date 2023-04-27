class Piece
  attr_accessor :location
  attr_reader :color, :moves, :board, :symbol

  def initialize(location, color, board)
    @location = location
    @color = color
    @board = board
    @moves_available = []
  end
end