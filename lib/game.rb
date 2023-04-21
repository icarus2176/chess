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
      pawn = Pawn.new(index, 1, true)
      space.piece = pawn
    end

    @board.spaces[6].each_with_index do |space, index|
      pawn = Pawn.new(index, 6, false)
      space.piece = pawn
    end
  end

  def create_rooks
    @board.spaces[0, 0].piece = Rook.new(0, 0, true)
    @board.spaces[0, 7].piece = Rook.new(0, 7, true)

    @board.spaces[7, 0].piece = Rook.new(7, 0, false)
    @board.spaces[7, 7].piece = Rook.new(7, 7, false)
  end

  def create_knights
    @board.spaces[0, 1].piece = Knight.new(0, 1, true)
    @board.spaces[0, 6].piece = Knight.new(0, 6, true)

    @board.spaces[7, 1].piece = Knight.new(7, 1, false)
    @board.spaces[7, 6].piece = Knight.new(7, 6, false)
  end

  def create_bishops
    @board.spaces[0, 2].piece = Bishop.new(0, 2, true)
    @board.spaces[0, 5].piece = Bishop.new(0, 5, true)

    @board.spaces[7, 2].piece = Bishop.new(7, 2, false)
    @board.spaces[7, 5].piece = Bishop.new(7, 5, false)
  end

  def create_queens
    @board.spaces[0, 0].piece = Queen.new(0, 4, true)

    @board.spaces[7, 7].piece = Queen.new(7, 4, false)
  end

  def create_kings
    @board.spaces[0, 3].piece = King.new(0, 3, true)

    @board.spaces[7, 3].piece = King.new(7, 3, false)
  end
end