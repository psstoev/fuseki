require 'spec_helper'

describe Cell do
  it 'creates a new cell' do
    Cell.new
  end

  it 'can be occupied by a player' do
    cell = Cell.new
    cell.occupy :black
  end

  it "can tell if it's empty" do
    cell = Cell.new
    cell.empty?.should be_true

    cell.occupy :white
    cell.empty?.should be_false
  end

  it 'can be unoccupied' do
    cell = Cell.new

    cell.occupy :black
    cell.empty?.should be_false

    cell.unoccupy
    cell.empty?.should be_true
  end

  it 'tells which player has stone in it' do
    cell = Cell.new

    cell.occupy :black
    cell.player.should == :black
  end

  it "can store information about its' neighbours" do
    cell1 = Cell.new
    cell1.add_neighbour Cell.new
  end

  it "can show information about its' neighbours" do
    cell1 = Cell.new
    cell2 = Cell.new

    cell1.add_neighbour cell2
    cell2.add_neighbour cell1

    cell1.neighbours.size.should == 1
    cell2.neighbours.size.should == 1
  end
end
