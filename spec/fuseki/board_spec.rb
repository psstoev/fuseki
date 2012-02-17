require 'spec_helper'

describe Board do
  it 'can create board with various dimensions' do
    board = Board.new 3
  end

  it "can be indexed to retrieve its' cells" do
    board = Board.new 2
    board[0, 1].occupy :black

    board[0, 0].empty?.should be_true
    board[0, 1].empty?.should be_false
  end

  it 'can tell if it contains a cell with specified coordinates' do
    board = Board.new 2

    board.include?(0, 0).should be_true
    board.include?(0, 2).should be_false
    board.include?(-1, 0).should be_false
  end

  it "initializes its' cells properly" do
    board = Board.new 3

    board[0, 0].neighbours.size.should == 2
    board[0, 1].neighbours.size.should == 3
    board[1, 1].neighbours.size.should == 4

    board[0, 0].neighbours.map { |n| n.object_id } =~ [board[0, 1].object_id, board[1, 0].object_id]
  end
end
