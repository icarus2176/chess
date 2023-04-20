class Space
  attr_accessor :empty
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    @empty = true
  end
end