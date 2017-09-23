class Team < ApplicationRecord
	has_many :players
	has_many :igames
	has_many :cgames
	def self.search(search_from,search_to)
		if search_from && search_to
  			self.where('name LIKE ? or name LIKE ?', "%#{search_from}%", "%#{search_to}%")
  		else
  			self.all
  		end
	end
end
