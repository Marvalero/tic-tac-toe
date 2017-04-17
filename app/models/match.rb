class Match < ApplicationRecord
  self.primary_key = 'uuid'
  before_save :generate_default_values

  PLAYER = 1.freeze
  COMPUTER = 5.freeze
  EMPTY = 0.freeze

  def board
    @board ||= self.serialized_board && self.serialized_board.split(',').map(&:to_i)
  end

  def board=(value)
    self.serialized_board = value.join(',')
    @board = value
  end

  def player_moves_to_position(position)
    return unless position
    current_board = self.board
    current_board[position] = Match::PLAYER
    self.board = current_board
  end

  def computer_moves_to_position(position)
    return unless position
    current_board = self.board
    current_board[position] = Match::COMPUTER
    self.board = current_board
  end

  def free_position?
    board.sum < (COMPUTER*4 + 5*PLAYER)
  end

  private

  def generate_default_values
    generate_uuid
    generate_board
  end

  def generate_uuid
    return if uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_board
    return if board
    self.board = [0,0,0,0,0,0,0,0,0]
  end
end
