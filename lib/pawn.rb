require_relative "piece.rb"

class Pawn < Piece
  attr_accessor :location
  attr_reader :color, :moves, :board, :symbol

  def initialize(location, color, board)
    super
    if color
      @symbol = "🨩"
    else
      @symbol = "🨅"
    end
  end
end