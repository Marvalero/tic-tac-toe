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
end
