require_relative "piece"

class Queen < Piece
  attr_accessor :location
  attr_reader :color, :moves_available, :board, :symbol

  def initialize(location, color, board)
    super
    if color
      @symbol = "🨥"
    else
      @symbol = "🨁"
    end
    @moves_available = []
  end
end