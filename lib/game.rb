require_relative "board"
require_relative "player"

class Game
  def initialize
    @board = Board.new
    @players = {}
    @padding = 50
  end

  public

  def start(turn = 0)
    puts "Welcome to Tic-Tac-Toe!".center(50, '-'),
         "Player 1 will be 'o' and player 2 will be 'x'.",
         "\n"
    get_player_names
    until turn >= 9
      turn += 1
      puts "Turn #{turn}:"
      mark = mark == 'o' ? 'x' : 'o'
      play_turn(mark)
      if victory? mark
        puts "-" * 50,
             "#{@players[mark]} wins!".center(@padding, '-'),
             "-" * 50
        return
      end
    end
    puts "-" * 50,
         "It's a draw!".center(@padding, '-'),
         "-" * 50
  end

  private

  def get_player_names(name = [])
    (1..2).each do |player_number|
      until !name[player_number].nil? && name[player_number] != ""
        print "Enter name for player #{player_number}: "
        name[player_number] = gets.chomp 
      end
      mark = player_number == 1 ? 'o' : 'x'
      @players[mark] = name[player_number]
    end
  end

  def player_choice(player, mark)
    tile = 0
    while invalid? tile
      print "#{player}, choose a valid tile to mark: "
      tile = gets.chomp.to_i
    end
    tile
  end

  def mark_tile(tile, mark)
    @board.tiles[tile - 1] = mark
  end

  def play_turn(mark)
    player = @players[mark]
    @board.draw_board(@padding)
    tile = player_choice(player, mark)
    mark_tile(tile, mark)
  end

  def invalid?(tile)
    tile > 9 || tile < 1 || @board.tiles[tile - 1] == 'o' || @board.tiles[tile - 1] == 'x'
  end

  def victory?(mark)
    @board.winning_tiles.any? do |tile_group|
      tile_group.all? { |tile| @board.tiles[tile] == mark }
    end
  end
end