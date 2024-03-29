class Group
  attr_reader :cells

  def initialize
    @cells = []
  end

  def contains?(a_cell)
    not @cells.select { |cell| cell.equal? a_cell }.empty?
  end

  def add_cell(cell)
    @cells << cell unless contains? cell
  end

  def join_cells_of(other_group)
    other_group.cells.each do |cell|
      add_cell cell
      cell.group = self
    end
  end

  def liberties
    @liberties = []
    @cells.each do |cell|
      @liberties += cell.liberties.select do |liberty|
        @liberties.index(liberty).nil?
      end.to_a
    end
    @liberties
  end
end
