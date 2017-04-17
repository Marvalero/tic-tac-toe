class Match < ApplicationRecord
  before_save :generate_default_values
  before_save :serialize_board

  private

  def generate_default_values
    generate_uuid
    generate_board
  end

  def serialize_board
    self.board = self.board.join(',')
  end

  def generate_uuid
    return if uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_board
    return if board
    self.board = [0,0,0,0,0,0,0,0,0]
  end

  def board
  end

  def board=(value)
  end
end
