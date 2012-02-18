require 'fuseki'

class Goban
  def initialize(game, app)
    @app = app
    @game = game
    @board_size = game.board.size
    @square_size = 100
  end

  def draw_board
    n = @board_size
    s = @square_size

    n.times do |i|
      x = (i + 1) * s
      @app.line x, s, x, n * s
      @app.line s, x, n * s, x
    end
  end

  def draw_stones
    @game.cells.each { |coords, player| draw_circle(*coords, player) }
  end

  def try_move(mouse_x, mouse_y)
    x = (mouse_x - @square_size / 2).abs / @square_size
    y = (mouse_y - @square_size / 2).abs / @square_size

    @game.move(x, y)
  end

  private

  def draw_circle(circle_x, circle_y, player)
    return if player.nil?
    padding = (@square_size / 15)
    width = @square_size - 2 * padding
    height = width
    @app.fill(player == :black ? @app.black : @app.white)
    @app.oval((circle_x + 1) * @square_size - @square_size / 2 + padding,
              (circle_y + 1) * @square_size - @square_size / 2 + padding,
              width, 
              height)
  end
end

Shoes.app width: 600, height: 600 do
  goban = Goban.new(Game.new(board: 5), self)

  background "#FFC125"
  goban.draw_board

  animate 24 do
    click do |button, x, y|
      if goban.try_move(x, y)
        clear
        background "#FFC125"
        goban.draw_board
        goban.draw_stones
      end
    end
  end
end
