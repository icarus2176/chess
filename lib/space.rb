class Space
  attr_accessor :piece
  attr_reader :x, :y, :dark

  def initialize(x, y, dark)
    @x = x
    @y = y
    @dark = dark
    @piece = nil
  end
end