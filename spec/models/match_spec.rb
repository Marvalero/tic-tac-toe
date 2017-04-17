require 'rails_helper'

RSpec.describe Match do
  it 'generates an empty board' do
    m = Match.create(name: 'my game')
    expect(m.board).to eq([0,0,0,0,0,0,0,0,0])
  end

  it 'generates the uuid' do
    m = Match.create(name: 'my game', board: [])
    expect(m.uuid).not_to eq(nil)
  end
end
