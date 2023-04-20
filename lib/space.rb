class Space
  attr_accessor :empty
  attr_reader :x, :y, :dark

  def initialize(x, y, dark)
    @x = x
    @y = y
    @dark = dark
    @empty = true
  end
end