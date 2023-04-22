require_relative "space"
require "colorize"

class Board
  attr_reader :spaces

  def initialize
    @spaces = Array.new(8)

    @spaces.each_with_index do |row, x|
      add = Array.new(8)
      add.each_with_index do |column, y|
        color = (x - y).odd?
        add[y] = Space.new(x, y, color)
      end
      @spaces[x] = add
    end
  end

  def display
    puts "  0 1 2 3 4 5 6 7"
    @spaces.each_with_index do |row, index|
       output = index.to_s + " "
       row.each do |space|
        if space.piece == nil
          add = "  ".on_black
        else
         add = (space.piece.symbol + " ").on_black
        end
         if space.dark
           add = add.on_red
         end
         output += add
       end
       puts output
     end
   end
end