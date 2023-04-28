require_relative "board"
require_relative "pawn"
require_relative "rook"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"
require_relative "player"

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @white_pieces = []
    @white = Player.new("white")
    @black_pieces = []
    @black = Player.new("black")
    create_pieces
    @active_player = @white
  end

  def create_pieces
    create_kings
    create_pawns
    create_rooks
    create_knights
    create_bishops
    create_queens

    find_all_moves
  end

  def find_all_moves
    @white_pieces.each do |piece|
      piece.find_moves
    end

    @black_pieces.each do |piece|
      piece.find_moves
    end
  end

  def create_pawns
    @board.spaces[1].each_with_index do |space, index|
      pawn = Pawn.new([index, 1], true, @board)
      space.piece = pawn
      @black_pieces.push(pawn)
    end

    @board.spaces[6].each_with_index do |space, index|
      pawn = Pawn.new([index, 6], false, @board)
      space.piece = pawn
      @white_pieces.push(pawn)
    end
  end

  def create_rooks
    rook1 = Rook.new([0, 0], true, @board)
    @board.spaces[0][0].piece = rook1
    @black_pieces.push(rook1)

    rook2 = Rook.new([0, 7], true, @board)
    @board.spaces[0][7].piece = rook2
    @black_pieces.push(rook1)

    rook3 = Rook.new([7, 0], false, @board)
    @board.spaces[7][0].piece = rook3
    @white_pieces.push(rook3)

    rook4 = Rook.new([7, 7], false, @board)
    @board.spaces[7][7].piece = rook4
    @white_pieces.push(rook4)
  end

  def create_knights
    knight1 = Knight.new([0, 1], true, @board)
    @board.spaces[0][1].piece = knight1
    @black_pieces.push(knight1)

    knight2 = Knight.new([0, 6], true, @board)
    @board.spaces[0][6].piece = knight2
    @black_pieces.push(knight2)

    knight3 = Knight.new([7, 1], false, @board)
    @board.spaces[7][1].piece = knight3
    @white_pieces.push(knight3)

    knight4 = Knight.new([7, 6], false, @board)
    @board.spaces[7][6].piece = knight4
    @white_pieces.push(knight4)
  end

  def create_bishops
    bishop1 = Bishop.new([0, 2], true, @board)
    @board.spaces[0][2].piece = bishop1
    @black_pieces.push(bishop1)

    bishop2 = Bishop.new([0, 5], true, @board)
    @board.spaces[0][5].piece = bishop2
    @black_pieces.push(bishop2)

    bishop3 = Bishop.new([7, 2], false, @board)
    @board.spaces[7][2].piece = bishop3
    @white_pieces.push(bishop3)

    bishop4 = Bishop.new([7, 5], false, @board)
    @board.spaces[7][5].piece = bishop4
    @white_pieces.push(bishop4)
  end

  def create_queens
    queen1 = Queen.new([0, 3], true, @board)
    @board.spaces[0][3].piece = queen1
    @black_pieces.push(queen1)

    queen2 = Queen.new([7, 3], false, @board)
    @board.spaces[7][3].piece = queen2 
    @white_pieces.push(queen2)
  end

  def create_kings
    king1 = King.new([0, 4], true, @board)
    @board.spaces[0][4].piece = king1
    @black_pieces.push(king1)

    king2 = King.new([7, 4], false, @board)
    @board.spaces[7][4].piece = king2
    @white_pieces.push(king2)
  end

  def move(space1, space2)
    start_coordinates = space1.split("")
    start space = @board.spaces[start_space[0]][start_space[1]]
    piece = start_space.piece
    end_coordinates = space2.split("")
    end_space = @board.spaces[end_coordinates[0]][end_coordinates[1]]

    if piece.class = Pawn
      pawn_move(piece, start_space, end_space)
    elsif valid_move(piece, end_space)
      prev_piece = end_space.piece
      move_piece(piece, start_space, end_space)

      if check?(active_player, end_space)
        reverse_move(piece, prev_piece, start_space, end_space)
      else
        prev_piece&.delete
      end
    elsif piece.class == King && castling_possible(piece, end_space)
    else
      invalid_move
    end

    piece&.moved = true
    piece.find_moves
  end

  def pawn_move(piece, start_space, end_space)
    prev_piece = end_space.piece

    if piece.moves_available.include(end_space.location)
      if valid_move(piece, end_space) && end_space.piece == nil
        move_piece(piece, start_space, end_space)
      else
        invalid_move
      end
    elsif piece.captures_available.include(end_space.location) 
      if end_space.piece && end_space.piece.color != piece.color
        move_piece(piece, start_space, end_space)
      else
        invalid_move
      end
    else
      invalid_move
    end
    end

    if check?(active_player, end_space)
      reverse_move(piece, prev_piece, start_space, end_space)
    else
      prev_piece&.delete
    end
  end

  def move_piece(piece, start_space, end_space)
    end_space.piece = piece
    start_space.piece = nil
    piece.location = end_space.location
  end

  def reverse_move(piece, prev_piece, start_space, end_space)
    puts "Invalid move. This puts you in check."
    piece.location = start_space.location
    start_space.piece = piece 
    end_space.piece = prev_piece

    input
  end

  def invalid_move
    puts "Invalid move. Please choose again."
    input
  end

  def input
    puts "What piece would you like to move? (XY then press enter)"
    piece = gets.chomp
    puts "Where would you like to move it? (XY then press enter)"
    space = gets.chomp

    move(piece, space)
  end

  def valid_move(piece, end_space)
    return false unless piece.moves_available.include?(end_space)
    return false if end_space.piece && end_space.piece.color == piece.color
    return false if pass_through(piece, end_space)

    true
  end

  def pass_through(piece, end_space)
    return false if piece.instance_of?(knight)

    move = find_change(piece, end_space)
    x = piece.location[0]
    y = piece.location[1]
    spaces_passed = find_spaces_passed(x, y, end_space, move)

    spaces_passed.each do |space|
      return true if space.piece
    end
    false
  end
  
  def find_change(piece, end_space)
    x_change = end_space.location[0] - piece.location[0]
    x_change /= abs(x_change)
    y_change = end_space.location[1] - piecelocation[1]
    y_change /= abs(y_change)

    [x_change, y_change]
  end

  def find_spaces_passed(x, y, end_space, move)
    spaces_passed = []
    until x == endspace.x && y == end_space.y
      x += move[0]
      y += move[1]
      spaces_passed.push ([x, y])
    end
    spaces_passed
  end

  def check?(player, space)
    if player == @white
      @black_pieces.each do |piece|
        return true if piece.moves_available.include(@white_pieces[0].location) && valid_move(piece, @white_pieces[0].location)
      end
    elsif player == @black
      @white_pieces.each do |piece|
        return true if piece.moves_available.include(@black_pieces[0].location) && valid_move(piece, @black_pieces[0].location)
      end
    end
  end

  def checkmate?(player)
    if player == @white
      @black_pieces.each do |piece|
        piece.moves_available.each do |move|
          return false if valid_move(piece, move)
        end
      end
    elsif player == @black
      @white_pieces.each do |piece|
        piece.moves_available.each do |move|
          return false if valid_move(piece, move)
        end
      end
    end
    true
  end

  def castling_possible(king, end_space)
      return false unless king.moved == false

      if end_space.location[0] == 2
        return false if @board[0, king.location[1]]&.piece&.moved
        return false if pass_through(king, @board[0, king.location[1]])
        return false if check(@active_player, king.location)
        passed_spaces = find_spaces_passed(king.location[0], king.location[1], end_space, [-1, 0])
        passed_spaces.each do |space|
          return false if check?(@active_player, space)
        end
      elsif end_space.location[0] == 6
        return false if @board[7, king.location[1]]&.piece&.moved  
        return false if pass_through(king, @board[7, king.location[1]])
        return false if check(@active_player, king.location)
        passed_spaces = find_spaces_passed(king.location[0], king.location[1], end_space, [1, 0])
        passed_spaces.each do |space|
          return false if check?(@active_player, space)
        end
      end
    end
end

game = Game.new

game.board.display