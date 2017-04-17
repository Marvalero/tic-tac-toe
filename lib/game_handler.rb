class GameHandler
  class << self
    def calculate_board_status(match:, position:)
      match.tap do |m|
        m.player_moves_to_position(position)
        calculate_response(match)
      end
    end

    private

    def calculate_response(match)
      return unless match.free_position?
      position = calculate_computer_values_for_positions(match).each_with_index.max[1]
      match.computer_moves_to_position(position)
    end

    def calculate_computer_values_for_positions(match)
      values_for_positions = []
      match.board.each_with_index do |square_value, position|
        score = 0
        if square_value == 0
          score = horizontal_score(match.board, position)
          score += vertical_score(match.board, position)
          score += diagonal_score(match.board, position)
        else
          score = -100
        end
        values_for_positions[position] = score
      end
      values_for_positions
    end

    def diagonal_score(board, position)
      case position
      when 0, 4, 8
        line_rate([board[0], board[4], board[8]])
      when 2, 4, 6
        line_rate([board[2], board[4], board[6]])
      else
        0
      end
    end

    def vertical_score(board, position)
      case position
      when 0, 3, 6
        line_rate([board[0], board[3], board[6]])
      when 1, 4, 7
        line_rate([board[1], board[4], board[7]])
      when 2, 5, 8
        line_rate([board[2], board[5], board[8]])
      end
    end

    def horizontal_score(board, position)
      case position
      when 0, 1, 2
        line_rate(board[0..2])
      when 3, 4, 5
        line_rate(board[3..5])
      when 6, 7, 8
        line_rate(board[6..8])
      end
    end

    def line_rate(line)
      if line.sum == 10
        100
      elsif line.sum == 2
        10
      elsif line.sum == 5
        1
      elsif line.include?(1)
        -5
      else
        0
      end 
    end
  end
end
