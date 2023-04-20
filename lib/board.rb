require_relative "space.rb"
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
    @spaces.each do |row|
       output = ""
       row.each do |space|
         add = space.piece
         if space.dark
           add = add.on_red
         end
         output += add
       end
       puts output
     end
   end
end