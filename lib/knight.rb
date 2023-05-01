require_relative "piece"

class Knight < Piece
  attr_accessor :location
  attr_reader :color, :moves_available, :board, :symbol
  

  def initialize(location, color, board)
    super
    if color
      @symbol = "🨨"
    else
      @symbol = "🨄"
    end
    @moves = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end

  def find_moves 
    @moves_available = []
    moves.each do |space|
      new_x = @location[0] + space[0]
      new_y = @location[1] + space[1]
      @moves_available.push([new_x, new_y]) if new_x.between?(0, 7) && new_y.between?(0, 7)
    end
  end
end