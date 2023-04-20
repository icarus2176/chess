require_relative "space.rb"

class Board
  attr_reader :spaces

  def initialize
    @spaces = Array.new(8)

    @spaces.each_with_index do |row, x|
      row = Array.new(8)
      row.each_with_index do |column, y|
          row[y] = Space.new(x, y, (x - y).odd?)
      end
    end
  end
end