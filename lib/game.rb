require_relative "board.rb"
require_relative "pawn.rb"
require_relative "rook.rb"
require_relative "knight.rb"
require_relative "bishop.rb"
require_relative "queen.rb"
require_relative "king.rb"

class Game
  def initialize
    @board = Board.new
    create_pieces
  end

  def create_pieces
    create_pawns
  end

  def create_pawns
    @board.spaces[1].each_with_index do |space, index|
      pawn = pawn.new(index, 1, true)
      space.piece = " /u265F"
    end

    @board.spaces[6].each_with_index do |space, index|
      pawn = pawn.new(index, 6, true)
      space.piece = " /u2659"
    end
  end
end