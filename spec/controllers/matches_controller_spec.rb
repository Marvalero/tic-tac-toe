require 'rails_helper'

RSpec.describe MatchesController do
  context '#index' do
    let(:params) { {} }

    def do_request
      get :index, params: params
    end

    it 'returns 200' do
      do_request
      expect(response.status).to eq(200)
    end
  end

  context '#create' do
    let(:params) { { name: 'my match' } }

    def do_request
      get :create, params: params
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

  context '#show' do
    def do_request
      get :show, params: params
    end

    context 'when match exists' do
      let(:match) { Match.create(name: 'Wonderful Match') }
      let(:params) { { uuid: match.uuid } }

      it 'returns 200' do
        do_request
        expect(response.status).to eq(200)
      end
    end

    context 'when match does not exists' do
      let(:params) { { uuid: 'this-does-no-exists' } }

      it 'returns 404' do
        do_request
        expect(response.status).to eq(404)
      end
    end
  end

  context '#destroy' do
    let(:match) { Match.create(name: 'Wonderful Match') }
    let(:params) { { uuid: match.uuid } }

    def do_request
      get :destroy, params: params
    end

    it 'returns 302' do
      do_request
      expect(response.status).to eq(302)
    end

    it 'returns redirection header with path to new match' do
      do_request
      expect(response.headers['Location']).to eq("http://test.host/matches")
    end

    it 'deletes the match' do
      do_request
      my_match = Match.find_by(uuid: match.uuid)
      expect(my_match).to eq(nil)
    end
  end

  context '#update' do
    let(:match) { Match.create(name: 'Wonderful Match') }
    let(:params) { { uuid: match.uuid, square_position: "0" } }

    def do_request
      get :update, params: params
    end

    it 'returns 302' do
      do_request
      expect(response.status).to eq(302)
    end

    it 'returns redirection header with path to new match' do
      do_request
      expect(response.headers['Location']).to eq("http://test.host/matches/#{match.uuid}")
    end

    it 'calculates the match response' do
      do_request
      match.reload
      expect(match.board.reduce(&:+)).to eq(6)
    end
  end
end
