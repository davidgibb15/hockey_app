class Igame < ApplicationRecord
  belongs_to :player
  belongs_to :home_team, :class_name => "Team"
  belongs_to :away_team, :class_name => "Team"
end
