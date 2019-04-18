class MatchesController < ApplicationController
  before_action :assign_match

  def assign_match
    @match = Match.find(params[:match_id])
  end
end
