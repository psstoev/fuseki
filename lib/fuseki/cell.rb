class Cell
  attr_reader :player, :neighbours

  def initialize
    @neighbours = []
  end

  def occupy(player)
    @player = player
  end

  def empty?
    @player.nil?
  end

  def unoccupy
    @player = nil
  end

  def add_neighbour(other)
    @neighbours << other
  end
end
