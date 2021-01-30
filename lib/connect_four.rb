require_relative "player"


class ConnectFour

  def initialize
    @array = Array.new
    make_array
    @player_one = nil
    @player_two = nil
    @over = false
  end

  def make_array
    @array = 
    [ 
      ["_","_","_","_","_","_","_"],
      ["_","_","_","_","_","_","_"],
      ["_","_","_","_","_","_","_"],
      ["_","_","_","_","_","_","_"],
      ["_","_","_","_","_","_","_"],
      ["_","_","_","_","_","_","_"],
    ]
         #0   1   2   3   4   5   6
     #0 ["_","_","_","_","_","_","_"],
     #1 ["_","_","_","_","_","_","_"],
     #2 ["_","_","_","_","_","_","_"],
     #3 ["_","_","_",3,3,"_","_","_"],
     #4 ["_","_","_","_","_","_","_"],
     #5 ["_","_","_","_","_","_","_"],

     #diagonal [-1,-1][1,1][1,-1][-1,1]
     #horizontal [1,0][-1,0]
     #vertical [0,-1][0,1]
     
     
  end

  def show_board
    side =  "\u{2501}"
    r_top = "\u{250F}"
    l_top = "\u{2513}"
    r_bot = "\u{2517}"
    l_bot = "\u{251B}"

    line = "\u{2503}"
    cross = "\u{2547}"

    board = 
    [
      [line,"1",line,"2",line,"3",line,"4",line,"5",line,"6",line,"7",line,"\n"],
      [line,@array[0][0],line,@array[0][1],line,@array[0][2],line,@array[0][3],line,@array[0][4],line,@array[0][5],line,@array[0][6],line,"\n"],
      [line,@array[1][0],line,@array[1][1],line,@array[1][2],line,@array[1][3],line,@array[1][4],line,@array[1][5],line,@array[1][6],line,"\n"],
      [line,@array[2][0],line,@array[2][1],line,@array[2][2],line,@array[2][3],line,@array[2][4],line,@array[2][5],line,@array[2][6],line,"\n"],
      [line,@array[3][0],line,@array[3][1],line,@array[3][2],line,@array[3][3],line,@array[3][4],line,@array[3][5],line,@array[3][6],line,"\n"],
      [line,@array[4][0],line,@array[4][1],line,@array[4][2],line,@array[4][3],line,@array[4][4],line,@array[4][5],line,@array[4][6],line,"\n"],
      [line,@array[5][0],line,@array[5][1],line,@array[5][2],line,@array[5][3],line,@array[5][4],line,@array[5][5],line,@array[5][6],line,"\n"],
      [r_bot,side,side,side,side,side,side,side,side,side,side,side,side,side,l_bot,"\n"]
    ]
    printer(board[0])
    printer(board[1])
    printer(board[2])
    printer(board[3])
    printer(board[4])
    printer(board[5])
    printer(board[6])
    printer(board[7])
    
  end

  def printer(array)
    array.each {|n| print n}
  end

  def player_turn(player)
    puts "#{player.name}s turn:"
    number = gets.chomp
    update_board(number.to_i,player) if validate_number(number)
    if validate_number(number) == nil
      puts "Wrong number try again"
      player_turn(player)
    end
  end

  def make_players
    puts "Enter player one name:"
    name_one = gets.chomp
    puts "Enter player two name:"
    name_two = gets.chomp
    @player_one = Player.new(name_one,"\u{2687}") if validate_name(name_one)
    @player_two = Player.new(name_two,"\u{2689}") if validate_name(name_two)
  end

  def validate_name(string)
    return string if string.match(/[a-zA-Z]/)
  end

  def update_board(row,player)
    index = 5
    if @array[0][row-1] != "_"
      puts "Row is full, enter new number"
      player_turn(player)
    end

    6.times do
      if @array[index][row-1] == "_"
        @array[index][row-1] = player.icon
        check_winner([index,row-1],player)
        check_if_sucessfull = true
        break
      end
      index -= 1
    end
    show_board
  end

  def validate_number(number)
    number = number.to_i
    return number if number.between?(1,7)
  end

  def game_loop(p1,p2)

    loop do
      player_turn(p1)
      break if game_over
      player_turn(p2)
      break if game_over
    end

  end

  def game_over
    @over    
  end

  def check_winner(array,player = nil)
    diagonal_one = [[-1,-1],[1,1]]
    diagonal_two = [[1,-1],[-1,1]]
    horizontal = [[0,1],[0,-1]]
    vertical = [[1,0],[-1,-0]]

    icon = player.icon

    @over = true if test_array(array,diagonal_one).include?("#{icon}#{icon}#{icon}#{icon}")
    @over = true if test_array(array,diagonal_two).include?("#{icon}#{icon}#{icon}#{icon}")
    @over = true if test_array(array,horizontal).include?("#{icon}#{icon}#{icon}#{icon}")
    @over = true if test_array(array,vertical).include?("#{icon}#{icon}#{icon}#{icon}")

    puts "Winner is: #{player.name}" if @over == true
  end

  def test_array(array,compare)

    test = []
    two = Array.new(7,"")


      compare.each do |n|

        y = array[0]
        x = array[1]


          two[x] = @array[y][x] if n[1] != 0
          two[y] = @array[y][x] if n[1] == 0

        #test.push(@array[y][x]) if test.empty?

        loop do
           y += n[0]
           x += n[1]
           break if y < 0 || y > 5
           break if x < 0 || x > 6
           #p @array[y][x]
           test.push(@array[y][x])
           two[x] = @array[y][x] if n[1] != 0
           two[y] = @array[y][x] if n[1] == 0
        end
      end
       two.join("")
      #test.join("")
  end

  def play
    welcome
    show_board
    make_players
    game_loop(@player_one,@player_two)

  end

  private

  def welcome
    puts "Welcome to Connect Four"
    puts "Enter 1- 7 to place your icon"
    puts "First to four horizontal,vertical or diagonal icons win"
    puts "GL"
  end

end



anna = Player.new("anna","\u{2687}")
emma = Player.new("emma","\u{2689}")

game = ConnectFour.new
game.play