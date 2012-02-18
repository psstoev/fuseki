class Cell
  attr_reader :player, :neighbours
  attr_accessor :group

  def initialize
    @neighbours = []
  end

  def to_s
    return '#' if empty?

    @player.to_s[0]
  end

  def occupy(player)
    @player = player
    @group = add_to_group
    @group.add_cell self
    merge_groups
  end

  def empty?
    @player.nil?
  end

  def unoccupy
    @player = nil
    @group = nil
  end

  def add_neighbour(other)
    @neighbours << other
  end

  def add_to_group
    same_cells = same_color_neighbours
    return Group.new if same_cells.empty?

    same_cells[0].group
  end

  private

  def same_color_neighbours
    @neighbours.select { |neighbour| neighbour.player == @player }
  end

  def merge_groups
    same_color_neighbours.each do |neighbour|
      @group.join_cells_of neighbour.group
    end
  end
end
