class CreateCgames < ActiveRecord::Migration[5.1]
  def change
    create_table :cgames do |t|
      t.string :name
      t.integer :games_played
      t.references :player, foreign_key: true
      t.references :home_team
      t.references :away_team
      t.boolean :home
      t.string :pos
      t.date :date
      t.integer :goals
      t.integer :assists
      t.integer :points
      t.integer :plus_minus
      t.integer :pim
      t.integer :ppg
      t.integer :ppa
      t.integer :ppp
      t.integer :shg
      t.integer :sha
      t.integer :shp
      t.integer :gwg
      t.integer :otg
      t.integer :shots
      t.integer :toi
      t.integer :shifts
      t.integer :hits
      t.integer :blocks
      t.integer :mss
      t.integer :gva
      t.integer :tka
      t.integer :fo
      t.integer :fow
      t.integer :fol

      t.timestamps
    end
  end
end
