require "test/unit"
require "sudoku.rb"


class SudokuTester < Test::Unit::TestCase

  @@sudokus_file = File.open(File.join(File.dirname(__FILE__),'sudokus_gth_level_88'))
  @@solutions_file = File.open(File.join(File.dirname(__FILE__),'sudokus_gth_level_88_solved'))


  def setup
    @sudokus, @solutions = sudokus(@@sudokus_file),sudokus(@@solutions_file)
  end

  def test_hard_sudokus
    @sudokus.each_with_index do |sudoku,i|
      sudoku.solve
      assert sudoku == @solutions[i]
    end
  end

  private

  def sudokus (file)
    file.map {|l|Sudoku.new(l.split(",").map {|x| x.to_i})}
  end


end