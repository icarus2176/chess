require_relative "piece"

class Knight < Piece
  attr_accessor :x, :y
  attr_reader :color, :moves, :board, :symbol
  move = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]

  def initialize(x, y, color, board)
    super
    if color
      @symbol = "🨨"
    else
      @symbol = "🨄"
    end
  end

  def moves_available 
    moves = []
    move.each do |space|
      new_x = @x + space[0]
      new_y = @y + space[1]
      moves.push([new_x, new_y]) if new_x.between?(0, 7) && new_y.between?(0, 7)
    end
    @moves = moves
  end
end