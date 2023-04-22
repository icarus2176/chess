require_relative "piece.rb"

class Pawn < Piece
  attr_accessor :x, :y
  attr_reader :color, :moves, :board, :symbol

  def initialize(x, y, color, board)
    super
    if color
      @symbol = "🨩"
    else
      @symbol = "🨅"
    end
  end
end