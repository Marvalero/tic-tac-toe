class Match < ApplicationRecord
  self.primary_key = 'uuid'
  before_save :generate_default_values

  def board
    @board ||= self.serialized_board && self.serialized_board.split(',').map(&:to_i)
  end

  def board=(value)
    self.serialized_board = value.join(',')
    @board = value
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
