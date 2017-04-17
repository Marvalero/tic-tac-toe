require 'rails_helper'

RSpec.describe MatchesController do
  context '#index' do
    let(:params) { {} }

    def do_request
      get :index, params
    end

    it 'returns 200' do
      do_request
      expect(response.status).to eq(200)
    end
  end

  context '#create' do
    let(:params) { { name: 'my match' } }

    def do_request
      get :create, params
    end

    it 'returns 302' do
      do_request
      expect(response.status).to eq(302)
    end

    it 'returns redirection header with path to new match' do
      do_request
      expect(response.headers['Location']).to match(/http:\/\/test\.host\/matches\/.*-.*-.*-.*-.*/)
    end

    it 'creates the match' do
      do_request
      my_match = Match.last
      expect(my_match.board).to eq([0,0,0,0,0,0,0,0,0])
      expect(my_match.name).to eq('my match')
    end
  end
end
