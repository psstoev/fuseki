class Move
  attr_accessor :captures

  def initialize(player, board, previous)
    @player, @board, @previous = player, board, previous
    @captures = []
  end

  def make_move(x, y)
    if legal?(x, y)
      @board[x, y].occupy @player
      capture
      return true
    end

    false
  end

  private

  def legal?(x, y)
    @board.include?(x, y) &&
      @board[x, y].empty? &&
      suicides.index(@board[x, y]).nil? &&
      not_ko?(x, y)
  end

  def not_ko?(x, y)
    @previous.nil? ||
      @previous.captures.count != 1 || 
      @previous.captures[0] != [x, y]
  end

  def suicide?(cell)
    cell.empty? && cell.liberties.count == 0 &&
      cell.neighbours.none? { |neighbour| neighbour.player == @player && neighbour.group.liberties.count > 1 } &&
      !cell.neighbours.any? { |neighbour| neighbour.player != @player && neighbour.group.liberties.count == 1}
  end

  def suicides
    # Take only the cells
    @board.cells.select { |coords, cell| suicide? cell }.values
  end

  def capture
    dead_groups = @board.groups.select do |group|
      group.cells[0].player != @player && group.liberties.count == 0
    end
    dead_groups.each do |group|
      @captures += group.cells.map { |cell| @board.cells.key(cell) }
    end
    remove_captured
  end

  def remove_captured
    @captures.each do |capture|
      @board[*capture].unoccupy
    end
  end
end
