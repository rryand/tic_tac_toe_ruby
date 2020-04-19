class Board
  attr_reader :tiles, :winning_tiles
  def initialize
    @tiles = %w[1 2 3 4 5 6 7 8 9]
    @winning_tiles = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
  end

  def draw_board(padding = 0)
    puts "#{@tiles[0]} | #{@tiles[1]} | #{@tiles[2]}".center(padding),
         "#{@tiles[3]} | #{@tiles[4]} | #{@tiles[5]}".center(padding),
         "#{@tiles[6]} | #{@tiles[7]} | #{@tiles[8]}".center(padding),
         "\n"
  end
end