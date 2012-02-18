class Game
  DEFAULT_SIZE = 5

  attr_accessor :player, :board

  def initialize(opts = {})
    @board = Board.new(opts[:board] || DEFAULT_SIZE)
    @player = :black
    @moves = []
    next_move
  end

  def move(x, y)
    if @moves[-1].make_move(x, y)
      change_player
      next_move
    end
  end

  def cells
    Hash.new(@board.cells.map do |coords, cell|
      [coords, cell.player]
    end.flatten(1))
  end

  private

  def change_player
    @player = (@player == :black) ? :white : :black
  end

  def next_move
    @moves << Move.new(@player, @board, @moves[-1])
  end
end
