class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.references :team, foreign_key: true
      t.boolean :lw
      t.boolean :rw
      t.boolean :c
      t.boolean :d
      t.boolean :g

      t.timestamps
    end
  end
end
