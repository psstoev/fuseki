require 'spec_helper'

describe Game do
  it 'starts a new game' do
    Game.new board: 3
    Game.new
  end

  it 'shows whose turn it is' do
    game = Game.new
    game.player.should == :black
  end

  it 'makes moves' do
    game = Game.new
    game.move(0, 0)

    game.player.should == :white
    game.board[0, 0].player.should == :black
  end

  it 'shows the cells' do
    game = Game.new board: 2
    game.cells.should == {[0, 0] => nil, [0, 1] => nil, [1, 0] => nil, [1, 1] => nil}

    game.move(0, 0)
    game.cells.should == {[0, 0] => :black, [0, 1] => nil, [1, 0] => nil, [1, 1] => nil}
  end

  it 'does not mess the moves' do
    game = Game.new
    game.move(0, 0)
    game.move(0, 0)

    game.player.should == :white
  end
end
