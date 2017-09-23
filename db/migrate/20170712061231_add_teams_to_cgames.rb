class AddTeamsToCgames < ActiveRecord::Migration[5.1]
  def change
  	    add_reference :cgames, :home_team, foreign_key: true
    	add_reference :cgames, :away_team, foreign_key: true
  end
end
