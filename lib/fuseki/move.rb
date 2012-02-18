class Move
  attr_accessor :captures

  def initialize(player, board, previos)
    @player, @board, @previos = player, board, previos
    @invalid = (previos.nil?) ? [] : previos.invalid_moves
    @captures = []
  end

  def make_move(x, y)
    if legal(x, y)
      @board[x, y].occupy @player
      @invalid << [x, y]
      capture
      return true
    end

    false
  end

  def invalid_moves
    @invalid + suicides
  end

  private

  def legal(x, y)
    @board.include?(x, y) &&
      @board[x, y].empty? &&
      @invalid.index([x, y]).nil?
  end

  def suicides
    @board.cells.select do |coords, cell|
      cell.empty? && cell.liberties.count == 0
    end.map { |coords, cell| coords }.to_a
  end

  def capture
    dead_groups = @board.groups.select do |group|
      group.cells[0].player != @player && group.liberties.count == 0
    end
    dead_groups.each do |group|
      @captures += group.cells.map { |cell| @board.cells.key(cell) }
    end
    @captures.each { |capture| @board[*capture].unoccupy }
  end
end
