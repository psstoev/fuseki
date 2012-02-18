class Board
  NEIGHBOURS_COORDS = [[-1, 0], [0, -1], [1, 0], [0, 1]].freeze

  def initialize(size)
    @size = size
    @cells = {}
    make_cells
    @cells.each { |coords, cell| introduce_neighbours coords, cell }
  end

  def to_s
    (0...@size).map do |x|
      (0...@size).map { |y| self[x, y] }.join ''
    end.join "\n"
  end

  def [](x, y)
    @cells[[x, y]]
  end

  def include?(x, y)
    !@cells[[x, y]].nil?
  end

  private

  def make_cells
    (0...@size).to_a.product((0...@size).to_a).each do |coords|
      @cells[[*coords]] = Cell.new
    end
  end

  def introduce_neighbours(coords, cell)
    NEIGHBOURS_COORDS.each do |dcoords|
      x, y = coords[0] + dcoords[0], coords[1] + dcoords[1]
      if (0...@size).include?(x) && (0...@size).include?(y)
        cell.add_neighbour @cells[[x, y]]
      end
    end
  end
end
