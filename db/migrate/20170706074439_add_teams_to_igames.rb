class AddTeamsToIgames < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :igames, :teams, column: :home_team, primary_key: :id
    add_foreign_key :igames, :teams, column: :away_team, primary_key: :id
  end
end
