require_relative "piece"

class Rook < Piece
  attr_accessor :location
  attr_reader :color, :moves, :board, :symbol
  move = [[0, -1], [0, 1], [1, 0 ], [-1, 0]]

  def initialize(location, color, board)
    super
    if color
      @symbol = "🨦"
    else
      @symbol = "🨂"
    end
  end

  def moves_available
    moves = []
    move.each do |space|
      new_x = @location[0] + space[0]
      new_y = @location[1] + space[1]
      moves.push([new_x, new_y]) if new_x.between?(0, 7) && new_y.between?(0, 7)
    end
    @moves = moves
  end
end