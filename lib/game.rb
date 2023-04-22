require_relative "board"
require_relative "pawn"
require_relative "rook"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"

class Game
  def initialize
    @board = Board.new
    @white_pieces = []
    @black_pieces = []
    create_pieces
  end

  def create_pieces
    create_pawns
    create_rooks
    create_knights
    create_bishops
    create_queens
    create_kings
  end

  def create_pawns
    @board.spaces[1].each_with_index do |space, index|
      pawn = Pawn.new(index, 1, true)
      space.piece = pawn
      @black_pieces.push(pawn)
    end

    @board.spaces[6].each_with_index do |space, index|
      pawn = Pawn.new(index, 6, false)
      space.piece = pawn
      @white_pieces.push(pawn)
    end
  end

  def create_rooks
    rook1 = Rook.new(0, 0, true)
    @board.spaces[0, 0].piece = rook1
    @black_pieces.push(rook1)

    rook2 = Rook.new(0, 7, true)
    @board.spaces[0, 7].piece = rook2
    @black_pieces.push(rook1)

    rook3 = Rook.new(7, 0, false)
    @board.spaces[7, 0].piece = rook3
    @white_pieces.push(rook3)

    rook4 = Rook.new(7, 7, false)
    @board.spaces[7, 7].piece = rook4
    @white_pieces.push(rook4)
  end

  def create_knights
    knight1 = Knight.new(0, 1, true)
    @board.spaces[0, 1].piece = knight1
    @black_pieces.push(knight1)

    knight2 = Knight.new(0, 6, true)
    @board.spaces[0, 6].piece = knight2
    @black_pieces.push(knight2)

    knight3 = Knight.new(7, 1, false)
    @board.spaces[7, 1].piece = knight3
    @white_pieces.push(knight3)

    knight4 = Knight.new(7, 6, false)
    @board.spaces[7, 6].piece = knight4
    @white_pieces.push(knight4)
  end

  def create_bishops
    bishop1 = Bishop.new(0, 2, true)
    @board.spaces[0, 2].piece = bishop1
    @black_pieces.push(bishop1)

    bishop2 = Bishop.new(0, 5, true)
    @board.spaces[0, 5].piece = bishop2
    @black_pieces.push(bishop2)

    bishop3 = Bishop.new(7, 2, false)
    @board.spaces[7, 2].piece = bishop3
    @white_pieces.push(bishop3)

    bishop4 = Bishop.new(7, 5, false)
    @board.spaces[7, 5].piece = bishop4
    @white_pieces.push(bishop4)
  end

  def create_queens
    queen1 = Queen.new(0, 4, true)
    @board.spaces[0, 0].piece = queen1
    @black_pieces.push(queen1)

    queen2 = Queen.new(7, 4, false)
    @board.spaces[7, 7].piece = queen2 
    @white_pieces.push(queen2)
  end

  def create_kings
    king1 = King.new(0, 3, true)
    @board.spaces[0, 3].piece = king1
    @black_pieces.push(king1)

    king2 = King.new(7, 3, false)
    @board.spaces[7, 3].piece = king2
    @@white_pieces.push(king2)
  end

  def move(space1, space2)
    start_space = space1.split("")
    piece = @board[start_space[0], start_space[1]].piece
    end_space = space2.split("")
    if piece.moves.include?(end_space)
      piece.x = end_space[0]
      piece.y = end_space[1]

      @board[end_space[0], end_space[1]].piece&.delete
      @board[end_space[0], end_space[1]].piece = piece
    else
      puts "Invalid move."
      get_input
    end
  end
end