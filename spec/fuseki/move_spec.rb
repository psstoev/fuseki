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

  it "specifies a list of invalid moves for its' successor" do
    board = Board.new 2
    move = Move.new :black, board, nil
    move.make_move(0, 0)

    move.invalid_moves.should == [[0, 0]]
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

  it 'tracks captures' do
    move1 = Move.new :black, @board, nil
    move1.make_move(0, 1)

    move2 = Move.new :white, @board, move1
    move2.make_move(0, 0)

    move3 = Move.new :black, @board, move2
    move3.make_move(1, 0)

    move3.captures.should == [[0, 0]]
    @board[0, 0].should be_empty
  end
end
