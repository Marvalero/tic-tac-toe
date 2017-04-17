class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def create
    @match = Match.create!(name: params[:name])
    redirect_back(fallback_location: { action: "show", uuid: @match.uuid })
  end
end
