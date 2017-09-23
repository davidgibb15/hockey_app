class PlayersController < ApplicationController
  def show
  	@player =Player.first
  	@games = Igame.where(player_id: 1)
  	@goals=[1,2,3,4,5,6,7,8]
  end
  def new
  end
end
