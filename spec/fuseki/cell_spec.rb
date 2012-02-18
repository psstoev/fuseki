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

  it 'starts belonging to a group when occupied' do
    cell = Cell.new

    cell.occupy :black
    cell.group.should_not be_nil
  end

  it 'starts belonging to a neightbour group with the same color when occupied' do
    cell1 = Cell.new
    cell2 = Cell.new

    cell1.add_neighbour cell2
    cell2.add_neighbour cell1

    cell1.occupy :black
    cell2.occupy :black

    cell2.group.object_id.should == cell1.group.object_id
  end

  it 'stops belonging to a group when unoccupied' do
    cell = Cell.new

    cell.occupy :white
    cell.group.should_not be_nil

    cell.unoccupy
    cell.group.should be_nil
  end
  
  it 'has some textual representation' do
    cell = Cell.new

    cell.to_s.should == '#'
    cell.occupy :black
    cell.to_s.should == 'b'
  end

  it 'can connect two or more groups' do
    cell1 = Cell.new
    cell2 = Cell.new
    cell3 = Cell.new

    cell1.add_neighbour cell2
    cell3.add_neighbour cell2
    cell2.add_neighbour cell1
    cell2.add_neighbour cell3

    cell1.occupy :black
    cell3.occupy :black
    cell1.group.object_id.should_not == cell3.group.object_id

    cell2.occupy :black
    cell1.group.object_id.should == cell2.group.object_id
    cell2.group.object_id.should == cell3.group.object_id
  end
end
