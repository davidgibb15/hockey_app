class Team < ApplicationRecord
	has_many :players
	has_many :igames_home, :class_name => 'Igame', :foreign_key => 'home_game_id'
	has_many :igames_away, :class_name => 'Igame', :foreign_key => 'away_game_id'
	has_many :cgames_home, :class_name => 'Cgame', :foreign_key => 'home_game_id'
	has_many :cgames_away, :class_name => 'Cgame', :foreign_key => 'away_game_id'
	def self.search(search_from,search_to)
		if search_from && search_to
  			self.where('name LIKE ? or name LIKE ?', "%#{search_from}%", "%#{search_to}%")
  		else
  			self.all
  		end
	end
end
