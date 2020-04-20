require_relative "board"
require_relative "player"

class Game
  def initialize
    @players = {}
    @scores = {}
    @padding = 50
  end

  public

  def start(play = true)
    puts "Welcome to Tic-Tac-Toe!".center(50, '-'),
         "Player 1 will be 'o' and player 2 will be 'x'."
    get_player_names
    while play == true
      @board = Board.new
      rematch = ''
      (1..9).each do |turn|
        puts "Turn #{turn}:"
        mark = turn % 2 == 0 ? 'x' : 'o'
        play_turn(mark)
        puts ""
        break if victory? mark, turn
      end
      show_score
      until rematch == 'y' || rematch == 'n'
        print "Play again?(y/n) " 
        rematch = gets.chomp
      end
      play = false if rematch == 'n'
    end
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

  def player_choice(player)
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
    tile = player_choice(player)
    mark_tile(tile, mark)
  end

  def invalid?(tile)
    if tile > 9 || tile < 1
      puts "Choose a number between 1-9."
      return true
    elsif @board.tiles[tile - 1] == 'o' || @board.tiles[tile - 1] == 'x'
      puts "That tile is already taken!"
      return true
    else
      return false
    end
  end

  def victory?(mark, turn)
    player = @players[mark]
    victory = @board.winning_tiles.any? do |tile_group|
      tile_group.all? { |tile| @board.tiles[tile] == mark }
    end
    if victory
      puts "-" * 50,
           "#{player} wins!".center(@padding, '-'),
           "-" * 50
      @scores[player] = 0 unless @scores.has_key? player
      @scores[player] += 1
    elsif !victory && turn >= 9
      puts "-" * 50,
           "It's a draw!".center(@padding, '-'),
           "-" * 50
    end
    victory
  end

  def show_score
    puts "Score: "
    @scores.each_pair { |name, score| print "#{name}: #{score} " }
    puts "\n"
  end
end