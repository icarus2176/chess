require_relative "piece"

class Bishop < Piece
  attr_accessor :location
  attr_reader :color, :moves_available, :board, :symbol

  def initialize(location, color, board)
    super
    if color
      @symbol = "🨧"
    else
      @symbol = "🨃"
    end
    @moves = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  end

  def find_moves
    @moves_available = []
    moves.each do |space|
      new_x = @location[0]
      new_y = @location[1]
      while new_x.between?(1, 6) && new_y.between?(1, 6)
        new_x += space[0]
        new_y += space[1]
        @moves_available.push([new_x, new_y])
      end
    end
  end
end