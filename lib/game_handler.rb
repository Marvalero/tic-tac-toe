class GameHandler
  class << self
    def calculate_board_status(match:, position:)
      return match if match.board[position] != Match::EMPTY

      match.tap do |m|
        m.player_moves_to_position(position)
        calculate_response(match)
      end
    end

    private

    def calculate_response(match)
      return if match.finished || !match.free_position?
      position_scores = calculate_computer_values_for_positions(match)
      position = position_scores.each_with_index.max[1]
      match.finished = true if position_scores[position] > 20

      match.computer_moves_to_position(position)
    end

    def calculate_computer_values_for_positions(match)
      [0,0,0,0,0,0,0,0,0].tap do |values_for_positions|
        ocupated_score(values_for_positions, match.board)
        horizontal_score(values_for_positions, match.board)
        vertical_score(values_for_positions, match.board)
        diagonal_score(values_for_positions, match.board)
      end
    end

    def ocupated_score(values_for_positions, board)
      board.each_with_index do |square, position|
        if square != 0
          values_for_positions[position] = -100
        end
      end
    end

    def diagonal_score(values_for_positions, board)
      score_line([0, 4, 8], board, values_for_positions)
      score_line([2, 4, 6], board, values_for_positions)
    end

    def vertical_score(values_for_positions, board)
      score_line([0, 3, 6], board, values_for_positions)
      score_line([1, 4, 7], board, values_for_positions)
      score_line([2, 5, 8], board, values_for_positions)
    end

    def horizontal_score(values_for_positions, board)
      score_line([0, 1, 2], board, values_for_positions)
      score_line([3, 4, 5], board, values_for_positions)
      score_line([6, 7, 8], board, values_for_positions)
    end

    def score_line(positions, board, scores)
      score = line_rate(positions.map { |i| board[i] })
      positions.each { |i| scores[i] += score}
    end

    def line_rate(line)
      if line.sum == 10
        30
      elsif line.sum == 2
        5
      elsif line.sum == 5
        1
      elsif line.include?(1)
        -1
      else
        0
      end 
    end
  end
end
