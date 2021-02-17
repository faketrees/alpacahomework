class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
        take_turn
        round_success_message
        sleep 0.25
        system("clear")
    end

      game_over_message
      reset_game
  end

  def take_turn
    show_sequence
    require_sequence

    if !game_over
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      p color 
      sleep 0.75
      system ("clear")
    end
  end

  def require_sequence
    puts "Please enter the sequence with colors seperated by spaces"
    input = gets.chomp.downcase
    arr_input = input.split(" ")
    @seq.each_with_index do |color, i|
      if color != arr_input[i]
        @game_over = true
        break
      end
    end
    sleep 0.5
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "You've made it to the next round. For now....."
  end

  def game_over_message
    puts "You made it to round #{@sequence_length - 1}"
  end

  def reset_game
    @sequence_length = 1
    @seq = []
    @game_over = false
  end
end

