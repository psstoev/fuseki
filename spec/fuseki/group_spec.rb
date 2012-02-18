require 'spec_helper'

describe Group do
  it 'can add cells to self' do
    group = Group.new
    group.add_cell Cell.new
  end

  it 'can check if it contains a particular cell' do
    cell1 = Cell.new
    cell2 = Cell.new

    group = Group.new
    group.add_cell cell1

    group.contains?(cell1).should be_true
    group.contains?(cell2).should be_false
  end

  it 'can add cell to self only once' do
    cell = Cell.new
    group = Group.new

    group.add_cell cell
    group.add_cell cell

    group.cells.count.should == 1
  end

  it 'can add adjacent cells of the same color to self' do
    cell1 = Cell.new
    cell2 = Cell.new

    cell1.add_neighbour cell2
    cell2.add_neighbour cell1

    cell1.occupy :black
    cell1.group.cells.count.should == 1

    cell2.occupy :black
    cell1.group.cells.count.should == 2
  end

  it 'can join the cells in another group to self' do
    cell1 = Cell.new
    cell2 = Cell.new

    cell1.add_neighbour cell2
    cell2.add_neighbour cell1

    group1 = Group.new
    group2 = Group.new
    group1.add_cell cell1
    group2.add_cell cell2

    group1.join_cells_of group2
    group1.cells.count.should == 2
    cell2.group.object_id.should == group1.object_id
  end

  it 'has the correct number of liberties' do
    cell1 = Cell.new
    cell2 = Cell.new

    cell1.add_neighbour cell2
    cell2.add_neighbour cell1

    cell1.occupy :black
    cell1.group.liberties.count.should == 1
  end
end
