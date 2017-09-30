class AddTeamsToCgames < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :igames, :teams, column: :home_team_id, primary_key: :id
    add_foreign_key :igames, :teams, column: :away_team_id, primary_key: :id
  end
end
