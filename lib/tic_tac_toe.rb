class TicTacToe
  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    board = ""
    @board.each_with_index do |square,i|
      board += " #{square} "
      board += (i+1) % 3 == 0 ? "\n-----------\n" : "|"
    end
    puts board
  end

  def move(position, player)
    @board[position.to_i-1] = player
  end

  def position_taken?(position)
    %w(X O).include?(@board[position])
  end

  def valid_move?(position)
    move = position.to_i - 1
    !position_taken?(move) && move.between?(0,8)
  end

  def turn_count
    @board.select {|square| %w(X O).include?(square)}.length
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def turn
    puts "Please chose a square"
    position = gets.chomp
    if valid_move?(position)
      move(position,current_player)
    else
      puts "Invalid move"
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      return "X" if combo.all? { |index| @board[index] == "X" }
      return "O" if combo.all? { |index| @board[index] == "O" }
    end
    return nil
  end

  def full?
    @board.all? { |square| square == "X" || square == "O" }
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    won?
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cats Game!"
    end
  end
end