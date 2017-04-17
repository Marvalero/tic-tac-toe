class MatchesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @matches = Match.all
  end

  def create
    @match = Match.create!(name: params[:name])
    redirect_back(fallback_location: { action: "show", uuid: @match.uuid })
  end

  def show
    @match = Match.find_by(uuid: params[:uuid])
    if @match
      render
    else
      head 404
    end
  end

  def update
    respond_to do |format|
      format.html { redirect_to match_path }
      format.json { render json: {} }
    end
  end

  def destroy
    @match = Match.find_by(uuid: params[:uuid])
    @match.destroy
    redirect_back(fallback_location: { action: "index" })
  end
end
