class AddTeamsToCgames < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :cgames, :teams, column: :home_team_id, primary_key: :id
    add_foreign_key :cgames, :teams, column: :away_team_id, primary_key: :id
  end
end
