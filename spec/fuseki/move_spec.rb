require 'spec_helper'

describe Move do
  before :each do
    @board = Board.new 5
  end

  it 'can create moves' do
    move = Move.new :black, @board, nil
  end

  it 'can make simple moves' do
    move = Move.new :black, @board, nil
    move.make_move(2, 2).should be_true
    @board[2, 2].player.should == :black
  end

  it 'has simple constraints on the moves' do
    move = Move.new :black, @board, nil
    move.make_move(2, 2).should be_true
    @board[2, 2].player.should == :black

    move.make_move(2, 2).should be_false
    move.make_move(-1, 0).should be_false
  end

  it 'prevents suicide of single stones' do
    move1 = Move.new :black, @board, nil
    move1.make_move(0, 1)

    move2 = Move.new :white, @board, move1
    move2.make_move(4, 4)

    move3 = Move.new :black, @board, move2
    move3.make_move(1, 0)

    move4 = Move.new :white, @board, move3
    move4.make_move(0, 0).should be_false
    @board[0, 0].should be_empty
  end

  it 'makes a difference between suicide and capture' do
    move1 = Move.new :black, @board, nil
    move1.make_move(0, 1)

    move2 = Move.new :white, @board, move1
    move2.make_move(1, 1)

    move3 = Move.new :black, @board, move2
    move3.make_move(1, 0)

    move4 = Move.new :white, @board, move3
    move4.make_move(0, 2)

    move5 = Move.new :black, @board, move4
    move5.make_move(4, 4)

    move6 = Move.new :white, @board, move5
    move6.make_move(0, 0).should be_true
    @board[0, 0].player.should == :white
  end

  it 'does not count placing next to "friendly" stones as suicide' do
    move1 = Move.new :black, @board, nil
    move1.make_move(0, 1)

    move2 = Move.new :black, @board, move1
    move2.make_move(1, 0)

    move3 = Move.new :black, @board, move2
    move3.make_move(0, 0).should be_true
  end

  it "doesn't violate the ko rule" do
    move1 = Move.new :black, @board, nil
    move1.make_move(0, 1)

    move2 = Move.new :white, @board, move1
    move2.make_move(1, 1)

    move3 = Move.new :black, @board, move2
    move3.make_move(1, 0)

    move4 = Move.new :white, @board, move3
    move4.make_move(0, 2)

    move5 = Move.new :black, @board, move4
    move5.make_move(4, 4)

    move6 = Move.new :white, @board, move5
    move6.make_move(0, 0)

    move7 = Move.new :black, @board, move6
    move7.make_move(0, 1).should be_false
  end
end
